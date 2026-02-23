/**
 * @class pddlalltime
 * @author Miquel Bofill
 * @version 1.0
 * @date 2016-06-01
 * @brief Compiler from a restricted subset of PDDL 3.1 to SMT 2.6
 * @see http://smtlib.cs.uiowa.edu/language.shtml
 */

import fr.uga.pddl4j.parser.*;
import java.io.FileNotFoundException;
import java.util.List;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.Map;
import java.util.Map.Entry;
import java.util.TreeMap;
import java.util.Set;
import java.util.TreeSet;
import java.util.Iterator;
import java.util.HashSet;
import java.util.HashMap;

public class pddlalltime {

    private static final String QUANTIFY_ALL = "all";
    private static final String QUANTIFY_TIME = "time";

    /// @pre Program has been called with arguments <tt> -o
    /// operator_file_name -f fact_file_name -q quantify </tt> where
    /// <tt> quantify </tt> can be <tt> all </tt> (quantify time and
    /// objects) or <tt> time </tt> (quantify only time)

    /// @post Outputs an SMT2 tranlation of the PDDL instance
    /// defined by \c operator_file_name and \c fact_file_name.
    public static void main(String[] args) throws Exception {
	if (args.length == 6 && args[0].equals("-o") && args[2].equals("-f")
	    && args[4].equals("-q") && isValidQuantifier(args[5])) {
	    Parser parser = new Parser();
	    try {
		parser.parse(args[1], args[3]);
		Domain d = parser.getDomain();
		Problem p = parser.getProblem();
		printPreamble();
		translate(d,p,args[5]);
	    } catch (Exception e) {
		System.err.println();
		System.err.println("Error processing " + args[1] + " + " + args[3]);
		System.err.println();
		e.printStackTrace();
	    }
	    if (!parser.getErrorManager().isEmpty()) {
		parser.getErrorManager().printAll();
	    }
	} else {
	    System.out.println("\nCompiler from a restricted subset of PDDL 3.1 to SMT 2.6 with quantifiers (experimental version).\n");
	    System.out.println("Usage:\n");
	    System.out.println("OPTIONS          DESCRIPTIONS\n");
	    System.out.println("-o <str>         operator file name");
	    System.out.println("-f <str>         fact file name");
	    System.out.println("-q all | time    quantify all (time and objects) or only time");
	    System.out.println("                 (this compiler only supports quantified mode)\n");
	}
    }

    private static boolean isValidQuantifier(String quantifier) {
	return QUANTIFY_ALL.equals(quantifier) || QUANTIFY_TIME.equals(quantifier);
    }

    /// @post Outputs the fixed preamble.
    private static void printPreamble() {
	//	System.out.println(";; (set-logic UFLIA)"); // CVC4 complaints of data types
	System.out.println("(set-info :source |\nThis benchmark was automatically translated into SMT-LIB format from PDDL 3.1 format. Contact Miquel Bofill <miquel.bofill@udg.edu> for more information.\n|)");
	System.out.println(";; (set-info :smt-lib-version 2.6)"); // CVC4 complaints version unsupported
	System.out.println("(set-info :category \"crafted\")");
	System.out.println("(set-info :status sat)\n");
	System.out.println("(set-option :produce-models true)\n");
	//	System.out.println("(set-option :fmf-bound-int true)\n"); //CVC4
	System.out.println("(define-sort _time () Int)\n");	
    }
    

    /// @pre \p quantify equals "all" or "time".
    
    /// @post Outputs an SMT2 tranlation of the PDDL instance defined
    /// by \p d and \p p. If \p quantify equals "all" then time and
    /// all objects are quantified. If \p quantify equals "time" then
    /// only time is quantified.
    private static void translate(Domain d, Problem p, String quantify) throws Exception {
	Map<String,List<String>> dtypes = dataTypes(d,p);
	printDataTypes(dtypes);
	Map<String,List<String>> subtypes = baseSubtypes(d,dtypes.keySet());
	Set<String> basetypes = valuesOf(subtypes);
	Map<String,List<Integer>> renArgs = unfold(d,subtypes,basetypes);
	Map<ComparableExp,List<Op>> modifiedLits = modified(d);
	Set<String> dtime = collectNames(modifiedLits.keySet());
	Map<String,String> objTypes = collectTypes(p);
	updateNames(p,renArgs,objTypes);
	Map<String,Integer> constFunc = constants(p,modifiedLits.keySet());
	printFunctions(d,dtime);
	printActions(d.getOperators());
	printTransitionFunction(d,modifiedLits,dtime,dtypes,quantify,constFunc);
	printInitialState(d,p,dtypes,dtime,quantify,constFunc.keySet());
	printGoal(p,dtime);
	System.out.println("\n(declare-const _n _time)\n");
	System.out.println("(assert (and init (or (goal 0) (and (<= 0 _n) (trans _n) (goal (+ _n 1))))))\n");
	System.out.println("(check-sat)");
	System.out.println("(get-model)");
	System.out.println("(exit)");
    }


    /// @pre \p s contains only expressions with connectives ATOM,
    /// NOT, and FN_HEAD.
    
    /// @return A set with the predicate and function names in \p s.
    private static Set<String> collectNames(Set<ComparableExp> s) {
	Set<String> r = new TreeSet<>();
	for (Exp e : s)
	    switch (e.getConnective()) {
	    case NOT:
		e = e.getChildren().get(0);
	    default:
		r.add(e.getAtom().get(0).getImage());
	    }
	return r;
    }

    
    /// @return A map where key = type and value = list of objects of
    /// that type, collected from constants and types in \p d and
    /// objects in \p p.  Only types with objects in \p p are
    /// collected.

    /// @remarks We don't introduce data types for actions
    /// (actions will be prefixed by '_' in order to extract a
    /// plan from the model).
    private static Map<String,List<String>> dataTypes(Domain d, Problem p) {
	List<TypedSymbol> objects = new ArrayList<>(d.getConstants());
	objects.addAll(p.getObjects());
	Map<String,List<String>> dtypes = groupByType(objects);
	return dtypes;
    }


    /// @return A map where key = type and value = list of objects of
    /// that type, collected from \p objects.
    private static Map<String,List<String>> groupByType(List<TypedSymbol> objects) {
	TreeMap<String,List<String>> m = new TreeMap<>();
	for (TypedSymbol s : objects) {
	    String type = s.getTypes().get(0).getImage(); // Caution: assuming only one type.
	    String object = s.getImage();
	    List<String> l = new ArrayList<>();
	    List<String> lm = m.putIfAbsent(type,l);
	    if (lm == null)
		l.add(object);
	    else
		lm.add(object);
	}
	return m;
    }


    /// @return A map with key = object name and value = object's type
    /// name, for all objects in \p p.
    public static Map<String,String> collectTypes(Problem p) {
	Map<String,String> m = new TreeMap<>();
	List<TypedSymbol> objects = new ArrayList<>(p.getObjects());
	for (TypedSymbol s : objects)
	    m.put(s.getImage(),s.getTypes().get(0).getImage());
	return m;
    }

    
    /// @return A map where key = type and value = list of base
    /// subtypes in \p base, for all types in \p d.
    private static Map<String,List<String>> baseSubtypes(Domain d, Set<String> base) {
	TreeMap<String,List<String>> m = new TreeMap<>();
	List<TypedSymbol> lt = d.getTypes();
	for (String type : base) {
	    // Add type to all of its supertypes
	    List<Symbol> supertypes = getSymbol(lt,type).getTypes();
	    while (!supertypes.isEmpty()) {
		// Assuming only one supertype
		String supertype = supertypes.get(0).getImage();
		List<String> ls = new ArrayList<>();
		List<String> lsm = m.putIfAbsent(supertype,ls);
		if (lsm == null)
		    ls.add(type);
		else
		    lsm.add(type);
		supertypes = getSymbol(lt,supertype).getTypes();
	    }
	}
	return m;
    }
	

    /// @pre There is exactly one symbol in \p l whose image is \p s.
    
    /// @return The symbol in \p l whose image is \p s.
    private static TypedSymbol getSymbol(List<TypedSymbol> l, String s) {
	TypedSymbol ts = null;
	for (TypedSymbol sym : l)
	    if (sym.getImage().equals(s)) {
		ts = sym;
		break;
	    }
	return ts;
    }

    
    /// @post Outputs data types as collected in \p m, interpreting
    /// key = type and value = list of objects of that type.
    private static void printDataTypes(Map<String,List<String>> m) {
	System.out.println("(declare-datatypes () (");
	for (Map.Entry<String,List<String>> entry : m.entrySet()) {
	    System.out.print(" (" + entry.getKey());
	    for (String object : entry.getValue())
		System.out.print(" (" + object + ")");
	    System.out.println(")");
	}
	System.out.println("))\n");	
    }

    
    /// @post Outputs function declarations collected from predicates
    /// and functions in \p d, adding a '_time' argument for those
    /// whose name is in \p dtime. A 'exec' predicate, with two integer
    /// arguments (number of variable, and time) is added to represent
    /// additional Boolean variables in binary at-most-one constraints.
    private static void printFunctions(Domain d,
				      Set<String> dtime) {
 	System.out.println(";; Predicates");
	printFunctions(d.getPredicates(),"Bool",dtime);
	System.out.println("(declare-fun exec (Int _time) Bool)");
	System.out.println("\n;; Numeric functions");
	printFunctions(d.getFunctions(),"Int",dtime);
	System.out.println();
    }


    /// @post Outputs SMT2 function declaration as derived from \p
    /// functions, with return type \p returnType, and adding a
    /// '_time' argument for those whose name is in \p dtime.

    private static void printFunctions(List<NamedTypedList> functions,
				       String returnType,
				       Set<String> dtime) {
	for (NamedTypedList f : functions) {
	    String name = f.getName().getImage();
	    boolean dependsOnTime = dtime.contains(name);
	    System.out.print("(declare-fun " + name + " (");
	    for (TypedSymbol s : f.getArguments()) {
		String typeName = s.getTypes().get(0).getImage();
		System.out.print(" " + typeName);
	    }
	    if (dependsOnTime)
		System.out.println(" _time ) " + returnType + ")");
	    else
		System.out.println(" ) " + returnType + ")");
	}
    }


    /// @return A map where keys are the literals and functions which
    /// are modified in the effects of operators in \p d, and values
    /// are the list of operators that modify that literal or
    /// function. Only (negated) predicates, and function atoms
    /// modified by increase or decrease operators are considered
    /// (scale-up and scale-down effects not supported).

    private static Map<ComparableExp,List<Op>> modified(Domain d) {
    	Map<ComparableExp,List<Op>> m = new TreeMap<>();
    	for (Op o : d.getOperators()) {
    	    addModified(m,o,o.getEffects());
    	}
    	return m;
    }

    
    /// @post \p m is updated with keys for those (negated) predicates
    /// which occur in \p e, and for those function atoms which are
    /// modified by assign, increase or decrease operators in \p e
    /// (scale-up and scale-down effects not supported). Operator \p o
    /// is added to the list associated with each of those keys. 
    private static void addModified(Map<ComparableExp,List<Op>> m, Op o, Exp e) {	    
	Connective c = e.getConnective();
	switch (c) {
	case ATOM:
	case NOT:
	case FN_HEAD:
	    ComparableExp ce = new ComparableExp(e);
	    List<Op> l = new ArrayList<>();
	    List<Op> lm = m.putIfAbsent(ce,l);
	    if (lm == null)
	    	l.add(o);
	    else
	    	lm.add(o);
	    break;
	case ASSIGN:
	case INCREASE:
	case DECREASE:
	    addModified(m,o,e.getChildren().get(0));
	    break;
	case WHEN:
	    addModified(m,o,e.getChildren().get(1));
	    break;
	default:
	    for (Exp f : e.getChildren())
		addModified(m,o,f);
	}
    }


    /// @post Outputs the function declarations corresponding to
    /// the signatures of \p actions. Adds '_' as prefix for all
    /// action names.
    private static void printActions(List<Op> actions) {
	System.out.println(";; Actions");
	for (Op o : actions) {
	    Symbol name = o.getName();
	    name.setImage('_' + name.getImage());
	    System.out.print("(declare-fun " + o.getName() + " (");
	    for (TypedSymbol s : o.getParameters())
		System.out.print(" " + s.getTypes().get(0).getImage());
	    System.out.println(" _time ) Bool)");
	}
	System.out.println();
    }


    /// @pre \p modifiedLits is a map where keys are the literals
    /// which are modified in the effects of operators in \p d, and
    /// values are the list of operators that modify that literal. \p
    /// dependOntime are the predicate and function names of those
    /// literals. \p dtypes is a map where key = type and value = list
    /// of objects of that type. \p quantify equals "all" or
    /// "time". All keys in \p constFunc correspond to expressions
    /// with connective FN_HEAD.
    
    /// @post Outputs the definition of the transition function, which
    /// is universally quantified over time, for operators in \p d. If
    /// \p quantify equals "all" then time and all objects are
    /// quantified, otherwise only time is quantified. If \p quantify
    /// equals "time" then all expressions in \p constFunc are
    /// replaced by their value.
    private static void printTransitionFunction(Domain d,
						Map<ComparableExp,List<Op>> modifiedLits,
						Set<String> dtime,
						Map<String,List<String>> dtypes,
						String quantify,
						Map<String,Integer> constFunc) throws Exception {
	System.out.println(";; Transition function");
	System.out.println("(define-fun trans ((bound _time)) Bool");
	System.out.println("  (forall ((t0 _time)) (let ((t1 (+ t0 1)))");
	System.out.println("    (=> (<= 0 t0 bound) (and");
 	String prefix = "         ";
	//	System.out.println(prefix + ";; At least one action is executed");
	//	printAtLeastOne(prefix,d);
	boolean qObjects = quantify.equals("all");
	printExecutionAxioms(prefix,d,dtime,dtypes,qObjects,constFunc);
	if (qObjects)
	    printFrameAxioms(prefix,d,modifiedLits); // Includes at-most-one like constraints
	else {
	    int i = printFrameAxiomsUnfolded(prefix,d,modifiedLits,dtypes,false,0); // Prepared for at-most-one constraints in frame axioms (change false/true). It increases time if already exists a glocal at-most-one constraint.
	    printAtMostOne(prefix,groundActions(d,dtypes),i);
	}
	System.out.println(")))))");
    }


    /// @pre All actions in \p d have at least one parameter.

    /// @post Outputs or of actions in \p d at time t0, prefixed with
    /// \p prefix.
    private static void printAtLeastOne(String prefix , Domain d) {
	System.out.println(prefix + ";; At least one action is executed (optional)");
	System.out.println(prefix + "(or");
	String newPrefix = prefix + "  ";
	for (Op o : d.getOperators()) {
	    System.out.print(newPrefix + "(exists ");
	    printArguments(o.getParameters(),"");
	    System.out.print(newPrefix + "  " + action(o,"t0",""));
	    System.out.println(')');
	}
	System.out.println(prefix + ")");
    }
    

    /// @pre All actions in \p d have at least one parameter. \p
    /// dtypes is a map where key = type and value = list of objects
    /// of that type. All keys in \p constFunc correspond to expressions
    /// with connective FN_HEAD.

    /// @post Outputs execution axioms for actions in \p d at time t0,
    /// prefixed with \p prefix. Predicates and functions whose name
    /// is in \p dtime are considered to depend on time. Objects are
    /// quantified iff \p qObjects. If \p !qObjects then all
    /// expressions in \p constFunc are replaced by their value.
    private static void printExecutionAxioms(String prefix , Domain d, Set<String> dtime,
					     Map<String,List<String>> dtypes,
					     boolean qObjects,
					     Map<String,Integer> constFunc) throws Exception {
	for (Op o : d.getOperators())
	    if (qObjects) 
		printExecutionAxioms(prefix,o,d,dtime);
	    else
		printExecutionAxiomsUnfolded(prefix,o,d,dtime,dtypes,constFunc);
    }

    
    /// @pre All actions in \p d have at least one parameter, and \p o
    /// is an action in \p d.

    /// @post Outputs a formula stating that when \p o is executed at
    /// time t0 (with some parameters) then its precondition must hold
    /// at time t0, its effects must hold at time t1, and no other
    /// action can be executed at time t0. The formula is prefixed by
    /// \p prefix. Predicates and functions whose name is in \p dtime
    /// are considered to depend on time. Both objects and time are
    /// quantified.
    private static void printExecutionAxioms(String prefix, Op o, Domain d, Set<String> dtime) throws Exception {
	String newPrefix = prefix + '\t';
	System.out.println(prefix + ";; Execution of " + o.getName());
	System.out.print(prefix + "(forall ");
	printArguments(o.getParameters(),"");
	System.out.print(prefix + "  (=> ");
	System.out.print(action(o,"t0",""));
	System.out.println(" (and");
	System.out.println(newPrefix + ";; Precondition holds at time t0");
	printExpression(newPrefix,"t0","t1",true,o.getPreconditions(),dtime,true);
	System.out.println(newPrefix + ";; Effects hold at time t1");
	printExpression(newPrefix,"t0","t1",false,o.getEffects(),dtime,true);
 	System.out.println(newPrefix + ";; The same operator is not executed with other parameters");
	System.out.print(newPrefix + "(not (exists ");
	printArguments(o.getParameters(),"2");
	System.out.print(newPrefix + "\t(and ");
	System.out.print(action(o,"t0","2"));
	System.out.println();
	System.out.print(newPrefix + "\t    ");
	List<TypedSymbol> lp = o.getParameters();
	if (lp.size() > 1)
	    System.out.print(" (or");
	for (TypedSymbol t : lp) {
	    System.out.print(" (not (= " + t.getImage() + " " + t.getImage() + "2))");
	}
	if (lp.size() > 1)	
	    System.out.println(")");
	else
	    System.out.println();
	System.out.println(newPrefix + "\t)");
	System.out.println(newPrefix + "))");
	System.out.println(newPrefix + ";; No other operator is executed");
	for (Op o2 : d.getOperators())
	    if (!o2.equals(o)) {
		System.out.print(newPrefix + "(not (exists ");
		printArguments(o2.getParameters(),"");
		System.out.print(newPrefix + "\t" + action(o2,"t0",""));
		System.out.println();
		System.out.println(newPrefix + "))");
	    }
	System.out.println(prefix + ")))");       
    }

    
    /// @pre All actions in \p d have at least one parameter, and \p o
    /// is an action in \p d. \p dtypes is a map where key = type and
    /// value = list of objects of that type. All keys in \p constFunc
    /// correspond to expressions with connective FN_HEAD.

    /// @post Outputs a formula stating that when \p o is executed at
    /// time t0 (with some parameters) then its precondition must hold
    /// at time t0, its effects must hold at time t1, and no other
    /// action can be executed at time t0. The formula is prefixed by
    /// \p prefix. Predicates and functions whose name is in \p dtime
    /// are considered to depend on time. Only time is
    /// quantified. Arguments are instantiated according to \p
    /// dtypes. All expressions in \p constFunc are replaced by their
    /// value.
    private static void printExecutionAxiomsUnfolded(String prefix, Op o, Domain d, Set<String> dtime,
						     Map<String,List<String>> dtypes,
						     Map<String,Integer> constFunc) throws Exception {
	String newPrefix = prefix + '\t';
	List<TypedSymbol> lparam = o.getParameters();
	List<List<String>> larg = split(combine(lparam.iterator(),dtypes)); // List of argument value combinations
	List<String> argn = new ArrayList<>(lparam.size()); // Names of parameters
	System.out.println(prefix + ";; Execution of " + o.getName());
	for (TypedSymbol ts : lparam)
	    argn.add(ts.getImage());
	for (List<String> argv : larg) {
	    System.out.print(prefix + "(=> ");
	    System.out.print(action(o,"t0",argv));
	    System.out.println(" (and");
	    System.out.println(newPrefix + ";; Precondition holds at time t0");
	    printExpressionUnfolded(newPrefix,"t0","t1",true,o.getPreconditions(),dtime,true,argn,argv,dtypes,constFunc);
	    System.out.println(newPrefix + ";; Effects hold at time t1");
	    printExpressionUnfolded(newPrefix,"t0","t1",false,o.getEffects(),dtime,true,argn,argv,dtypes,constFunc);
	    System.out.println(prefix + "))");
	}
    }
    

    /// @return The term corresponding to action \p o with \p l added
    /// as last argument. Each parameter name is added \p s as suffix.
    private static String action(Op o, String l, String s) {
	String r = "(" + o.getName() + " ";
	for (TypedSymbol t : o.getParameters())
	    r += t.getImage() + s + " ";
	r += l + ")";
	return r;
    }


    /// @pre \p args are values for parameters of \p o, in the same
    /// order as they occur in \p o.getParameters()
    
    /// @post Return the term corresponding to action \p o with
    /// concrete parameters \p args, with \p l added as last argument.
    private static String action(Op o, String l, List<String> args) {
	String r = "(" + o.getName() + " ";
	for (int i = 0; i < o.getParameters().size(); i++)
	    r += args.get(i) + " ";
	r += l + ")";
	return r;
    }


    /// @pre \p ls are the symbols of a predicate or a function atom.

    /// @post Outputs the term corresponding to \p ls with \p s added
    /// as last argument, preceded by \p prefix.
    private static void printFunction(String prefix, List<Symbol> ls, String s) {
	System.out.print(prefix + '(');
	for (Symbol t : ls)
	    System.out.print(t.getImage() + ' ');
	System.out.print(s + ')');
    }


    /// @pre \p ls are the arguments of a predicate or a function atom.

    /// @return The term corresponding to \p ls with \p s added as
    /// last argument.

    /// @remarks \p s can be empty
    private static String groundFunction(List<String> ls, String s) {
	String r = '(' + ls.get(0);
	for (String t : ls.subList(1,ls.size()))
	    r = r + ' ' + t;
	r = r + (s.equals("")? ')' : ' ' + s + ')');
	return r;
    }
    

    /// @post Outputs the parameters in \p l in SMT-LIB format, whith
    /// \p s added as a suffix of each name.
    private static void printArguments(List<TypedSymbol> l, String s) {
	System.out.print("(");
	for (TypedSymbol t : l) {
	    System.out.print(" (" + t.getImage() + s + " " + t.getTypes().get(0).getImage() + ")");
	}
	System.out.println(" )");
    }


    /// @post Outputs the parameters in \p lt in SMT-LIB format, only
    /// for those parameters such that the name in the same position
    /// of \p ln starts with '?', replacing their name with that
    /// name. The names of the parameters in \p lt are modified
    /// accordingly.
    private static void printArgumentsWithNames(List<TypedSymbol> lt, List<Symbol> ln) {
	System.out.print("(");
	Iterator<Symbol> it = ln.iterator();
	for (TypedSymbol t : lt) {
	    String s = it.next().getImage();
	    if (s.charAt(0) == '?') {
		System.out.print(" (" + s + " " + t.getTypes().get(0).getImage() + ")");
		t.setImage(s);
	    }
	}
	System.out.println(" )");
    }


    /// @post Replaces the names in \p lt such that the name in the
    /// same position of \p ln starts with '?', with that name.
    private static void replaceArgumentsWithNames(List<TypedSymbol> lt, List<Symbol> ln) {
	Iterator<Symbol> it = ln.iterator();
	for (TypedSymbol t : lt) {
	    String s = it.next().getImage();
	    if (s.charAt(0) == '?')
		t.setImage(s);
	}
    }


    /// @pre If \p pre then \p e denotes a precondition, otherwise an effect.
	
    /// @post Outputs expression \p e in SMT2 format, prefixed by \p
    /// prefix, and followed by '\\n' iff \p newLine. If \p pre, all
    /// functions whose name is in \p dtime are added a
    /// parameter \p t0. If not \p pre, predicates whose name is in \p
    /// dtime are added a parameter \p t1, while for assign,
    /// increase and decrease operations we add a parameter \p t1 to
    /// their first argument, and a parameter \p t0 to all functions
    /// which occur in its second argument and whose name belongs to
    /// \p dtime.
    
    /// @exception Exception Expression \p e contains some unsupported connective.
    private static void printExpression(String prefix, String t0, String t1, boolean pre,
					Exp e, Set<String> dtime, boolean newLine) throws Exception {
	String newPrefix = prefix + '\t';
	Connective connective = e.getConnective();
	List<Exp> lexp = e.getChildren();
	boolean increase = false;
	
	switch (connective) {
	case F_EXP:
	    for (Exp f : lexp)
		printExpression(prefix,t0,t1,pre,f,dtime,newLine);
	    break;
	case ATOM:
	case FN_HEAD:
	    List<Symbol> ls = e.getAtom();
	    String name = ls.get(0).getImage();
	    if (dtime.contains(name))
		if (pre)
		    printFunction(prefix,ls,t0);
		else
		    printFunction(prefix,ls,t1);
	    else
		System.out.print(prefix + e);
	    break;
	case AND:
	case OR:
	    System.out.println(prefix + "(" + connective.getImage());
	    for (Exp f : lexp) {
		printExpression(newPrefix,t0,t1,pre,f,dtime,true);
	    }
	    System.out.print(prefix + ')');
	    break;
	case NOT:
	case EQUAL:
	case GREATER:
	case GREATER_OR_EQUAL:
	case LESS:
	case LESS_OR_EQUAL:
	case MUL:
	case DIV:
	case PLUS:
	case MINUS:
	    System.out.print(prefix + "(" + connective.getImage());
	    for (Exp f : lexp)
		printExpression(" ",t0,t1,pre,f,dtime,false);	    
	    System.out.print(')');
	    break;
	case NUMBER:
	    System.out.print(prefix + e.getValue().intValue());
	    break;
	case EQUAL_ATOM:
	    List<Symbol> lp = e.getAtom(); 
	    System.out.print(prefix + "(= " + lp.get(0) + " " + lp.get(1) + ")");
	    break;
	case ASSIGN:
	    System.out.print(prefix + "(=");
	    printExpression(" ",t0,t1,false,lexp.get(0),dtime,false);
	    printExpression(" ",t0,t1,true,lexp.get(1),dtime,false);	    
	    System.out.print(')');
	    break;
	case INCREASE:
	    increase = true;
	case DECREASE:
	    System.out.print(prefix + "(=");
	    printExpression(" ",t0,t1,false,lexp.get(0),dtime,false);
	    System.out.print(" (" + (increase? '+':'-'));
	    printExpression(" ",t0,t1,true,lexp.get(0),dtime,false);
	    printExpression(" ",t0,t1,true,lexp.get(1),dtime,false);	    
	    System.out.print("))");
	    break;
	case FORALL:
	    System.out.print(prefix + "(forall ");
	    printArguments(e.getVariables(),"");
	    printExpression(newPrefix,t0,t1,pre,lexp.get(0),dtime,true);	    
	    System.out.print(prefix + ')');
	    break;
	case WHEN:
	    System.out.println(prefix + "(=>");
	    printExpression(newPrefix,t0,t1,true,lexp.get(0),dtime,true);
	    printExpression(newPrefix,t0,t1,false,lexp.get(1),dtime,true);	    
	    System.out.print(prefix + ')');
	    break;
	case FN_ATOM:
	    System.out.print(prefix + "(" + connective.getImage());
	    for (Exp f : lexp)
		printExpression(" ",t0,t1,pre,f,dtime,false);	    
	    System.out.print(')');
	    break;
	    //	case TRUE:
	    //	case FALSE:
	    //	case UMINUS:
	    //	case EXISTS:
	default:
	    throw new Exception("Connective " + e.getConnective() + " in expression\n\n" + e + "\n\nnot supported.");
	}
	if (newLine)
	    System.out.println();
    }


    /// @pre If \p pre then \p e denotes a precondition, otherwise an
    /// effect. \p dtypes is a map where key = type and value = list
    /// of objects of that type. All keys in \p constFunc
    /// correspond to expressions with connective FN_HEAD.
	
    /// @post Outputs expression \p e in SMT2 format, prefixed by \p
    /// prefix, and followed by '\\n' iff \p newLine. If \p pre, all
    /// functions whose name is in \p dtime are added a parameter \p
    /// t0. If not \p pre, predicates whose name is in \p dtime are
    /// added a parameter \p t1, while for assign, increase and
    /// decrease operations we add a parameter \p t1 to their first
    /// argument, and a parameter \p t0 to all functions which occur
    /// in its second argument and whose name belongs to \p dtime. All
    /// parameter names in \p names are replaced by the value in the
    /// same position of \p values. Instantiations of conditional
    /// effects are done according to dtypes. All expressions in \p
    /// constFunc are replaced by their value.
    
    /// @exception Exception Expression \p e contains some unsupported connective.
    private static void printExpressionUnfolded(String prefix, String t0, String t1,
						boolean pre, Exp e, Set<String> dtime,
						boolean newLine,
						List<String> names, List<String> values,
						Map<String,List<String>> dtypes,
						Map<String,Integer> constFunc) throws Exception {
	String newPrefix = prefix + '\t';
	Connective connective = e.getConnective();
	List<Exp> lexp = e.getChildren();
	boolean increase = false;

	switch (connective) {
	case F_EXP:
	    for (Exp f : lexp)
		printExpressionUnfolded(prefix,t0,t1,pre,f,dtime,newLine,names,values,dtypes,constFunc);
	    break;
	case ATOM:
	case FN_HEAD:
	    List<Symbol> ls = e.getAtom();
	    List<String> lv = new ArrayList<>(ls.size()); // List of values
	    String name = ls.get(0).getImage();
	    lv.add(name);
	    for(int i = 1; i < ls.size(); i++)
		lv.add(valueOf(ls.get(i).getImage(),names,values));
	    if (dtime.contains(name))
		System.out.print(prefix + groundFunction(lv,pre?t0:t1));
	    else {
		String function = groundFunction(lv,"");
		Integer v = constFunc.get(function);
		System.out.print(prefix);
		if (v != null)
		    System.out.print(v);
		else
		    System.out.print(function);
	    }
	    break;
	case AND:
	case OR:
	    System.out.println(prefix + "(" + connective.getImage());
	    for (Exp f : lexp) {
		printExpressionUnfolded(newPrefix,t0,t1,pre,f,dtime,true,names,values,dtypes,constFunc);
	    }
	    System.out.print(prefix + ')');
	    break;
	case NOT:
	case EQUAL:
	case GREATER:
	case GREATER_OR_EQUAL:
	case LESS:
	case LESS_OR_EQUAL:
	case MUL:
	case DIV:
	case PLUS:
	case MINUS:
	    System.out.print(prefix + "(" + connective.getImage());
	    for (Exp f : lexp)
		printExpressionUnfolded(" ",t0,t1,pre,f,dtime,false,names,values,dtypes,constFunc);
	    System.out.print(')');
	    break;
	case NUMBER:
	    System.out.print(prefix + e.getValue().intValue());
	    break;
	case EQUAL_ATOM:
	    List<Symbol> lp = e.getAtom(); 
	    System.out.print(prefix + "(= " + valueOf(lp.get(0).getImage(),names,values) + " " +
			     valueOf(lp.get(1).getImage(),names,values) + ")");
	    break;
	case ASSIGN:
	    System.out.print(prefix + "(=");
	    printExpressionUnfolded(" ",t0,t1,false,lexp.get(0),dtime,false,names,values,dtypes,constFunc);
	    printExpressionUnfolded(" ",t0,t1,true,lexp.get(1),dtime,false,names,values,dtypes,constFunc);
	    System.out.print(')');
	    break;
	case INCREASE:
	    increase = true;
	case DECREASE:
	    System.out.print(prefix + "(=");
	    printExpressionUnfolded(" ",t0,t1,false,lexp.get(0),dtime,false,names,values,dtypes,constFunc);
	    System.out.print(" (" + (increase? '+':'-'));
	    printExpressionUnfolded(" ",t0,t1,true,lexp.get(0),dtime,false,names,values,dtypes,constFunc);
	    printExpressionUnfolded(" ",t0,t1,true,lexp.get(1),dtime,false,names,values,dtypes,constFunc);
	    System.out.print("))");
	    break;
	case FORALL:
	    for (TypedSymbol ts : e.getVariables())
		names.add(ts.getImage());
	    List<List<String>> larg = split(combine(e.getVariables().iterator(),dtypes)); // List of argument value combinations
	    for (List<String> args : larg) {
		List<String> newValues = new ArrayList<>(values);
		newValues.addAll(args);
		printExpressionUnfolded(prefix,t0,t1,true,lexp.get(0),dtime,true,names,newValues,dtypes,constFunc);
	    }
	    newLine = false;
	    break;
	case WHEN:
	    System.out.println(prefix + "(=>");
	    printExpressionUnfolded(newPrefix,t0,t1,true,lexp.get(0),dtime,true,names,values,dtypes,constFunc);
	    printExpressionUnfolded(newPrefix,t0,t1,false,lexp.get(1),dtime,true,names,values,dtypes,constFunc);	    
	    System.out.print(prefix + ')');
	    break;
	case FN_ATOM:
	    System.out.print(prefix + "(" + connective.getImage());
	    for (Exp f : lexp)
		printExpressionUnfolded(" ",t0,t1,pre,f,dtime,false,names,values,dtypes,constFunc);
	    System.out.print(')');
	    break;
	    //	case TRUE:
	    //	case FALSE:
	    //	case UMINUS:
	    //	case EXISTS:
	    //  case FORALL:
	default:
	    throw new Exception("Connective " + e.getConnective() + " in expression\n\n" + e + "\n\nnot supported.");
	}
	if (newLine)
	    System.out.println();
    }


    /// @pre \p names and \p values have the same size.

    /// @post returns the value in \p values in the (first) position
    /// where \p name is found in \p names, if any, and \p name
    /// otherwise.
    private static String valueOf(String name, List<String> names, List<String> values) {
	int j = names.indexOf(name);
	return (j != -1) ? values.get(j) : name; 
    }
    
    
    /// @pre \p modifiedLits is a map where keys represent literals
    /// which are modified, and values are the list of operators that
    /// modify that literal.

    /// @post Outputs frame axioms for \p modifiedLits at time t1,
    /// according to the types declared in \p d. Each axiom is
    /// prefixed by \p prefix. Both time and objects are quantified.
    private static void printFrameAxioms(String prefix, Domain d,
					 Map<ComparableExp,List<Op>> modifiedLits) throws Exception {
	modifiedLits = merge(modifiedLits);
	List<NamedTypedList> lf = new LinkedList<>(d.getPredicates());
	lf.addAll(d.getFunctions());
	System.out.println(prefix + ";; Frame axioms");
	for (Map.Entry<ComparableExp,List<Op>> entry : modifiedLits.entrySet()) {
	    ComparableExp literal = entry.getKey();
	    Connective con = literal.getConnective();
	    boolean isNot = (con == Connective.NOT);
	    Exp atom = isNot? literal.getChildren().get(0) : literal;
	    List<Symbol> latom = atom.getAtom();
	    List<TypedSymbol> types = getTypes(lf,latom.get(0));
	    boolean forAll = !types.isEmpty();
	    if (forAll) {
		System.out.print(prefix + "(forall ");
		printArgumentsWithNames(types,latom.subList(1,latom.size()));
		System.out.print(prefix + "  (=> ");
	    }
	    else
		System.out.print(prefix + "(=> ");		
	    switch (con) {
	    case ATOM:
		printFunction("",latom,"t1");
		break;
	    case NOT:
		System.out.print("(not ");
		printFunction("",latom,"t1");
		System.out.print(")");
		break;
	    case FN_HEAD:
		System.out.print("(not (=");
		printFunction(" ",latom,"t1");
		printFunction(" ",latom,"t0");
		System.out.print("))");		
	    }
 	    System.out.println(" (or");
	    String newPrefix = prefix + "      ";
	    switch (con) {
	    case ATOM:
		printFunction(newPrefix,latom,"t0");
		System.out.println();
		break;		
	    case NOT:
		System.out.print(newPrefix + "(not ");
		printFunction("",latom,"t0");
		System.out.println(")");
		break;
	    case FN_HEAD:
	    }
	    for (Op o : entry.getValue()) {
		List<TypedSymbol> missingTypes = getMissing(types,o.getParameters());
		if (!missingTypes.isEmpty()) {
		    System.out.print(newPrefix + "(exists ");
		    printArguments(missingTypes,"");
		    System.out.print(newPrefix + "\t" + action(o,"t0",""));
		}
		else
		    System.out.print(newPrefix + action(o,"t0",""));
		System.out.println();
		if (!missingTypes.isEmpty())
		    System.out.println(newPrefix + ")");
	    }
	    System.out.print(prefix + "))");
	    if (forAll)
		System.out.print(')');
	    System.out.println();
	}
    }

    /// @pre \p modifiedLits is a map where keys represent literals
    /// which are modified, and values are the list of operators that
    /// modify that literal. \p dtypes is a map where key = type and
    /// value = list of objects of that type.

    /// @post Outputs frame axioms for \p modifiedLits at time t1,
    /// according to the types declared in \p d. Each axiom is
    /// prefixed by \p prefix. Only time is quantified. Arguments are
    /// instantiated according to \p dtypes. A binary at-most-one
    /// constraint is added for the actions in the reasons of each
    /// literal iff \p atmostone. Auxiliary variables are represented
    /// by <em>(exec i t0)</em> predicates with increasing values of
    /// \a i.

    /// @return The value of \p i incremented by the number of
    /// auxilary variables needed.
    private static int printFrameAxiomsUnfolded(String prefix, Domain d,
						 Map<ComparableExp,List<Op>> modifiedLits,
						 Map<String,List<String>> dtypes,
						 boolean atmostone, int i) throws Exception {
	ArrayList<String> actions = new ArrayList<>();
	modifiedLits = merge(modifiedLits);
	List<NamedTypedList> lf = new LinkedList<>(d.getPredicates());
	lf.addAll(d.getFunctions());
	System.out.println(prefix + ";; Frame axioms");
	for (Map.Entry<ComparableExp,List<Op>> entry : modifiedLits.entrySet()) {
	    ComparableExp literal = entry.getKey();
	    Connective con = literal.getConnective();
	    boolean isNot = (con == Connective.NOT);
	    Exp atom = isNot? literal.getChildren().get(0) : literal;
	    List<Symbol> latom = atom.getAtom();
	    String name = latom.get(0).getImage();
	    List<TypedSymbol> types = getTypes(lf,latom.get(0));
	    replaceArgumentsWithNames(types,latom.subList(1,latom.size()));
	    List<List<String>> larg = split(combine(types.iterator(),dtypes)); // List of argument value combinations
	    List<String> argn = new ArrayList<>(types.size()); // Names of parameters
	    List<String> gfun = new ArrayList<>(types.size()+1); // Function name + values of parameters
	    for (TypedSymbol ts : types)
		argn.add(ts.getImage());
	    for (List<String> argv : larg) {
		actions.clear();
		gfun.clear();
		gfun.add(name);
		gfun.addAll(argv);
		System.out.print(prefix + "(=> ");
		switch (con) {
		case ATOM:
		    System.out.print(groundFunction(gfun,"t1"));
		    break;
		case NOT:
		    System.out.print("(not ");
		    System.out.print(groundFunction(gfun,"t1"));
		    System.out.print(")");
		    break;
		case FN_HEAD:
		    System.out.print("(not (=");
		    System.out.print(" " + groundFunction(gfun,"t1"));
		    System.out.print(" " + groundFunction(gfun,"t0"));
		    System.out.print("))");		
		}
		System.out.println(" (or");
		String newPrefix = prefix + "      ";
		switch (con) {
		case ATOM:
		    System.out.print(newPrefix + groundFunction(gfun,"t0"));
		    System.out.println();
		    break;		
		case NOT:
		    System.out.print(newPrefix + "(not ");
		    System.out.print(groundFunction(gfun,"t0"));
		    System.out.println(")");
		    break;
		case FN_HEAD:
		}
		if (atmostone) {
		    System.out.println(newPrefix + "(and");
		    System.out.println(newPrefix + ";; At least one");
		    System.out.println(newPrefix + "(or");
		}
		for (Op o : entry.getValue()) {
		    List<TypedSymbol> param = o.getParameters();
		    List<TypedSymbol> missingTypes = getMissing(types,param);
		    List<TypedSymbol> sortedTypes = new LinkedList<>(param);
		    sortedTypes.removeAll(missingTypes);
		    // Reorder parameters of gfun according to sortedTypes, taking as original order that of types.
		    List<String> gfunOrdered = new ArrayList<String>(gfun);
		    int pos1 = 1;
		    for (TypedSymbol ts : types) {
			int pos2 = sortedTypes.indexOf(ts) + 1;
			gfunOrdered.set(pos2,gfun.get(pos1));
			pos1++;
		    }
		    gfun = gfunOrdered;
		    if (!missingTypes.isEmpty()) {
			List<List<String>> missingValues = split(combine(missingTypes.iterator(),dtypes));
			List<List<String>> actualParameters =
			    combineInto(param,sortedTypes,gfun.subList(1,gfun.size()),
					missingTypes,missingValues);
			for (List<String> ls : actualParameters) {
			    String a = action(o,"t0",ls);
			    actions.add(a);
			    System.out.print(newPrefix + a);
			    System.out.println();
			}
		    }
		    else {
			String a = action(o,"t0",gfun.subList(1,gfun.size()));
			actions.add(a);
			System.out.print(newPrefix + a);
			System.out.println();
		    }
		}
		if (atmostone) {
		    System.out.println(newPrefix + ")");
		    i = printAtMostOne(newPrefix,actions,i);	
		    System.out.println(newPrefix + ")");
		}
		System.out.println(prefix + "))");
	    }
	}
	return i;
    }


    /// @pre Strings in \p ls are of the form " word1 word2 ... wordn"

    /// @return A list whose elements are lists of the form
    /// [word1, word2, ... , wordn], with a one-to-one correspondence with
    /// strings in \p ls.
    private static List<List<String>> split(Iterable<String> ls) {
	List<List<String>> r = new ArrayList<>();
	for (String s : ls) {
	    if (!s.isEmpty()) {
		String[] values = s.substring(1).split(" ");
		List<String> lw = new ArrayList<>(values.length);
		for (String v : values)
		    lw.add(v);
		r.add(lw);
	    }
	    else
		r.add(new ArrayList<>());
	}
	return r;
    }


    /// @pre \p misTypes is the list of symbols in \p param that do
    /// not occur in \p types. The size of \p types and \p values is
    /// the same. The size of \p misTypes and the length of each list
    /// in \p misValues is the same.

    /// @return A list of lists \a v of the form [v_1, v_2, ..., v_n]
    /// for each element \a w of the form [w_1, w_2, ... , w_m] in \p
    /// misValues, where n = \p param.size() and the projection of \a
    /// v into \p misTypes, according to \p param, corresponds to \a
    /// w, and the projection of \a v into \p types, according to \p
    /// param, corresponds to \p values.
    private static List<List<String>> combineInto(List<TypedSymbol> param,
						  List<TypedSymbol> types,
						  List<String> values,
						  List<TypedSymbol> misTypes,
						  List<List<String>> misValues) {
	List<List<String>> l = new ArrayList<>();
	List<Integer> which = where(types,misTypes,param);
	for(List<String> mvs : misValues) {
	    List<String> ls = new ArrayList<>(mvs.size());
	    Iterator<String> it1 = values.iterator();
	    Iterator<String> it2 = mvs.iterator();
	    for (int i : which)
		ls.add((i==1) ? it1.next() : it2.next());
	    l.add(ls);
	}
	return l;
    }


    /// @pre The elements of \p types and \p misTypes are included in
    /// \p param and are disjoint.

    /// @post A list of the form [i_1, i_2, ... , i_n] where n = \p
    /// param.size() and i_j = 1 iff \p param.get(j) occurs in \p
    /// types.
    private static List<Integer> where(List<TypedSymbol> types, List<TypedSymbol> misTypes,
				List<TypedSymbol> param) {
	List<Integer> l = new ArrayList<>(param.size());
	for (TypedSymbol ts : param)
	    l.add(types.contains(ts) ? 1 : 2);
	return l;
    }


    /// @pre \p s corresponds to a predicate or a function in \p lf.

    /// @return A list with the types of the parameters of \p s as
    /// declared in \p lf.
    private static List<TypedSymbol> getTypes(List<NamedTypedList> lf, Symbol s) {
	List<TypedSymbol> lt = null;
	for (NamedTypedList m : lf)
	    if (m.getName().equals(s)) {
		lt = m.getArguments();
		break;
	    }
	return lt;
    }

    
    /// @return A list with the types in \p l2 which do not occur in \p l1.
    private static List<TypedSymbol> getMissing(List<TypedSymbol> l1, List<TypedSymbol> l2) {
	List<TypedSymbol> l = new ArrayList<>(l2);
	l.removeAll(l1);
	return l;
    }


    /// @pre All literals in \p p.getInit() are positive. \p quantify
    /// equals "all" or "time".
    
    /// @post Outputs the definition of a function which represents
    /// the initial state as described in \p d and \p p, by adding a
    /// parameter 0 to all predicates and functions whose name is in
    /// \p dtime. If \p quantify equals "time" then all assertions on
    /// \p constants are removed.

    /// @remarks We adhere to the closed world assumption for
    /// predicates, but undefined values for numeric functions are not
    /// supported.  Instances for the closed world assumption are
    /// generated according to \p dtypes, where the key is a data type
    /// and the value the list of values of that data type.

    /// @exception Exception Some expression in \p p.getInit()
    /// contains an unsupported connective.
    private static void printInitialState(Domain d, Problem p,
					  Map<String,List<String>> dtypes,
					  Set<String> dtime,
					  String quantify,
					  Set<String> constants) throws Exception {
	boolean qtime = quantify.equals("time");
	Set<String> s = new HashSet<>();
	System.out.println("\n;; Initial state");
	System.out.println("(define-fun init () Bool (and");
	for (Exp e : p.getInit()) {
	    if (!qtime || e.isLiteral() ||
		!constants.contains(e.getChildren().get(0).toString())) {
		if (e.getConnective() == Connective.ATOM) {
		    String t = e.toString();
		    s.add(t.substring(1,t.length()-1));
		}
		printExpression("\t","0","",true,e,dtime,true);
	    }
	}
	printClosedWorld("\t",s,d,dtypes,dtime);
 	System.out.println("))");
    }

    
    /// @pre All names of predicates and functions occurring in \p
    /// p.getGoal() are in \p dtime.

    /// @post Outputs the definition of a function which represents
    /// the goal as described in \p p.

    /// @exception Exception \p p.getGoal() contains some unsupported
    /// connective.
    private static void printGoal(Problem p, Set<String> dtime) throws Exception {
	System.out.println("\n;; Goal");
	System.out.print("(define-fun goal ((_t _time)) Bool ");
	Exp e = p.getGoal();
	printExpression("","_t","",true,e,dtime,false);
 	System.out.println(")");
    }


    /// @post Outputs (not (name p1 p2 ... pn)), prefixed by \p
    /// prefix, for every instance of every predicate declared in \p d
    /// such that "name p1 p2 ... pn" is not in \p assertedPredicates.
    /// A last parameter 0 is added for all predicates whose name is
    /// in \p dtime. Instances are generated according to \p dtypes,
    /// where the key is a data type and the value the list of values
    /// of that data type.
    private static void printClosedWorld(String prefix,
					 Set<String> assertedPredicates,
					 Domain d,
					 Map<String,List<String>> dtypes,
					 Set<String> dtime) {
	System.out.println(prefix + ";; Closed world");
	for (NamedTypedList p : d.getPredicates()) {
	    String name = p.getName().getImage();
	    boolean print0 = dtime.contains(name)? true : false;
	    Iterator<TypedSymbol> it = p.getArguments().iterator();
	    Iterable<String> combinations = combine(it,dtypes);
	    for (String s : combinations) {
		String t = name + s;
		if (!assertedPredicates.contains(t)) {
		    System.out.print(prefix + "(not (" + t);
		    if (print0)
			System.out.print(" 0");
		    System.out.println("))");
		}
	    }
	}
    }

    
    /// @pre All names of symbols in \p it occur as a key a in \p
    /// dtypes and the corresponding value is a list of objects of
    /// that type.

    /// @return All possible combinations of the form " v1 v2 ... vn"
    /// where n = length(\p it), and each vi is, respectively, an
    /// object of the corresponding type.
    private static Iterable<String> combine(Iterator<TypedSymbol> it,
					    Map<String,List<String>> dtypes) {
	List<String> l = new LinkedList<>();
	if (!it.hasNext())
	    l.add("");
	else {
	    TypedSymbol t = it.next();
	    Iterable<String> combinations = combine(it,dtypes);
	    for (String value : dtypes.get(t.getTypes().get(0).getImage())) 
		for (String combination : combinations)
		    l.add(" " + value + combination);
	}
	return l;
    }

    
    /// @pre \p dtypes is a map where key = type and value = list of
    /// objects of that type.
	
    /// @return An ArrayList containing all ground actions according
    /// to the actions defined in \p d and the data types in \p
    /// dtypes.  "t0" is added as a last argument of all actions.
    private static ArrayList<String> groundActions(Domain d, Map<String,List<String>> dtypes) {
	ArrayList<String> as = new ArrayList<>();
	for (Op o : d.getOperators()) {
	    Iterable<String> it = combine(o.getParameters().iterator(),dtypes);
	    String name = o.getName().getImage();
	    for (String s : it)
		as.add("(" + name + s + " t0)");
	}
	return as;
    }


    
    // @post Outputs (quadratic) mutex clauses for \p
    // actions. Clauses are prefixed with \p prefix.

    // @remark Too expensive in terms of space. It easily leads to files of GBs in size.
    // private static void printAtMostOne(String prefix, ArrayList<String> actions) {
    // 	System.out.println(prefix + ";; At most one action is executed");
    // 	int size = actions.size();
    // 	for (int i = 0; i < size; i++) {
    // 	    String newPrefix = prefix + "(or (not " + actions.get(i) + ") (not "; 
    // 	    for (int j = i + 1; j < size; j++)
    // 		System.out.println(newPrefix + actions.get(j) + "))");
    // 	}
    // }


    // @post Outputs an at-most-one constraint on the sum of the
    // 'exec' representatives for the \p actions at time "t0". The
    // formula is prefixed with \p prefix.

    // @remark Much better in terms of space, but pretty slow (doesn't propagate much?)
    // private static void printAtMostOne(String prefix, ArrayList<String> actions) {
    // 	System.out.println(prefix + ";; At most one action is executed");
    // 	int n = actions.size();
    // 	for (int i = 0; i < n; i++) {
    // 	    System.out.print(prefix);
    // 	    System.out.println("(or (= (exec " + i + " t0) 0) (= (exec " + i + " t0) 1))");
    // 	    // System.out.println("(<= 0 (exec " + i + " t0) 1)"); MUCH WORSE
    // 	}
    // 	int k = 0;
    // 	for (String action : actions) {
    // 	    System.out.print(prefix);
    // 	    System.out.println("(= " + action + " (= (exec " + k + " t0) 1))");
    // 	    k++;
    // 	}
    // 	System.out.print(prefix);
    // 	System.out.print("(<= 0 (+");
    // 	for (int i = 0; i < n; i++)
    // 	    System.out.print(" (exec " + i + " t0)");
    // 	System.out.println(") 1)");
    // 	// System.out.print("(let ((?sum (+");
    // 	// for (int i = 0; i < n; i++)
    // 	//     System.out.print(" (exec " + i + " t0)");
    // 	// System.out.println("))) (or (= ?sum 0) (= ?sum 1)))"); // MUCH WORSE
    // }

    
    /// @post Outputs an at-most-one binary constraint for the \p
    /// predicated. The formula is prefixed with \p prefix. Auxiliary
    /// variables are represented by <em>(exec i t0)</em> predicates
    /// with increasing values of \a i.

    /// @return The value of \p i incremented by the number of
    /// auxilary variables needed: ceil(log2(actions.size())).
    private static int printAtMostOne(String prefix, ArrayList<String> predicates, int i) {
	System.out.println(prefix + ";; At most one");
	double n = predicates.size();
	int m = (int)Math.ceil(Math.log(n) / Math.log(2));
	System.out.print(prefix + "(let (");
	for (int j = 0; j < m; i++,j++)
	    System.out.print(" (_b" + j + " (exec " + i + " t0))");
	System.out.println(" ) (and");
	String newPrefix = prefix + '\t';
	for (int j = 0; j < n; j++) {
	    String combination = toBitString(j,m);
	    System.out.println(newPrefix + "(let ((_p " + predicates.get(j) + ")) (and");
	    for (int k = 0; k < m; k++)
		System.out.println(newPrefix + "\t (or (not _p) " +
				   ((combination.charAt(k) == '0')? "(not _b" + k + ")" : "_b" + k) + ")");
	    System.out.println(newPrefix + "))");
	}
	System.out.println(prefix + "))");
	return i;
    }


    /// @pre \p subtypes is a map where key = type and value = list of
    /// base subtypes of this type in \p d.
    
    /// @post \p d is equivalent to the original, but where all
    /// predicates, functions and operators are over base types,
    /// according to \p subtypes.

    /// @return A map where key = name of predicate or function, value
    /// = list of (positions of) renamed arguments.

    /// @exception Exception \p d contains a quantified expression
    /// over a type not in \p basetypes.
    private static Map<String,List<Integer>>
	unfold(Domain d, Map<String,List<String>> subtypes,
	       Set<String> basetypes) throws Exception {
	HashMap<String,List<Integer>> renamedArguments = new HashMap<>();
	unfold(d,subtypes,d.getPredicates(),renamedArguments);
	unfold(d,subtypes,d.getFunctions(),renamedArguments);
	List<Op> ops = d.getOperators();
	List<Op> toAdd = new LinkedList<>();
	List<Op> toDelete = new LinkedList<>();
	for (Op o : ops) {
	    Symbol name = o.getName();
	    List<TypedSymbol> args = o.getParameters();
	    Pair<List<List<TypedSymbol>>,List<Integer>> p = combineTypes(d,args,subtypes,0);
	    if (!p.second.isEmpty()) {
		toDelete.add(o);
		for (List<TypedSymbol> newArgs : p.first) {
		    Op newOp = new Op(o);
		    String newName = rename(name,newArgs,p.second);
		    newOp.getName().setImage(newName);
		    List<TypedSymbol> cargs = newOp.getParameters();
		    cargs.clear();
		    cargs.addAll(newArgs);
		    updateNames(newOp,renamedArguments,basetypes);
		    toAdd.add(newOp);
		}
	    }
	    else
		updateNames(o,renamedArguments,basetypes);
	}
	ops.removeAll(toDelete);
	ops.addAll(toAdd);
	return renamedArguments;
    }

	
    /// @pre \p subtypes is a map where key = type and value = list of
    /// base subtypes of this type.
    
    /// @post \p d and \p sig are equivalent to the original, but
    /// where all signatures in \p sig are over base types, according
    /// to \p subtypes. \p ren has been updated with the list of
    /// (positions of) arguments modified in each signature.
    private static void unfold(Domain d, Map<String,List<String>> subtypes,
			       List<NamedTypedList> sig,
			       Map<String,List<Integer>> ren) {
	List<NamedTypedList> newSig = new ArrayList<>();
	for (NamedTypedList signature : sig) {
	    Pair<List<List<TypedSymbol>>,List<Integer>> p =
		combineTypes(d,signature.getArguments(),subtypes,0);
	    Symbol name = signature.getName();
	    ren.put(name.getImage(),p.second);
	    if (!p.second.isEmpty()) // Unfolding
		for (List<TypedSymbol> newArgs : p.first) {
		    NamedTypedList newSignature = new NamedTypedList(signature);
		    List<TypedSymbol> args = newSignature.getArguments();
		    args.clear();
		    args.addAll(newArgs);
		    String newName = rename(name,args,p.second);
		    newSignature.getName().setImage(newName);
		    newSig.add(newSignature);
		}
	    else
		newSig.add(signature);
	}
	sig.clear();
	sig.addAll(newSig);
    }

    
    /// @return A pair where: the first component is all possible
    /// combinations of arguments the form [type_0, type_1, ...,
    /// type_n-1] where n = \p lt.size(), and each type_i is,
    /// respectively, a TypedSymbol in \p d whose name is listed in \p
    /// types.get(lt.get(i).getTypes().get(0).getImage()) or \p
    /// lt.get(i) if \p lt.get(i).getTypes().get(0).getImage() is not
    /// a key in \p types; the second component is a list with the pos+i
    /// such that lt.get(i).getTypes().get(0).getImage() is a key
    /// in \p type.
    private static Pair<List<List<TypedSymbol>>,List<Integer>>
	combineTypes(Domain d, List<TypedSymbol> lt,
		     Map<String,List<String>> types,
		     int pos) {
	List<List<TypedSymbol>> l = new LinkedList<>();
	List<Integer> li = new LinkedList<>();
	Pair<List<List<TypedSymbol>>,List<Integer>> p = new Pair<>(l,li);
	if (!lt.isEmpty()) {
	    TypedSymbol t = lt.get(0);
	    List<TypedSymbol> l1 = new LinkedList<>();
	    List<String> typeNames = types.get(t.getTypes().get(0).getImage());
	    if (typeNames == null)
		l1.add(t);
	    else {
		li.add(pos);
		List<TypedSymbol> domainTypes = d.getTypes();
		for (String name : typeNames) {
		    TypedSymbol variable = new TypedSymbol(t);
		    Symbol type = new Symbol(getSymbol(domainTypes,name));
		    variable.getTypes().set(0,type);
		    l1.add(variable);
		}
	    }
	    Pair<List<List<TypedSymbol>>,List<Integer>> pr =
		combineTypes(d,lt.subList(1,lt.size()),types,pos+1);
	    List<List<TypedSymbol>> lr = pr.first;
	    if (lr.isEmpty()) 
		for (TypedSymbol t1 : l1) {
		    List<TypedSymbol> l2 = new LinkedList<>();
		    l2.add(t1);
		    l.add(l2);
		}
	    else {
		for (TypedSymbol t1 : l1)
		    for (List<TypedSymbol> l3 : lr) {
			List<TypedSymbol> l2 = new LinkedList<>();
			l2.add(t1);
			l2.addAll(l3);
			l.add(l2);
		    }
		li.addAll(pr.second);
	    }
	}
	return p;
    }


    /// @return A string of the form name_t0_t1..._tn-1 where name is
    /// the image of \p s, n is the length of \p whichArgs, and each
    /// ti the image of the i-th type in \p args.
    private static String rename(Symbol s, List<TypedSymbol> args, List<Integer> whichArgs) {
	String r = s.getImage();
	for (Integer i : whichArgs)
	    r = r + "_" + args.get(i).getTypes().get(0).getImage();
	return r;
    }


    /// @pre \p whichArgs.keySet() contains all names of predicates
    /// and functions occurring in \p o.

    /// @post Every predicate and function \a f occurring in \p o with
    /// name m has been renamed as m_t0_t1..._tn-1 where n is the
    /// length of \p whichArgs.get(m) and each ti is the image of the
    /// argument of \p o that corresponds to the j-th argument of \a
    /// f, where j is the i-th element of \p whichArgs.get(m).

    /// @exception Exception \p o contains a quantified expression
    /// over a type not in \p basetypes.
    private static void updateNames(Op o, Map<String,List<Integer>> whichArgs,
				    Set<String> basetypes) throws Exception {
	List<TypedSymbol> parameters = o.getParameters();
	updateNames(parameters,o.getPreconditions(),whichArgs,basetypes);
	updateNames(parameters,o.getEffects(),whichArgs,basetypes);
    }


    /// @pre \p whichArgs.keySet() contains all names of predicates
    /// and functions occurring in \p e.

    /// @post Every predicate and function \a f occurring in \p e with
    /// name m has been renamed as m_t0_t1..._tn-1 where n is the
    /// length of \p whichArgs.get(m) and each ti is the image of the
    /// argument of \p o that corresponds to the j-th argument of \a
    /// f, where j is the i-th element of \p whichArgs.get(m).

    /// @exception Exception \p e is a quantified expression over a
    /// type not in \p basetypes.
    private static void updateNames(List<TypedSymbol> param, Exp e,
				    Map<String,List<Integer>> whichArgs,
				    Set<String> basetypes) throws Exception {
	switch (e.getConnective()) {
	case ATOM:
	case FN_HEAD:
	    List<Symbol> atom = e.getAtom();
	    Symbol name = atom.get(0);
	    List<TypedSymbol> args = new LinkedList<>();
	    List<Symbol> argNames = atom.subList(1,atom.size());
	    for (Symbol s : argNames) {
		int i = param.indexOf(s);
		if (i != -1)
		    args.add(param.get(i));
	    }
	    name.setImage(rename(name,args,whichArgs.get(name.getImage())));
	    break;
	case FORALL:
	case EXISTS:
	    // Check if all variables are of base type
	    List<TypedSymbol> lv = e.getVariables();
	    boolean allBase = true;
	    for(TypedSymbol ts : lv) 
		if (!basetypes.contains(ts.getTypes().get(0).getImage())) {
		    allBase = false;
		    break;
		}
	    if (!allBase)
		throw new Exception("Non-base types in quantifiers unsupported:\n\n" + e);
	    param = new ArrayList<>(param);
	    param.addAll(lv);
	default:
	    for (Exp f : e.getChildren())
		updateNames(param,f,whichArgs,basetypes);
	}
    }


    /// @pre \p whichArgs.keySet() contains all names of predicates
    /// and functions occurring in \p e.

    /// @post Every predicate and function f occurring in \p e with
    /// name m has been renamed as m_t0_t1..._tn-1 where n is the
    /// length of \p whichArgs.get(m) and each ti is \p
    /// objTypes.get(arg_i) where arg_i is the i-th argument of f.
    private static void updateNames(Exp e, Map<String,List<Integer>> whichArgs,
				    Map<String,String> objTypes) {
	switch (e.getConnective()) {
	case ATOM:
	case FN_HEAD:
	    List<Symbol> atom = e.getAtom();
	    Symbol name = atom.get(0);
	    List<Symbol> args = atom.subList(1,atom.size());
	    String s = name.getImage();
	    List<Integer> which = whichArgs.get(s);
	    for (Integer i : which)
		s = s + "_" + objTypes.get(args.get(i).getImage());
	    name.setImage(s);
	    break;
	default:
	    for (Exp f : e.getChildren())
		updateNames(f,whichArgs,objTypes);
	}
    }


    /// @pre \p whichArgs.keySet() contains all names of predicates
    /// and functions occurring in \p p.

    /// @post Every predicate and function f occurring in \p p with
    /// name m has been renamed as m_t0_t1..._tn-1 where n is the
    /// length of \p whichArgs.get(m) and each ti is \p
    /// objTypes.get(arg_i) where arg_i is the i-th argument of f.
    private static void updateNames(Problem p, Map<String,List<Integer>> whichArgs,
				    Map<String,String> objTypes) {
	updateNames(p.getGoal(),whichArgs,objTypes);
	for (Exp e : p.getInit())
	    updateNames(e,whichArgs,objTypes);
    }

    
    /// @pre \p e1 and \p e2 are expressions with connectives ATOM,
    /// NOT, or FN_HEAD.

    /// @return The list of positions of arguments with different
    /// names between \p e1 and \p e2 if they have the same
    /// connective and name, and null otherwise.
    private static List<Integer> isRename(Exp e1, Exp e2) {
	List<Integer> l = null;
	Connective c1 = e1.getConnective();
	Connective c2 = e2.getConnective();
	if (c1 == c2) {	
	    if (c1 == Connective.NOT) {
		e1 = e1.getChildren().get(0);
		e2 = e2.getChildren().get(0);
	    }
	    List<Symbol> atom1 = e1.getAtom();
	    List<Symbol> atom2 = e2.getAtom();
	    if (atom1.get(0).getImage().equals(atom2.get(0).getImage())) {
		l = new LinkedList<>();
		Iterator<Symbol> it1 = atom1.iterator(); it1.next();
		Iterator<Symbol> it2 = atom2.iterator(); it2.next();
		int i = 1;
		while (it1.hasNext()) {
		    Symbol arg1 = it1.next();
		    Symbol arg2 = it2.next();
		    if (!arg1.getImage().equals(arg2.getImage()))
			l.add(i);
		    i++;
		}
	    }
	}
	return l;
    }


    /// @pre All keys of \p modifiedLits are expressions with
    /// connectives ATOM, NOT, or FN_HEAD.

    /// @return A map like \p modifiedLits but where entries whose
    /// keys that are equal up to argument renaming have been merged
    /// by renaming their arguments.
    private static Map<ComparableExp,List<Op>>
	merge(Map<ComparableExp,List<Op>> modifiedLits) throws Exception {
	Map<ComparableExp,List<Op>> newMap = new TreeMap<>();
	for (Map.Entry<ComparableExp,List<Op>> entry : modifiedLits.entrySet()) {
	    Pair<Map.Entry<ComparableExp,List<Op>>,List<Integer>> renamed =
		findRenamed(newMap,entry.getKey());
	    if (renamed == null)
		newMap.put(entry.getKey(),entry.getValue());
	    else
		merge(newMap,renamed.first,entry,renamed.second);
	}
	return newMap;
    }
	

    /// @pre The keys of \p m, and \p e, are expressions with
    /// connectives ATOM, NOT, or FN_HEAD.

    /// @return A pair with an entry in \p m whose key is an argument
    /// renamed version of \p e, and a list with the positions of
    /// arguments that have different name, if such a renamed version
    /// exists; null otherwise.
    private static Pair<Map.Entry<ComparableExp,List<Op>>,List<Integer>>
	findRenamed(Map<ComparableExp,List<Op>> m, ComparableExp e) {
	Pair<Map.Entry<ComparableExp,List<Op>>,List<Integer>> r = null;
	for (Map.Entry<ComparableExp,List<Op>> entry : m.entrySet()) {
	    List<Integer> diff = isRename(entry.getKey(),e);
	    if (diff != null) {
		r = new Pair<>(entry,diff);
		break;
	    }
	}
	return r;
    }


    /// @pre \p e1 belongs to \p m, and the keys of \p e1 and \p e2
    /// are expressions with connectives ATOM, NOT, or FN_HEAD, which
    /// are equal up to argument renaming.

    /// @post The arguments in (a copy of) the keys \a k1 and \a k2 of
    /// \p e1 and \p e2, respectively, are renamed to make them equal,
    /// as follows: if a different argument of the form ?_x is in \a
    /// k1 then the corresponding argument in \a k2 is renamed as ?_x;
    /// if a different argument of the form ?x is in \a k1 then both
    /// arguments in \a k1 and \a k2 are renamed as ?_x. The same
    /// renaming is applied to the variables in the associated lists
    /// of operators. The list of operators are joined and the entry
    /// \p e1 in \p m is replaced with the new (renamed and merged)
    /// version.

    /// @exception Exception if some of the different arguments in \a
    /// k1 or \p k2 does not start with '?'.
    private static void merge(Map<ComparableExp,List<Op>> m,
			      Map.Entry<ComparableExp,List<Op>> e1,
			      Map.Entry<ComparableExp,List<Op>> e2,
			      List<Integer> diff) throws Exception {
	Map<String,String> ren1 = new HashMap<>();
	Map<String,String> ren2 = new HashMap<>();
	Exp k1 = e1.getKey();
	Exp k2 = e2.getKey();
	List<Symbol> atom1 = null;
	List<Symbol> atom2 = null;
	if (k1.getConnective() != Connective.NOT) {
	    atom1 = k1.getAtom();
	    atom2 = k2.getAtom();
	}
	else {
	    atom1 = k1.getChildren().get(0).getAtom();
	    atom2 = k2.getChildren().get(0).getAtom();
	}
	for (int i : diff) {
	    String arg1 = atom1.get(i).getImage();
	    String arg2 = atom2.get(i).getImage();	    
	    if (arg1.charAt(0) != '?' || arg2.charAt(0) != '?')
		throw new Exception("Frame axioms -> merge : arguments which are not variables cannot be renamed");
	    String newName = null;
	    if (arg1.charAt(1) == '_')
		newName = arg1;
	    else {
		newName = "?_" + arg1.substring(1);
		ren1.put(arg1,newName);
	    }
	    ren2.put(arg2,newName);
	}
	List<Op> l1 = rename(e1.getValue(),ren1);
	List<Op> l2 = rename(e2.getValue(),ren2);
	l1.addAll(l2);
	ComparableExp newK1 = new ComparableExp(k1);
	newK1.renameVariables(ren1);
	m.remove(k1);
	m.put(newK1,l1);
    }	      


    /// @return A list with all operators in \p l renamed according to
    /// \p r.
    private static List<Op> rename(List<Op> l, Map<String,String> r) {
	List<Op> nl = new ArrayList<>(l.size());
	for (Op o : l) {
	    Op nop = new Op(o);
	    for (TypedSymbol ts : nop.getParameters())
		ts.renameVariables(r);
	    nop.getPreconditions().renameVariables(r);
	    nop.getEffects().renameVariables(r);
	    nl.add(nop);
	}
	return nl;
    }


    /// @pre \p s contains only expressions with connectives ATOM,
    /// NOT, and FN_HEAD.
    
    /// @return A mapping of the constant numeric functions in \p p,
    /// except for those that are an instance of some function in \p
    /// s.
    private static Map<String,Integer> constants(Problem p, Set<ComparableExp> s) {
	Set<Symbol> fNames = functionNamesIn(s);
	Map<String,Integer> m = new TreeMap<>();
	for (Exp e : p.getInit())
	    if (e.getConnective() == Connective.FN_ATOM) {
		List<Exp> children = e.getChildren();
		Exp function = children.get(0);
		Exp value = children.get(1);
		Symbol fname = function.getAtom().get(0);
		if (!fNames.contains(fname) && value.getConnective() == Connective.NUMBER)
		    m.put(function.toString(),value.getValue().intValue());
	    }
	return m;
    }


    /// @pre \p s contains only expressions with connectives ATOM,
    /// NOT, and FN_HEAD.
    
    /// @return A set with the symbols of the function names in \p s.
    private static Set<Symbol> functionNamesIn(Set<ComparableExp> s) {
	Set<Symbol> r = new HashSet<Symbol>();
	for (ComparableExp e : s)
	    if (e.getConnective() != Connective.NOT) {
		Symbol first = e.getAtom().get(0);
		if (first.getKind() == Symbol.Kind.FUNCTOR)
		    r.add(first);
	    }
	return r;
    }


    /// @return The set of all strings in m.values().
    private static Set<String> valuesOf(Map<String,List<String>> m) {
	Set<String> r = new HashSet<>();
	for (List<String> l : m.values())
	    r.addAll(l);
	return r;
    }

    
    /// @return A string of length \p bits, corresponding to the
    /// binary representation of \p x. Most significant bits are
    /// truncated if the length is not enough.
    private static String toBitString(int x, int bits){
	String bitString = Integer.toBinaryString(x);
	int size = bitString.length();
	StringBuilder sb = new StringBuilder(bits);
	if (bits > size) {
	    for (int i=0; i<bits-size; i++)
		sb.append('0');
	    sb.append(bitString);
	}
	else
	    sb = sb.append(bitString.substring(size-bits,size));	
	return sb.toString();
    }    


}
