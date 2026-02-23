/**
 * @class pddl2smt
 * @author Miquel Bofill
 * @version 1.0
 * @date 2016-06-01
 * @brief Compiler from a restricted subset of PDDL 3.1 to SMT 2.6
 * @see http://smtlib.cs.uiowa.edu/language.shtml
 */

import fr.uga.pddl4j.parser.*;
import java.util.*;
import java.io.*;
import java.nio.file.*;
import javax.json.*;

public class pddl2smt {
  private static boolean useStaticPredicates = false;
  private static boolean useStaticFrameOnly = false;
  private static Set<String> staticAtoms = Collections.emptySet();
  private static Set<String> staticPredicates = Collections.emptySet();
  private static boolean useOperatorFilter = false;
  private static boolean useOperatorFilterDom = false;
  private static boolean useOperatorFilterDomNoPv = false;
  private static Map<String, List<List<Integer>>> jsonOperatorTuples = Collections.emptyMap();

  public static void main(String[] args) throws Exception {
    boolean useJsonFrameAxioms = false;
    boolean inertiaAtoms = false;
    boolean useInitAtoms = false;
    boolean useGoalAtoms = false;
    boolean useFramePrecOpt = false;
    boolean useInertiaEffSkip = false;
    boolean useInertiaEffExpl = false;
    boolean useStaticAtoms = false;
    boolean useStaticInit = false;
    boolean useOpFilterDomNoPv = false;
    String jsonPath = "output.json";

    List<String> argsList = Arrays.asList(args);
    int jIndex = argsList.indexOf("-j");

    // 1. El bloque principal solo se ejecuta si existe -j
    if (jIndex != -1) {
        useJsonFrameAxioms = true;

        // 2. Extraer el path si existe
        if (jIndex + 1 < argsList.size() && !argsList.get(jIndex + 1).startsWith("-")) {
            jsonPath = argsList.get(jIndex + 1);
        }

        // 3. Solo existen dos perfiles válidos tras -j.
        boolean hasProfileOpfilter = argsList.contains("--mode-c");
        boolean hasProfileInertia = argsList.contains("--mode-sc");

        if (hasProfileOpfilter == hasProfileInertia) {
            throw new IllegalArgumentException(
                "Error: con -j debes indicar exactamente un perfil: --mode-c o --mode-sc."
            );
        }

        // No se aceptan flags JSON legacy fuera de los dos perfiles.
        String[] legacyJsonFlags = new String[] {
            "--j-mode-opfilter", "--j-mode-inertia",
            "-u", "--static", "--static-init", "--inertia", "--init", "--goal",
            "--frame-prec-opt", "--inertia-eff-skip", "--inertia-eff-expl",
            "--opfilter", "--opfilter-dom", "--opfilter-dom-no-pv"
        };
        for (String f : legacyJsonFlags) {
            if (argsList.contains(f)) {
                throw new IllegalArgumentException(
                    "Error: con -j ya no se acepta " + f +
                    ". Usa solo --mode-c o --mode-sc."
                );
            }
        }

        // Perfil 1: equivale a -j --init --static-init --opfilter-dom-no-pv
        if (hasProfileOpfilter) {
            useInitAtoms = true;
            useStaticInit = true;
            useOpFilterDomNoPv = true;
        }

        // Perfil 2: equivale a -j --init --static-init --inertia --inertia-eff-skip
        if (hasProfileInertia) {
            useInitAtoms = true;
            useStaticInit = true;
            inertiaAtoms = true;
            useInertiaEffSkip = true;
        }
    } 
    // Opcional: Avisar si intentan usar flags JSON sin -j
    else if (argsList.contains("--mode-c") || argsList.contains("--mode-sc")
             || argsList.contains("--j-mode-opfilter") || argsList.contains("--j-mode-inertia")
             || argsList.contains("-u") || argsList.contains("--inertia") || argsList.contains("--static")
             || argsList.contains("--static-init") || argsList.contains("--init") || argsList.contains("--goal")
             || argsList.contains("--frame-prec-opt") || argsList.contains("--inertia-eff-skip")
             || argsList.contains("--inertia-eff-expl") || argsList.contains("--opfilter")
             || argsList.contains("--opfilter-dom") || argsList.contains("--opfilter-dom-no-pv")) {
        System.out.println("Advertencia: los flags JSON se ignorarán porque falta el flag -j.");
    }    
    useStaticPredicates = useStaticAtoms;
    useStaticFrameOnly = useStaticInit;
    if (useStaticPredicates && useStaticFrameOnly) {
        useStaticFrameOnly = false;
    }
    useOperatorFilter = false;
    useOperatorFilterDom = false;
    useOperatorFilterDomNoPv = useOpFilterDomNoPv;

    if (useInertiaEffSkip && useInertiaEffExpl) {
        throw new IllegalArgumentException("Error: --inertia-eff-skip y --inertia-eff-expl son excluyentes.");
    }
    if ((useInertiaEffSkip || useInertiaEffExpl) && !inertiaAtoms) {
        throw new IllegalArgumentException("Error: --inertia-eff-skip y --inertia-eff-expl requieren --inertia.");
    }

    // Standard PDDL args are the first 6: -o D -f P -t N
    if (args.length >= 6 && args[0].equals("-o") && args[2].equals("-f")) {
      // Automatic JSON regeneration
      if (useJsonFrameAxioms) {
          // Only regenerate if the JSON file does not already exist.
          if (!Files.exists(Paths.get(jsonPath))) {
              regenerateJsonFile(args[1], args[3], jsonPath);
          }
      }

      Parser parser = new Parser();
      try {
        parser.parse(args[1], args[3]);
        if (!parser.getErrorManager().isEmpty()) {
          parser.getErrorManager().printAll();
          throw new IllegalArgumentException("PDDL parse errors detected. Aborting SMT generation.");
        }
        Domain d = parser.getDomain();
        Problem p = parser.getProblem();
        if (args[4].equals("-t")) {
          int tTime = Integer.parseInt(args[5]);
          if (tTime < 0) {
            throw new IllegalArgumentException("Error: -t debe ser un entero no negativo.");
          }
          printPreamble();
          translate(d, p, tTime, useJsonFrameAxioms, jsonPath, inertiaAtoms, useInitAtoms, useGoalAtoms, useFramePrecOpt, useInertiaEffSkip, useInertiaEffExpl, useOpFilterDomNoPv);
        } else {
          printHelp();
        }
      } catch (Exception e) {
        System.err.println();
        System.err.println("Error processing " + args[1] + " + " + args[3]);
        System.err.println();
        e.printStackTrace();
      }
    } else {
      printHelp();
    }
  }
  private static void printHelp() {
    System.out.println("\nCompiler from a restricted subset of PDDL 3.1 to "
                       + "SMT 2.6 (time-unrolled encoding).\n");
    System.out.println("Usage:\n");
    System.out.println("OPTIONS          				"
                       + "	DESCRIPTIONS\n");
    System.out.println("-o <str>         				"
                       + "	operator file name");
    System.out.println("-f <str>         				"
                       + "	fact file name");
    System.out.println("-t <integer>     				"
                       + "	number of time steps (>= 0)\n");
    System.out.println("Optional (only with -j):");
    System.out.println("  --mode-c                    profile: --init --static-init --opfilter-dom-no-pv");
    System.out.println("  --mode-sc                   profile: --init --static-init --inertia --inertia-eff-skip");
    System.out.println("  (exactly one of the two profiles is required when using -j)\n");
  }

  /// @post Outputs the fixed preamble.
  private static void printPreamble() {
    //	System.out.println(";; (set-logic UFLIA)"); // CVC4 complaints of data
    // types
    System.out.println(
        "(set-info :source |\nThis benchmark was automatically translated "
        + "into SMT-LIB format from PDDL 3.1 format. Contact Miquel Bofill "
        + "<miquel.bofill@udg.edu> for more information.\n|)");
    System.out.println(
        ";; (set-info :smt-lib-version 2.6)"); // CVC4 complaints version
                                               // unsupported
    System.out.println("(set-info :category \"crafted\")");
    System.out.println("(set-info :status sat)\n");
    System.out.println("(set-option :produce-models true)\n");
    //	System.out.println("(set-option :fmf-bound-int true)\n"); //CVC4
  }

  /// @post Outputs an SMT2 translation of the PDDL instance defined
  /// by \p d and \p p using a fixed time horizon \p pTime.
  private static void translate(Domain pDomain, Problem pProblem,
                                int pTime,
                                boolean useJson, String jsonPath, boolean inertiaAtoms, boolean useInitAtoms, boolean useGoalAtoms, boolean useFramePrecOpt, boolean useInertiaEffSkip, boolean useInertiaEffExpl, boolean useOpFilterDomNoPv) throws Exception {
    Map<String, List<String>> dtypes = dataTypes(pDomain, pProblem);
    Hashtable<String, Object> equivalences;
    Map<String, List<String>> subtypes = baseSubtypes(pDomain, dtypes.keySet());
    Set<String> basetypes = valuesOf(subtypes);
    //    if (pTime >= 0) {
    //      Map<String, List<Integer>> renArgs = unfold1(pDomain, subtypes,
    //      basetypes);
    //    }
    Map<String, List<Integer>> renArgs = unfold(pDomain, subtypes, basetypes);
    //    }
    Set<ComparableExp> modifiedLitsKeys = new TreeSet<>();
    Map<String, Map<ComparableExp, List<Op>>> modifiedLitsQuants = modifiedNoQuant(pDomain);
    for (Map<ComparableExp, List<Op>> submap : modifiedLitsQuants.values()) {
      modifiedLitsKeys.addAll(submap.keySet());
    }
    Set<String> dtime = collectNames(modifiedLitsKeys);
    Map<String, String> objTypes = collectTypes(pProblem);
    updateNames(pProblem, renArgs, objTypes);
    Map<String, Integer> constFunc = constants(pProblem, modifiedLitsKeys);
    equivalences = establishEquivalences(dtypes);
    if (useStaticPredicates || useStaticFrameOnly) {
      loadStaticAtoms(jsonPath);
    }
    if (useOperatorFilter || useOperatorFilterDom || useOpFilterDomNoPv) {
      loadJsonOperators(jsonPath, equivalences);
    }
    Map<String, String> newVars = checkSameParameters(pDomain.getOperators(), pTime);
    printFunctions(pDomain, dtime, pTime);
    List<Pair<String, Integer>> predValues = printValues(dtypes, pTime, newVars);
    if (useOpFilterDomNoPv) {
      printTrivialPossibleValues();
    } else {
      // JSON-based value restrictions are only available when -j is enabled.
      Map<String, Set<Integer>> restrictedValues = Collections.emptyMap();
      if (useJson) {
        restrictedValues = getRestrictedValues(pDomain, jsonPath, equivalences);
      }
      printTypesRestrictions(predValues, restrictedValues);
    }
    printActions(pDomain.getOperators(), pTime);
    if (useOperatorFilterDom || useOpFilterDomNoPv) {
      printOperatorFilterTables(pDomain.getOperators());
    }
    // CAMBIO: A partir de aquí tengo que generar los asserts correspondientes
    printTransitionFunction(pDomain, Collections.emptyMap(), modifiedLitsQuants, dtime,
                            dtypes, constFunc, pTime, equivalences, useJson, jsonPath, inertiaAtoms, pProblem, useInitAtoms, useGoalAtoms, useFramePrecOpt, useInertiaEffSkip, useInertiaEffExpl);
    
    printInitialState(pDomain, pProblem, dtypes, dtime, equivalences);
    printGoal(pProblem, dtime, pTime, equivalences);
    // Eliminar esta linea también porque el tiempo no influye.
    // System.out.println("\n(declare-const _n _time)\n");
    // CAMBIO: Modificar esta linea porque son funciones de tiempo en las cual
    // hacen assert
    // System.out.println("(assert (and init (or (goal 0) (and (<= 0 _n) (trans
    // _n) (goal (+ _n 1))))))\n");
    System.out.println();
    System.out.println("(assert (and init possiblevalues trans goal))\n");
    // CAMBIO: Hacer los assert directamente cuando se vayan leyendo las cosas
    // Mantener como está actualmente.
    // Expresiones necesarias para que el SMT-Solver funcione correctamente.
    System.out.println("(check-sat)");
    System.out.println("(get-model)");
    System.out.println("(exit)");
  }

  private static void printExtraVariables(Map<String, String> newVars) {
    for (String key : newVars.keySet()) {
      System.out.print("(declare-fun ");
      System.out.println(key + " () Int)");
    }
  }

  private static List<Pair<String, Integer>>
  printValues(Map<String, List<String>> dtypes, int pTime,
              Map<String, String> newVariables) {
    List<Pair<String, Integer>> predValues = new ArrayList<>();
    System.out.println(";; Numeric values of predicates");
    for (Map.Entry<String, List<String>> entry : dtypes.entrySet()) {
      for (int steps = 0; steps <= pTime; steps++) {
        String nombre = entry.getKey() + "_" + steps;
        int typeLength = entry.getValue().size();
        predValues.add(new Pair<>(nombre, typeLength));
        System.out.println("(declare-fun " + nombre + " () Int)");
      }
    }
    for (String nv : newVariables.keySet()) {
      String tipo = newVariables.get(nv);
      // nombre = nv
      int typeLength = dtypes.get(tipo).size();
      predValues.add(new Pair<>(nv, typeLength));
      System.out.println("(declare-fun " + nv + " () Int)");
    }
    return predValues;
  }
  private static Map<String, String> checkSameParameters(List<Op> pOperators,
                                                         int pTime) {
    Map<String, String> newVariables = new Hashtable<>();
    for (int i = 0; i < pTime; i++) {
      for (Op o : pOperators) {
        Iterator<TypedSymbol> it = o.getParameters().iterator();
        List<String> elemRepeated = new ArrayList<>();
        while (it.hasNext()) {
          TypedSymbol t = it.next();
          String nuevoNombre = t.getTypes().getFirst().getImage();
          String tipo = nuevoNombre;
          int nVeces = Collections.frequency(elemRepeated, nuevoNombre);
          elemRepeated.add(nuevoNombre);
          if (nVeces != 0) {
            nuevoNombre =
                generateNewVar(t.getTypes().getFirst().getImage(), nVeces, i);
            newVariables.put(nuevoNombre, tipo);
          }
        }
      }
    }
    return newVariables;
  }
  private static Hashtable<String, Object>
  establishEquivalences(Map<String, List<String>> dtypes) {
    Hashtable<String, Object> table = new Hashtable<>();
    for (Map.Entry<String, List<String>> entry : dtypes.entrySet()) {
      List<String> values = entry.getValue();
      for (int i = 0; i < values.size(); i++) {
        Pair<String, Integer> typeNumber = new Pair<>(entry.getKey(), i + 1);
        table.put(values.get(i), typeNumber);
      }
    }
    return table;
  }

  private static void
  printTypesRestrictions(List<Pair<String, Integer>> predValues, Map<String, Set<Integer>> restrictedValues) {
    System.out.println("\n(define-fun possiblevalues () Bool ");
    System.out.println("  (and ");
    for (Pair<String, Integer> par : predValues) {
      Integer numberPar = par.getSecond();
      String nombre = par.getFirst();
      
      // Extract base name (remove _time suffix)
      int lastUnderscore = nombre.lastIndexOf('_');
      String baseName = (lastUnderscore != -1) ? nombre.substring(0, lastUnderscore) : nombre;
      
      if (restrictedValues.containsKey(baseName)) {
          Set<Integer> allowed = restrictedValues.get(baseName);
          if (allowed.isEmpty()) {
              System.out.print("\t(false)\n"); 
          } else {
              System.out.print("\t(or");
              for (Integer val : allowed) {
                  System.out.print(" (= " + nombre + " " + val + ")");
              }
              System.out.print(")\n");
          }
      } else {
          if (numberPar == 1)
            System.out.print("\t(= " + nombre + " 1)\n");
          else {
            System.out.print("\t(>= " + nombre + " 1)\n");
            System.out.print("\t(<= " + nombre + " " + numberPar + ")\n");
          }
      }
    }
    System.out.println("  )");
    System.out.println(")\n");
  }

  private static void printTrivialPossibleValues() {
    System.out.println("\n(define-fun possiblevalues () Bool true)\n");
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
  /// (ictions will be prefixed by '_' in order to extract a
  /// plan from the model).
  private static Map<String, List<String>> dataTypes(Domain d, Problem p) {
    List<TypedSymbol> objects = new ArrayList<>(d.getConstants());
    objects.addAll(p.getObjects());
    Map<String, List<String>> dtypes = groupByType(objects);
    return dtypes;
  }

  /// @return A map where key = type and value = list of objects of
  /// that type, collected from \p objects.
  private static Map<String, List<String>>
  groupByType(List<TypedSymbol> objects) {
    TreeMap<String, List<String>> m = new TreeMap<>();
    for (TypedSymbol s : objects) {
      String type = s.getTypes()
                        .getFirst()
                        .getImage(); // Caution: assuming only one type.
      String object = s.getImage();
      List<String> l = new ArrayList<>();
      List<String> lm = m.putIfAbsent(type, l);
      if (lm == null)
        l.add(object);
      else
        lm.add(object);
    }
    return m;
  }

  /// @return A map with key = object name and value = object's type
  /// name, for all objects in \p p.
  public static Map<String, String> collectTypes(Problem p) {
    Map<String, String> m = new TreeMap<>();
    List<TypedSymbol> objects = new ArrayList<>(p.getObjects());
    for (TypedSymbol s : objects)
      m.put(s.getImage(), s.getTypes().get(0).getImage());
    return m;
  }

  /// @return A map where key = type and value = list of base
  /// subtypes in \p base, for all types in \p d.
  private static Map<String, List<String>> baseSubtypes(Domain d,
                                                        Set<String> base) {
    TreeMap<String, List<String>> m = new TreeMap<>();
    List<TypedSymbol> lt = d.getTypes();
    for (String type : base) {
      // Add type to all of its supertypes
      List<Symbol> supertypes = getSymbol(lt, type).getTypes();
      while (!supertypes.isEmpty()) {
        // Assuming only one supertype
        String supertype = supertypes.get(0).getImage();
        List<String> ls = new ArrayList<>();
        List<String> lsm = m.putIfAbsent(supertype, ls);
        if (lsm == null)
          ls.add(type);
        else
          lsm.add(type);
        supertypes = getSymbol(lt, supertype).getTypes();
      }
    }
    // If a supertype is also used directly by objects in the problem,
    // keep its own type as a valid base alternative during unfolding.
    for (Map.Entry<String, List<String>> entry : m.entrySet()) {
      String supertype = entry.getKey();
      if (base.contains(supertype) && !entry.getValue().contains(supertype)) {
        entry.getValue().add(supertype);
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
  private static void printDataTypes(Map<String, List<String>> m) {
    System.out.println("(declare-datatypes () (");
    for (Map.Entry<String, List<String>> entry : m.entrySet()) {
      System.out.print(" (" + entry.getKey());
      for (String object : entry.getValue())
        System.out.print(" (" + object + ")");
      System.out.println(")");
    }
    System.out.println("))\n");
  }

  /// @post Outputs function declarations collected from predicates
  /// and functions in \p d for an unrolled time horizon \p pTime.
  private static void printFunctions(Domain pDomain, Set<String> pDtime,
                                     int pTime) {
    System.out.println(";; Predicates");
    printFunctions(pDomain.getPredicates(), "Bool", pDtime, pTime);
    System.out.println("\n;; Numeric functions");
    printFunctions(pDomain.getFunctions(), "Int", pDtime, pTime);
    System.out.println();
  }

  /// @post Outputs SMT2 function declaration as derived from \p
  /// functions, with return type \p returnType, and adding a
  /// '_time' argument for those whose name is in \p dtime.

  private static void printFunctions(List<NamedTypedList> functions,
                                     String returnType, Set<String> dtime,
                                     int pTime) {
    if (pTime < 0) {
      for (NamedTypedList f : functions) {
        String name = f.getName().getImage();
        boolean dependsOnTime = dtime.contains(name);
        // if (!ignore || dependsOnTime) {
        System.out.print("(declare-fun " + name + " (");
        printFunctionsArguments(f, -1);
        if (dependsOnTime) {
          System.out.println(" _time ) " + returnType + ")");
        } else {
          System.out.println(" ) " + returnType + ")");
        }
      }
      // CAMBIO: Se declaran las funciones en base a los paso del tiempo.
    } else {
      for (NamedTypedList f : functions) {
        String name = f.getName().getImage();
        boolean dependsOnTime = dtime.contains(name);
        if (dependsOnTime) {
          for (int i = 0; i <= pTime; i++) {
            System.out.print("(declare-fun " + name + "_" + i + " (");
            printFunctionsArguments(f, i);
            System.out.println(" ) " + returnType + ")");
          }
        } else {
          System.out.print("(declare-fun " + name + " (");
          printFunctionsArguments(f, 0);
          System.out.println(" ) " + returnType + ")");
        }
      }
    }
  }

  // CAMBIO: Metodo extraido porque se repetía para printear los parametros de
  // las funciones.
  private static void printFunctionsArguments(NamedTypedList pArguments,
                                              int pTime) {
    for (TypedSymbol s : pArguments.getArguments()) {
      String typeName = s.getTypes().get(0).getImage();
      if (pTime < 0)
        System.out.print(" " + typeName);
      else
        // System.out.print(" " + typeName + "_" + pTime);
        System.out.print(" Int");
    }
  }

  /// @return A map where keys are the literals (and their negations) and
  /// functions which are modified in the effects of operators in \p d, and
  /// values are the list of operators that assign that literal or function.
  /// Only (negated) predicates, and function atoms modified by increase or
  /// decrease operators are considered (scale-up and scale-down effects not
  /// supported).

  private static Map<String, Map<ComparableExp, List<Op>>>
  modifiedNoQuant(Domain d) {
      //OPCIONNNNNNN
    Map<String, Map<ComparableExp, List<Op>>> m = new TreeMap<>();
    for (Op o : d.getOperators()) {
      addModifiedNoQuant(m, o, o.getEffects());
    }
    return m;
  }

  /// @return A map where keys are the literals (and their negations) and
  /// functions which are modified in the effects of operators in \p d, and
  /// values are the list of operators that assign that literal or function.
  /// Only (negated) predicates, and function atoms modified by increase or
  /// decrease operators are considered (scale-up and scale-down effects not
  /// supported).

  private static Map<ComparableExp, List<Op>> modified(Domain d) {
    Map<ComparableExp, List<Op>> m = new TreeMap<>();
    for (Op o : d.getOperators()) {
      addModified(m, o, o.getEffects());
    }
    return m;
  }

  /// @post \p m is updated with keys for those (negated) predicates
  /// which occur in \p e, and for those function atoms which are
  /// modified by assign, increase or decrease operators in \p e
  /// (scale-up and scale-down effects not supported). Operator \p o
  /// is added to the list associated with each of those keys.
  private static void addModified(Map<ComparableExp, List<Op>> m, Op o, Exp e) {
    Connective c = e.getConnective();
    boolean negated = false;          // Must add negated atom?
    ComparableExp negatedAtom = null; // Negated atom
    switch (c) {
    case ATOM:
      // Either if atom or negated atom, build negated literal and add it as
      // well to the map if absent
      negatedAtom = new ComparableExp(Connective.NOT);
      negatedAtom.addChild(e);
    case NOT:
      negated = true;
      if (negatedAtom == null)
        negatedAtom = new ComparableExp(e.getChildren().get(0));
    case FN_HEAD:
      ComparableExp ce = new ComparableExp(e);
      List<Op> l = new ArrayList<>();
      List<Op> lm = m.putIfAbsent(ce, l);
      if (lm == null)
        l.add(o);
      else
        lm.add(o);
      if (negated)
        m.putIfAbsent(negatedAtom, new ArrayList<>());
      break;
    case ASSIGN:
    case INCREASE:
    case DECREASE:
      addModified(m, o, e.getChildren().get(0));
      break;
    case WHEN:
      addModified(m, o, e.getChildren().get(1));
      break;
    default:
      for (Exp f : e.getChildren())
        addModified(m, o, f);
    }
  }

  private static void
  addModifiedNoQuant(Map<String, Map<ComparableExp, List<Op>>> m, Op o, Exp e) {
    switch (e.getConnective()) {

    case ATOM: {
      ComparableExp ce = new ComparableExp(e);
      String name = getExpressionName(e, false);
      addToMap(m, name, ce, o);

      // También registrar la versión negada sin operador asociado
      ComparableExp negated = new ComparableExp(Connective.NOT);
      negated.addChild(e);
      String negatedName = getExpressionName(e, true);
      m.computeIfAbsent(negatedName, k -> new TreeMap<>())
          .putIfAbsent(negated, new ArrayList<>());
      break;
    }

    case NOT: {
      Exp inner = e.getChildren().get(0);
      ComparableExp ce = new ComparableExp(e);
      String name = getExpressionName(e, true);
      addToMap(m, name, ce, o);

      // También registrar la versión positiva sin operador asociado
      ComparableExp positive = new ComparableExp(inner);
      String posName = getExpressionName(inner, false);
      m.computeIfAbsent(posName, k -> new TreeMap<>())
          .putIfAbsent(positive, new ArrayList<>());
      break;
    }

    case FN_HEAD: {
      ComparableExp ce = new ComparableExp(e);
      String name = getExpressionName(e, false);
      addToMap(m, name, ce, o);
      break;
    }

    case ASSIGN:
    case INCREASE:
    case DECREASE:
      // En estos casos, el primer hijo es la función modificada
      addModifiedNoQuant(m, o, e.getChildren().get(0));
      break;

    case WHEN:
      // Solo se consideran los efectos (hijo 1), no las condiciones
      addModifiedNoQuant(m, o, e.getChildren().get(1));
      break;

    default:
      // Casos como AND, OR, etc.
      for (Exp child : e.getChildren()) {
        addModifiedNoQuant(m, o, child);
      }
    }
  }

  // V2
  //  private static void addModifiedNoQuant(Map<String, Map<ComparableExp,
  //  List<Op>>> m, Op o, Exp e) {
  //    Connective c = e.getConnective();
  //    boolean negated = false;
  //    ComparableExp negatedAtom = null;
  //
  //    switch (c) {
  //      case ATOM:
  //        ComparableExp ce = new ComparableExp(e);
  //        String name = getExpressionName(e, false);
  //        addToMap(m, name, ce, o);
  //
  //        // También agregar versión negada en su propio bucket
  //        ComparableExp negatedV = new ComparableExp(Connective.NOT);
  //        negatedV.addChild(e);
  //        String negatedName = getExpressionName(negatedV, true);
  //        m.computeIfAbsent(negatedName, k -> new TreeMap<>())
  //         .putIfAbsent(negatedV, new ArrayList<>());
  //        break;
  //      case NOT:
  //        Exp inner = e.getChildren().get(0);
  //        ComparableExp ce = new ComparableExp(e);
  //        String name = getExpressionName(e, true);
  //        addToMap(m, name, ce, o);
  //
  //        // También asegurar que la versión positiva esté registrada
  //        ComparableExp positive = new ComparableExp(inner);
  //        String posName = getExpressionName(inner, false);
  //        m.computeIfAbsent(posName, k -> new HashMap<>())
  //         .putIfAbsent(positive, new ArrayList<>());
  //        break;
  //      case FN_HEAD:
  //        ComparableExp ce = new ComparableExp(e);
  //        String name = getExpressionName(e, false);
  //        addToMap(m, name, ce, o);
  //        break;
  //      case ASSIGN:
  //      case INCREASE:
  //      case DECREASE:
  //        addModifiedNoQuant(m, o, e.getChildren().get(0));
  //        break;
  //
  //      case WHEN:
  //        addModifiedNoQuant(m, o, e.getChildren().get(1));
  //        break;
  //
  //      default:
  //        for (Exp f : e.getChildren())
  //          addModifiedNoQuant(m, o, f);
  //    }
  //  }

  private static void addToMap(Map<String, Map<ComparableExp, List<Op>>> m,
                               String name, ComparableExp ce, Op o) {
    Map<ComparableExp, List<Op>> submap =
        m.computeIfAbsent(name, k -> new TreeMap<>());
    List<Op> list = submap.computeIfAbsent(ce, k -> new ArrayList<>());
    list.add(o);
  }

  private static String getExpressionName(Exp e, boolean negated) {
    Exp target = e;
    if (e.getConnective() == Connective.NOT) {
      target = e.getChildren().get(0);
      negated = true;
    }

    // El nombre del predicado o función suele ser el primer símbolo del ATOM
    String baseName = target.getAtom().get(0).getImage();
    return negated ? "not_" + baseName : baseName;
  }

    private static String getExpressionNameConst(Exp e, boolean negated) {
        Exp target = e;
        if (e.getConnective() == Connective.NOT) {
            target = e.getChildren().get(0);
            negated = true;
        }

        // El nombre del predicado o función suele ser el primer símbolo del ATOM
        String baseName = target.getAtom().get(0).getImage();
        return negated ? "not_" + baseName : baseName;
    }

  /// @post Outputs the function declarations corresponding to
  /// the signatures of \p actions. Adds '_' as prefix for all
  /// action names.
  private static void printActions(List<Op> actions, int pTime) {
    System.out.println(";; Actions");
    if (pTime < 0) {
      for (Op o : actions) {
        Symbol name = o.getName();
        name.setImage('_' + name.getImage());
        System.out.print("(declare-fun " + o.getName() + " (");
        for (TypedSymbol s : o.getParameters())
          System.out.print(" " + s.getTypes().get(0).getImage());
        // CAMBIO: Aqui hay que quitar el _time y añadirlo al nombre con el
        // tiempo correspondiente.
        System.out.println(" _time ) Bool)");
      }
    } else {
      for (Op o : actions) {
        // CREO QUE ES < Y NO <=
        for (int i = 0; i < pTime; i++) {
          Symbol name = o.getName();
          if (i == 0)
            name.setImage('_' + name.getImage());
          System.out.print("(declare-fun " + o.getName() + "_" + i + " (");
          for (TypedSymbol s : o.getParameters())
            // System.out.print(" " + s.getTypes().get(0).getImage() + "_" + i);
            System.out.print(" Int");
          // CAMBIO: Aqui hay que quitar el _time y añadirlo al nombre con el
          // tiempo correspondiente.
          System.out.println(" ) Bool)");
        }
      }
    }
    System.out.println();
  }

  /// @pre \p modifiedLits is a map where keys are the literals
  /// which are modified in the effects of operators in \p d, and
  /// values are the list of operators that modify that literal. \p
  /// dependOntime are the predicate and function names of those
  /// literals. \p dtypes is a map where key = type and value = list
  /// of objects of that type.

  /// @post Outputs the transition function for operators in \p d
  /// using an unrolled time horizon.
      private static void printTransitionFunction(
          Domain d, Map<ComparableExp, List<Op>> modifiedLits,
          Map<String, Map<ComparableExp, List<Op>>> modifiedLitsQuants,
          Set<String> dtime, Map<String, List<String>> dtypes,
          Map<String, Integer> constFunc, int pTime,
          Map<String, Object> pEquivalences, boolean useJson, String jsonPath, boolean inertiaAtoms, Problem pProblem, boolean useInitAtoms, boolean useGoalAtoms, boolean useFramePrecOpt, boolean useInertiaEffSkip, boolean useInertiaEffExpl) throws Exception {
        System.out.println(";; Transition function");
        // CAMBMIO: Eliminar el _time
        System.out.println("(define-fun trans () Bool");
        // CAMBIO: Eliminar el forall
        // System.out.println("  (forall ((t0 _time)) (let ((t1 (+ t0 1)))");
        // System.out.println("    (=> (<= 0 t0 bound) (and");
        System.out.println("    (and");
        String prefix = "         ";
        //  System.out.println(prefix + ";; At least one action is executed");
        //  printAtLeastOne(prefix,d);
        printExecutionAxioms(prefix, d, dtime, dtypes, null, constFunc,
                             pEquivalences, pTime);
        if (useJson) {
            Set<String> initAtoms = useInitAtoms ? collectInitAtoms(pProblem) : Collections.emptySet();
            Set<String> goalAtoms = useGoalAtoms ? collectGoalAtoms(pProblem) : Collections.emptySet();
            if (!goalAtoms.isEmpty()) {
              initAtoms = new HashSet<>(initAtoms);
              initAtoms.addAll(goalAtoms);
            }
            if (useFramePrecOpt) {
              Set<String> precAtoms = collectPreconditionAtomsFromJsonOperators(jsonPath, d);
              if (!precAtoms.isEmpty()) {
                initAtoms = new HashSet<>(initAtoms);
                initAtoms.addAll(precAtoms);
              }
            }
            printFrameAxiomsFromJSON(jsonPath, pTime, pEquivalences, modifiedLitsQuants, d, dtypes, dtime, inertiaAtoms, initAtoms, useInertiaEffSkip, useInertiaEffExpl);
        } else {
            printFrameAxiomsNoQuant(prefix, d, modifiedLitsQuants, pTime,
                                pEquivalences,
                                dtypes); // Includes at-most-one like constraints
        }
        printAtMostOneNoQuant(prefix, d, pTime);
        printAtLeastOneNoQuant(prefix, d, pTime);
        System.out.println("))");
    // System.out.println(")))))");
  }

  /// @pre All actions in \p d have at least one parameter.

  /// @post Outputs or of actions in \p d at time t0, prefixed with
  /// \p prefix.
  private static void printAtLeastOne(String prefix, Domain d) {
    System.out.println(prefix +
                       ";; At least one action is executed (optional)");
    System.out.println(prefix + "(or");
    String newPrefix = prefix + "  ";
    for (Op o : d.getOperators()) {
      System.out.print(newPrefix + "(exists ");
      printArguments(o.getParameters(), "");
      System.out.print(newPrefix + "  " + action(o, "t0", ""));
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
  private static void
  printExecutionAxioms(String prefix, Domain d, Set<String> dtime,
                       Map<String, List<String>> dtypes, String qObjects,
                       Map<String, Integer> constFunc,
                       Map<String, Object> pEquivalences, int pTime)
      throws Exception {
    for (Op o : d.getOperators())
      if (pTime >= 0) {
        printExecutionAxiomsNoQuant(prefix, o, d, dtime, pEquivalences, pTime);
      } else if (qObjects.equals("all")) {
        printExecutionAxioms(prefix, o, d, dtime);
      } else if (qObjects.equals("time")) {
        printExecutionAxiomsUnfolded(prefix, o, d, dtime, dtypes, constFunc);
      } else {
        // Hay que generar el correspondiente
        printExecutionAxioms(prefix, o, d, dtime);
      }
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
  private static void printExecutionAxioms(String prefix, Op o, Domain d,
                                           Set<String> dtime) throws Exception {
    String newPrefix = prefix + '\t';
    System.out.println(prefix + ";; Execution of " + o.getName());
    System.out.print(prefix + "(forall ");
    printArguments(o.getParameters(), "");
    System.out.print(prefix + "  (=> ");
    System.out.print(action(o, "t0", ""));
    System.out.println(" (and");
    System.out.println(newPrefix + ";; Precondition holds at time t0");
    printExpression(newPrefix, "t0", "t1", true, o.getPreconditions(), dtime,
                    true);
    System.out.println(newPrefix + ";; Effects hold at time t1");
    printExpression(newPrefix, "t0", "t1", false, o.getEffects(), dtime, true);
    System.out.println(
        newPrefix +
        ";; The same operator is not executed with other parameters");
    System.out.print(newPrefix + "(not (exists ");
    printArguments(o.getParameters(), "2");
    System.out.print(newPrefix + "\t(and ");
    System.out.print(action(o, "t0", "2"));
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
        printArguments(o2.getParameters(), "");
        System.out.print(newPrefix + "\t" + action(o2, "t0", ""));
        System.out.println();
        System.out.println(newPrefix + "))");
      }
    System.out.println(prefix + ")))");
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
  private static void
  printExecutionAxiomsNoQuant(String prefix, Op o, Domain d, Set<String> dtime,
                              Map<String, Object> pEquivalences, int pTime)
      throws Exception {
    String newPrefix = prefix + '\t' + '\t';
    for (int i = 0; i < pTime; i++) {
      System.out.println(prefix + ";; Execution of " + o.getName() + "_" + i);
      // System.out.println(prefix + "(and ");
      //  Print forall parameters
      // printArguments(o.getParameters(), "");
      System.out.print(prefix + "  (=> ");
      System.out.println(actionNoQuant(o, "", i));
      System.out.println(prefix + "\t  (and");
      if (useOperatorFilter) {
        printOperatorFilter(prefix + "\t\t", o, i);
      } else if (useOperatorFilterDom || useOperatorFilterDomNoPv) {
        printOperatorFilterDom(prefix + "\t\t", o, i);
      }
      System.out.println(newPrefix + ";; Precondition holds at time t0");
      List<TypedSymbol> parameters = o.getParameters();
      Hashtable<String, Object> param = establishParameters(parameters);
      if (!o.getPreconditions().getChildren().isEmpty() ||
          o.getPreconditions().getAtom() != null) {
        printExpressionNoQuant(newPrefix, i, i + 1, true, o.getPreconditions(),
                               dtime, true, param, pEquivalences);
      } else {
        System.out.println(newPrefix + ";; There's no precondition");
        System.out.println();
      }
      System.out.println(newPrefix + ";; Effects hold at time t1");
      printExpressionNoQuant(newPrefix, i, i + 1, false, o.getEffects(), dtime,
                             true, param, pEquivalences);
      System.out.println(prefix + "\t  )");
      System.out.println(prefix + "  )");
      // En teoria esto no hace falta
      /*
//			System.out.println(newPrefix + ";; The same operator is
not executed with other parameters");
//			System.out.print(newPrefix + "(not (exists ");
//			printArguments(o.getParameters(), "2");
//			System.out.print(newPrefix + "\t(and ");
//			System.out.print(action(o, "t0", "2"));
//			System.out.println();
//			System.out.print(newPrefix + "\t    ");
//			List<TypedSymbol> lp = o.getParameters();
//			if (lp.size() > 1)
//				  System.out.print(" (or");
//			for (TypedSymbol t : lp) {
//				  System.out.print(" (not (= " + t.getImage() +
" " + t.getImage() + "2))");
//			}
//			if (lp.size() > 1)
//				  System.out.println(")");
//			else
//				  System.out.println();
//			System.out.println(newPrefix + "\t)");
//			System.out.println(newPrefix + "))");
      // Hasta aqui
       */

      // Parte del código que sirve para que no se ejecuten acciones en
      // paralelo, pero igual nos interesa así que de momento no lo anado.
      /*
//			System.out.println(newPrefix + ";; No other operator is
executed");
//			for (Op o2 : d.getOperators())
//				if (!o2.equals(o)) {
//					System.out.print(newPrefix + "(not
(exists ");
//					printArguments(o2.getParameters(), "");
//					System.out.print(newPrefix + "\t" +
action(o2, "t0", ""));
//					System.out.println();
//					System.out.println(newPrefix + "))");
//				}
//			System.out.println(prefix + ")))");
       */
    }
  }

  private static Hashtable<String, Object>
  establishParameters(List<TypedSymbol> parameters) {
    Hashtable<String, Object> table = new Hashtable<>();
    for (TypedSymbol p : parameters) {
      String tipo = p.getTypes().getFirst().getImage();
      while (table.containsValue(tipo)) {
        tipo += "_new";
      }
      table.put(p.getImage(), tipo);
    }
    return table;
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
  private static void
  printExecutionAxiomsUnfolded(String prefix, Op o, Domain d, Set<String> dtime,
                               Map<String, List<String>> dtypes,
                               Map<String, Integer> constFunc)
      throws Exception {
    String newPrefix = prefix + '\t';
    List<TypedSymbol> lparam = o.getParameters();
    List<List<String>> larg = split(combine(
        lparam.iterator(), dtypes)); // List of argument value combinations
    List<String> argn = new ArrayList<>(lparam.size()); // Names of parameters
    System.out.println(prefix + ";; Execution of " + o.getName());
    for (TypedSymbol ts : lparam)
      argn.add(ts.getImage());
    for (List<String> argv : larg) {
      System.out.print(prefix + "(=> ");
      System.out.print(action(o, "t0", argv));
      System.out.println(" (and");
      System.out.println(newPrefix + ";; Precondition holds at time t0");
      printExpressionUnfolded(newPrefix, "t0", "t1", true, o.getPreconditions(),
                              dtime, true, argn, argv, dtypes, constFunc);
      System.out.println(newPrefix + ";; Effects hold at time t1");
      printExpressionUnfolded(newPrefix, "t0", "t1", false, o.getEffects(),
                              dtime, true, argn, argv, dtypes, constFunc);
      System.out.println(prefix + "))");
    }
  }

  /// @return The term corresponding to action \p o with \p l added
  /// as last argument. Each parameter name is added \p s as suffix.
  private static String action(Op o, String l, String s) {
    StringBuilder r = new StringBuilder("(" + o.getName() + " ");
    for (TypedSymbol t : o.getParameters())
      r.append(t.getImage()).append(s).append(" ");
    r.append(l).append(")");
    return r.toString();
  }

  private static String generateNewVar(String pName, int pNTimes, int pTime) {
    String namenew = pName + "_new";
    for (int i = 0; i < pNTimes - 1; i++) {
      namenew += "_new";
    }
    namenew += "_" + pTime;
    return namenew;
  }

  private static String generateVarType(String pName, int pNTimes, int pTime){
    String namenew;
    if (pNTimes == 0){
      namenew = pName + "_" + pTime;
    } else {
      namenew = generateNewVar(pName, pNTimes, pTime);
    }
    return namenew;
  }

  /// @return The term corresponding to action \p o with \p l added
  /// as last argument. Each parameter name is added \p s as suffix.
  private static String actionNoQuant(Op o, String s, int pTime) {
    Iterator<TypedSymbol> it = o.getParameters().iterator();
    boolean hayParams = !o.getParameters().isEmpty();
    StringBuilder r;
    if (hayParams) {
      r = new StringBuilder("(" + o.getName() + "_" + pTime + " ");
    } else {
      r = new StringBuilder(o.getName() + "_" + pTime + " ");
    }
    List<String> elemRepeated = new ArrayList<>();
    while (it.hasNext()) {
      TypedSymbol t = it.next();
      String nuevoNombre = t.getTypes().getFirst().getImage();
      int nVeces = Collections.frequency(elemRepeated, nuevoNombre);
      elemRepeated.add(nuevoNombre);
      if (nVeces != 0) {
        nuevoNombre = generateNewVar(nuevoNombre, nVeces, pTime);
      } else {
        nuevoNombre += "_" + pTime;
      }
      r.append(nuevoNombre).append(s).append(" ");
    }
    // for (TypedSymbol t : o.getParameters())
    //   r.append(t.getTypes().get(0).getImage()).append("_").append(pTime).append(s).append("
    //   ");
    if (hayParams)
      r.append(")");
    return r.toString();
  }

  private static String
  actionNoQuantComb(String prefix, Op o, String s, int pTime,
                    List<Pair<String, String>> pCombination,
                    Map<String, Object> pEquivalences,
                    Map<String, Object> pParams, ComparableExp pLiteral) {
      boolean isParams = !o.getParameters().isEmpty();
      StringBuilder actionStrWParameters;
      if (isParams)
        actionStrWParameters = new StringBuilder("(" + o.getName() + "_" + pTime + " ");
      else
        actionStrWParameters = new StringBuilder(o.getName() + "_" + pTime + " ");
      boolean hayParams = false;
      StringBuilder igualdades = new StringBuilder();
      for (TypedSymbol t : o.getParameters()) {
        if (pParams.containsKey(t.getImage()) && !pEquivalences.containsKey(t.getImage())) {
          hayParams = true;
          String valor = "";
          int contador = -1;
          List<Symbol> thelist = pLiteral.getAtom() == null ? pLiteral.getChildren().getFirst().getAtom() : pLiteral.getAtom();
          for (Symbol sy: thelist){
            if (sy.getImage().equals(t.getImage())){
              valor = pCombination.get(contador).getFirst();
              break;
            }
            contador++;
          }
//          for (Pair<String, String> con: pCombination){
//            if (t.getTypes().getFirst().getImage().equals(con.getSecond())){
//              valor = con.getFirst();
//              break;
//            }
//          }
          int count = 0;
          for (TypedSymbol t2 : o.getParameters()){
            if (t.getImage().equals(t2.getImage())) {
              break;
            } else if (t.getTypes().getFirst().equals(t2.getTypes().getFirst())){
              count++;
            }
          }
          Object elem = pEquivalences.get(valor);
          Integer numCom = ((Pair<?, Integer>) elem).getSecond();
          String nombreVar = generateVarType(t.getTypes().getFirst().getImage(), count, pTime);

          igualdades.append("\n")
              .append(prefix)
              .append("(= ")
              .append(nombreVar)
              .append(" ")
              .append(numCom)
              .append(")");
//          actionStrWParameters.append(numCom).append(" ");
          actionStrWParameters.append(nombreVar)
              .append(" ");
        } else {
          actionStrWParameters.append(t.getTypes().get(0).getImage())
                  .append("_")
                  .append(pTime)
                  .append(s)
                  .append(" ");
        }
      }
      if (isParams)
        actionStrWParameters.append(")");
      StringBuilder total = new StringBuilder("(and ");
      if (hayParams) {
        // Generar los and de igualdad de los parametros.
        total.append(actionStrWParameters).append(" ").append(igualdades);
        // total.setLength(total.length() - 1);
        total.append(")");
        return total.toString();
      } else
          return actionStrWParameters.toString();
  }

  private static boolean checkConstantsFrame(Op pAction, ComparableExp pLiteral, Map<String, Object> pEquivalences) {
    List<Symbol> s1 = pLiteral.getAtom();
//    try {
    Exp l;
    if(s1 == null){
      l = pLiteral.getChildren().getFirst();
    } else{
      l = pLiteral;
    }
      for (Symbol s : l.getAtom()) {
        if (pEquivalences.containsKey(s.getImage())) {
          return findInEffectsConstant(pAction.getEffects(), pLiteral);
        }
      }
      return false;
//    } catch (NullPointerException e) {
//      e.printStackTrace();
//    }
//    return false;
  }

  private static boolean findInEffectsConstant(Exp pEffect, ComparableExp pLiteral) {
    switch (pEffect.getConnective()) {
    case NOT, ATOM, FN_HEAD: {
      //Comparar si esta
      return pLiteral.equals(pEffect);
    }
    case ASSIGN:
    case INCREASE:
    case DECREASE:
      // En estos casos, el primer hijo es la función modificada
      // Recursivo
      return findInEffectsConstant(pEffect.getChildren().get(0), pLiteral);
    case WHEN:
      // Recursivo
      // Solo se consideran los efectos (hijo 1), no las condiciones
      return findInEffectsConstant(pEffect.getChildren().get(1), pLiteral);
    default:
      // Casos como AND, OR, etc.
      boolean found = false;
      for (Exp child :pEffect.getChildren()) {
        found = findInEffectsConstant(child, pLiteral);
        if (found)
          return true;
      }
    }
    // Change
    return false;
  }

  /// @pre \p args are values for parameters of \p o, in the same
  /// order as they occur in \p o.getParameters()

  /// @post Return the term corresponding to action \p o with
  /// concrete parameters \p args, with \p l added as last argument.
  private static String action(Op o, String l, List<String> args) {
    StringBuilder r = new StringBuilder("(" + o.getName() + " ");
    for (int i = 0; i < o.getParameters().size(); i++)
      r.append(args.get(i)).append(" ");
    r.append(l).append(")");
    return r.toString();
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

  /// @pre \p ls are the symbols of a predicate or a function atom.

  /// @post Outputs the term corresponding to \p ls with \p s added
  /// as last argument, preceded by \p prefix.
  private static void printFunctionNoQuant(String prefix, List<Symbol> ls,
                                           int pTime,
                                           Hashtable<String, Object> pParam,
                                           Map<String, Object> pEquivalences,
                                           boolean isTemporal, boolean pre) {
    //		System.out.print(prefix + '(');
    //		for (Symbol t : ls)
    //			System.out.print(t.getImage() + '_' + pTime + ' ');
    //		System.out.print(')');
    if (ls.size() != 1)
      System.out.print(prefix + '(');
    else
      System.out.print(prefix);
    for (Symbol t : ls)
      if (pParam.containsKey(t.getImage())) {
        Object elem = pParam.get(t.getImage());
        if (elem instanceof String)
          if (pre)
            System.out.print(elem.toString() + '_' + pTime + ' ');
          else
            System.out.print(elem.toString() + '_' + (pTime - 1) + ' ');
        else if (elem instanceof Pair<?, ?>) {
          // Se que no verifico si es esa instancia pero
          // no puede ser otra aunque para un buen
          // codigo deberia hacerlo.
          // System.out.print(((Pair<String, Integer>)
          // pParam.get(t.getImage())).getFirst() + '_'
          // + pTime + ' ');
          // System.out.print(
          //     ((Pair<String, Integer>)pParam.get(
          //          t.getImage()))
          //         .getSecond()
          //         .toString() +
          //     ' ');
          System.out.print(
              ((Pair<String, Integer>)elem).getSecond().toString() + ' ');
        } else
          System.out.println("ALGO NO FUNCIONA");
      } else if (pEquivalences.containsKey(t.getImage())) {
        Object elem = pEquivalences.get(t.getImage());
        if (elem instanceof Pair<?,?>) {
          System.out.print(((Pair<?,?>)elem).getSecond().toString() + ' ');
        } else
          System.out.println("ALGO NO FUNCIONA");
      } else if (isTemporal) {
        System.out.print(t.getImage() + '_' + pTime + ' ');
      } else
        System.out.print(t.getImage() + ' ');
    if (ls.size() != 1)
      System.out.print(')');
  }

  private static void
  printFunctionNoQuantFA(String prefix, List<Symbol> pPred,
                         List<Pair<String, String>> pCombinations, int pTime,
                         Map<String, Object> pEquivalences,
                         boolean isTemporal) {
    boolean isParam = pCombinations.getFirst().getFirst() != null;
    if(isParam)
      System.out.print(prefix + '(' + pPred.get(0).getImage() + '_' + pTime +
                     ' ');
    else
      System.out.print(prefix + pPred.get(0).getImage() + '_' + pTime + ' ');
    int j = 0;
    for (int i = 1; i < pPred.size(); i++) {
      Symbol t = pPred.get(i);
      Object elem = pEquivalences.get(t.getImage());
//      if (elem != null) {
//        Integer v = ((Pair<String, Integer>)elem).getSecond();
//        System.out.print(v.toString() + ' ');
//      } else {
        Object elem2 = pEquivalences.get(pCombinations.get(j++).getFirst());
        System.out.print(((Pair<String, Integer>)elem2).getSecond().toString() +
                         " ");
//      }
    }
    // for (Pair<String, String> parameter : pCombinations) {
    //   Object elem = pEquivalences.get(parameter.first);
    //                             if (elem instanceof Pair<?,?>)
    //                               System.out.print(((Pair<String,Integer>)elem)
    //                                                    .getSecond()
    //                                                    .toString() +
    //                                                ' ');
    //}
    if (isParam)
      System.out.print(')');
  }

  /// @pre \p ls are the arguments of a predicate or a function atom.

  /// @return The term corresponding to \p ls with \p s added as
  /// last argument.

  /// @remarks \p s can be empty
  private static String groundFunction(List<String> ls, String s) {
    String r = '(' + ls.get(0);
    for (String t : ls.subList(1, ls.size()))
      r = r + ' ' + t;
    r = r + (s.equals("") ? ')' : ' ' + s + ')');
    return r;
  }

  /// @post Outputs the parameters in \p l in SMT-LIB format, whith
  /// \p s added as a suffix of each name.
  private static void printArguments(List<TypedSymbol> l, String s) {
    System.out.print("(");
    for (TypedSymbol t : l) {
      System.out.print(" (" + t.getImage() + s + " " +
                       t.getTypes().get(0).getImage() + ")");
    }
    System.out.println(" )");
  }

  /// @post Outputs the parameters in \p lt in SMT-LIB format, only
  /// for those parameters such that the name in the same position
  /// of \p ln starts with '?', replacing their name with that
  /// name. The names of the parameters in \p lt are modified
  /// accordingly.
  private static void printArgumentsWithNames(List<TypedSymbol> lt,
                                              List<Symbol> ln) {
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
  private static void replaceArgumentsWithNames(List<TypedSymbol> lt,
                                                List<Symbol> ln) {
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
  private static void printExpression(String prefix, String t0, String t1,
                                      boolean pre, Exp e, Set<String> dtime,
                                      boolean newLine) throws Exception {
    String newPrefix = prefix + '\t';
    Connective connective = e.getConnective();
    List<Exp> lexp = e.getChildren();
    boolean increase = false;

    switch (connective) {
    case F_EXP:
      for (Exp f : lexp)
        printExpression(prefix, t0, t1, pre, f, dtime, newLine);
      break;
    case ATOM:
    case FN_HEAD:
      List<Symbol> ls = e.getAtom();
      String name = ls.get(0).getImage();
      if (dtime.contains(name))
        if (pre)
          printFunction(prefix, ls, t0);
        else
          printFunction(prefix, ls, t1);
      else
        System.out.print(prefix + e);
      break;
    case AND:
    case OR:
      System.out.println(prefix + "(" + connective.getImage());
      for (Exp f : lexp) {
        printExpression(newPrefix, t0, t1, pre, f, dtime, true);
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
        printExpression(" ", t0, t1, pre, f, dtime, false);
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
      printExpression(" ", t0, t1, false, lexp.get(0), dtime, false);
      printExpression(" ", t0, t1, true, lexp.get(1), dtime, false);
      System.out.print(')');
      break;
    case INCREASE:
      increase = true;
    case DECREASE:
      System.out.print(prefix + "(=");
      printExpression(" ", t0, t1, false, lexp.get(0), dtime, false);
      System.out.print(" (" + (increase ? '+' : '-'));
      printExpression(" ", t0, t1, true, lexp.get(0), dtime, false);
      printExpression(" ", t0, t1, true, lexp.get(1), dtime, false);
      System.out.print("))");
      break;
    case FORALL:
      System.out.print(prefix + "(forall ");
      printArguments(e.getVariables(), "");
      printExpression(newPrefix, t0, t1, pre, lexp.get(0), dtime, true);
      System.out.print(prefix + ')');
      break;
    case WHEN:
      System.out.println(prefix + "(=>");
      printExpression(newPrefix, t0, t1, true, lexp.get(0), dtime, true);
      printExpression(newPrefix, t0, t1, false, lexp.get(1), dtime, true);
      System.out.print(prefix + ')');
      break;
    case FN_ATOM:
      System.out.print(prefix + "(" + connective.getImage());
      for (Exp f : lexp)
        printExpression(" ", t0, t1, pre, f, dtime, false);
      System.out.print(')');
      break;
      //	case TRUE:
      //	case FALSE:
      //	case UMINUS:
      //	case EXISTS:
    default:
      throw new Exception("Connective " + e.getConnective() +
                          " in expression\n\n" + e + "\n\nnot supported.");
    }
    if (newLine)
      System.out.println();
  }

  private static Boolean evalStaticAtom(Exp e) {
    if (!useStaticPredicates || useStaticFrameOnly || staticPredicates.isEmpty()) {
      return null;
    }
    if (e.getConnective() != Connective.ATOM) {
      return null;
    }
    List<Symbol> atom = e.getAtom();
    if (atom == null || atom.isEmpty()) {
      return null;
    }
    String predicate = atom.get(0).getImage();
    if (!staticPredicates.contains(predicate)) {
      return null;
    }
    StringBuilder key = new StringBuilder(predicate);
    for (int i = 1; i < atom.size(); i++) {
      String arg = atom.get(i).getImage();
      if (arg.startsWith("?")) {
        return null;
      }
      key.append("_").append(arg);
    }
    return staticAtoms.contains(key.toString());
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
  private static void printExpressionNoQuant(String prefix, int t0, int t1,
                                             boolean pre, Exp e,
                                             Set<String> dtime, boolean newLine,
                                             Hashtable<String, Object> pParams,
                                             Map<String, Object> pEquivalences)
      throws Exception {
    String newPrefix = prefix + '\t';
    Connective connective = e.getConnective();
    List<Exp> lexp = e.getChildren();
    boolean increase = false;

    switch (connective) {
    case F_EXP:
      for (Exp f : lexp)
        printExpressionNoQuant(prefix, t0, t1, pre, f, dtime, newLine, pParams,
                               pEquivalences);
      break;
    case ATOM:
      {
        Boolean staticVal = evalStaticAtom(e);
        if (staticVal != null) {
          System.out.print(prefix + (staticVal ? "true" : "false"));
          break;
        }
      }
    case FN_HEAD:
      List<Symbol> ls = e.getAtom();
      String name = ls.get(0).getImage();
      if (dtime.contains(name))
        if (pre)
          printFunctionNoQuant(prefix, ls, t0, pParams, pEquivalences, true,
                               pre);
        else
          printFunctionNoQuant(prefix, ls, t1, pParams, pEquivalences, true,
                               pre);
      else
        // System.out.print(prefix + e);
        printFunctionNoQuant(prefix, ls, t0, pParams, pEquivalences, false,
                             pre);
      break;
    case AND:
    case OR:
      System.out.println(prefix + "(" + connective.getImage());
      for (Exp f : lexp) {
        printExpressionNoQuant(newPrefix, t0, t1, pre, f, dtime, true, pParams,
                               pEquivalences);
      }
      System.out.print(prefix + ')');
      break;
    case NOT:
      if (!lexp.isEmpty() && lexp.get(0).getConnective() == Connective.ATOM) {
        Boolean staticVal = evalStaticAtom(lexp.get(0));
        if (staticVal != null) {
          System.out.print(prefix + (staticVal ? "false" : "true"));
          break;
        }
      }
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
        printExpressionNoQuant(" ", t0, t1, pre, f, dtime, false, pParams,
                               pEquivalences);
      System.out.print(')');
      break;
    case NUMBER:
      System.out.print(prefix + e.getValue().intValue());
      break;
    case EQUAL_ATOM:
      List<Symbol> lp = e.getAtom();
      System.out.print(prefix + "(= " + pParams.get(lp.get(0).getImage()) +
                       "_" + t0 + " " + pParams.get(lp.get(1).getImage()) +
                       "_" + t0 + ")");
      break;
    case ASSIGN:
      System.out.print(prefix + "(=");
      printExpressionNoQuant(" ", t0, t1, false, lexp.get(0), dtime, false,
                             pParams, pEquivalences);
      printExpressionNoQuant(" ", t0, t1, true, lexp.get(1), dtime, false,
                             pParams, pEquivalences);
      System.out.print(')');
      break;
    case INCREASE:
      increase = true;
    case DECREASE:
      System.out.print(prefix + "(=");
      printExpressionNoQuant(" ", t0, t1, false, lexp.get(0), dtime, false,
                             pParams, pEquivalences);
      System.out.print(" (" + (increase ? '+' : '-'));
      printExpressionNoQuant(" ", t0, t1, true, lexp.get(0), dtime, false,
                             pParams, pEquivalences);
      printExpressionNoQuant(" ", t0, t1, true, lexp.get(1), dtime, false,
                             pParams, pEquivalences);
      System.out.print("))");
      break;
    case FORALL:
      System.out.print(prefix + "(forall ");
      printArguments(e.getVariables(), "");
      printExpressionNoQuant(newPrefix, t0, t1, pre, lexp.get(0), dtime, true,
                             pParams, pEquivalences);
      System.out.print(prefix + ')');
      break;
    case WHEN:
      System.out.println(prefix + "(=>");
      printExpressionNoQuant(newPrefix, t0, t1, true, lexp.get(0), dtime, true,
                             pParams, pEquivalences);
      printExpressionNoQuant(newPrefix, t0, t1, false, lexp.get(1), dtime, true,
                             pParams, pEquivalences);
      System.out.print(prefix + ')');
      break;
    case FN_ATOM:
      System.out.print(prefix + "(" + connective.getImage());
      for (Exp f : lexp)
        printExpressionNoQuant(" ", t0, t1, pre, f, dtime, false, pParams,
                               pEquivalences);
      System.out.print(')');
      break;
      //	case TRUE:
      //	case FALSE:
      //	case UMINUS:
      //	case EXISTS:
    default:
      throw new Exception("Connective " + e.getConnective() +
                          " in expression\n\n" + e + "\n\nnot supported.");
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
  private static void
  printExpressionUnfolded(String prefix, String t0, String t1, boolean pre,
                          Exp e, Set<String> dtime, boolean newLine,
                          List<String> names, List<String> values,
                          Map<String, List<String>> dtypes,
                          Map<String, Integer> constFunc) throws Exception {
    String newPrefix = prefix + '\t';
    Connective connective = e.getConnective();
    List<Exp> lexp = e.getChildren();
    boolean increase = false;

    switch (connective) {
    case F_EXP:
      for (Exp f : lexp)
        printExpressionUnfolded(prefix, t0, t1, pre, f, dtime, newLine, names,
                                values, dtypes, constFunc);
      break;
    case ATOM:
    case FN_HEAD:
      List<Symbol> ls = e.getAtom();
      List<String> lv = new ArrayList<>(ls.size()); // List of values
      String name = ls.get(0).getImage();
      lv.add(name);
      for (int i = 1; i < ls.size(); i++)
        lv.add(valueOf(ls.get(i).getImage(), names, values));
      if (dtime.contains(name))
        System.out.print(prefix + groundFunction(lv, pre ? t0 : t1));
      else {
        String function = groundFunction(lv, "");
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
        printExpressionUnfolded(newPrefix, t0, t1, pre, f, dtime, true, names,
                                values, dtypes, constFunc);
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
        printExpressionUnfolded(" ", t0, t1, pre, f, dtime, false, names,
                                values, dtypes, constFunc);
      System.out.print(')');
      break;
    case NUMBER:
      System.out.print(prefix + e.getValue().intValue());
      break;
    case EQUAL_ATOM:
      List<Symbol> lp = e.getAtom();
      System.out.print(
          prefix + "(= " + valueOf(lp.get(0).getImage(), names, values) + " " +
          valueOf(lp.get(1).getImage(), names, values) + ")");
      break;
    case ASSIGN:
      System.out.print(prefix + "(=");
      printExpressionUnfolded(" ", t0, t1, false, lexp.get(0), dtime, false,
                              names, values, dtypes, constFunc);
      printExpressionUnfolded(" ", t0, t1, true, lexp.get(1), dtime, false,
                              names, values, dtypes, constFunc);
      System.out.print(')');
      break;
    case INCREASE:
      increase = true;
    case DECREASE:
      System.out.print(prefix + "(=");
      printExpressionUnfolded(" ", t0, t1, false, lexp.get(0), dtime, false,
                              names, values, dtypes, constFunc);
      System.out.print(" (" + (increase ? '+' : '-'));
      printExpressionUnfolded(" ", t0, t1, true, lexp.get(0), dtime, false,
                              names, values, dtypes, constFunc);
      printExpressionUnfolded(" ", t0, t1, true, lexp.get(1), dtime, false,
                              names, values, dtypes, constFunc);
      System.out.print("))");
      break;
    case FORALL:
      for (TypedSymbol ts : e.getVariables())
        names.add(ts.getImage());
      List<List<String>> larg =
          split(combine(e.getVariables().iterator(),
                        dtypes)); // List of argument value combinations
      for (List<String> args : larg) {
        List<String> newValues = new ArrayList<>(values);
        newValues.addAll(args);
        printExpressionUnfolded(prefix, t0, t1, true, lexp.get(0), dtime, true,
                                names, newValues, dtypes, constFunc);
      }
      newLine = false;
      break;
    case WHEN:
      System.out.println(prefix + "(=>");
      printExpressionUnfolded(newPrefix, t0, t1, true, lexp.get(0), dtime, true,
                              names, values, dtypes, constFunc);
      printExpressionUnfolded(newPrefix, t0, t1, false, lexp.get(1), dtime,
                              true, names, values, dtypes, constFunc);
      System.out.print(prefix + ')');
      break;
    case FN_ATOM:
      System.out.print(prefix + "(" + connective.getImage());
      for (Exp f : lexp)
        printExpressionUnfolded(" ", t0, t1, pre, f, dtime, false, names,
                                values, dtypes, constFunc);
      System.out.print(')');
      break;
      //	case TRUE:
      //	case FALSE:
      //	case UMINUS:
      //	case EXISTS:
      //  case FORALL:
    default:
      throw new Exception("Connective " + e.getConnective() +
                          " in expression\n\n" + e + "\n\nnot supported.");
    }
    if (newLine)
      System.out.println();
  }

  /// @pre \p names and \p values have the same size.

  /// @post returns the value in \p values in the (first) position
  /// where \p name is found in \p names, if any, and \p name
  /// otherwise.
  private static String valueOf(String name, List<String> names,
                                List<String> values) {
    int j = names.indexOf(name);
    return (j != -1) ? values.get(j) : name;
  }

  /// @pre \p modifiedLits is a map where keys represent literals
  /// which are modified, and values are the list of operators that
  /// modify that literal.

  /// @post Outputs frame axioms for \p modifiedLits at time t1,
  /// according to the types declared in \p d. Each axiom is
  /// prefixed by \p prefix. Both time and objects are quantified.
  private static void
  printFrameAxioms(String prefix, Domain d,
                   Map<ComparableExp, List<Op>> modifiedLits) throws Exception {
    modifiedLits = merge(modifiedLits);
    List<NamedTypedList> lf = new LinkedList<>(d.getPredicates());
    lf.addAll(d.getFunctions());
    System.out.println(prefix + ";; Frame axioms");
    for (Map.Entry<ComparableExp, List<Op>> entry : modifiedLits.entrySet()) {
      List<Op> ops = entry.getValue();
      ComparableExp literal = entry.getKey();
      Connective con = literal.getConnective();
      boolean isNot = (con == Connective.NOT);
      Exp atom = isNot ? literal.getChildren().get(0) : literal;
      List<Symbol> latom = atom.getAtom();
      List<TypedSymbol> types = getTypes(lf, latom.get(0));
      boolean forAll = !types.isEmpty();
      if (forAll) {
        System.out.print(prefix + "(forall ");
        printArgumentsWithNames(types, latom.subList(1, latom.size()));
        System.out.print(prefix + "  (=> ");
      } else
        System.out.print(prefix + "(=> ");
      switch (con) {
      case ATOM:
        printFunction("", latom, "t1");
        break;
      case NOT:
        System.out.print("(not ");
        printFunction("", latom, "t1");
        System.out.print(")");
        break;
      case FN_HEAD:
        System.out.print("(not (=");
        printFunction(" ", latom, "t1");
        printFunction(" ", latom, "t0");
        System.out.print("))");
      }
      if (ops.size() > 0)
        System.out.println(" (or");
      else
        System.out.println(" ");
      String newPrefix = prefix + "      ";
      switch (con) {
      case ATOM:
        printFunction(newPrefix, latom, "t0");
        System.out.println();
        break;
      case NOT:
        System.out.print(newPrefix + "(not ");
        printFunction("", latom, "t0");
        System.out.println(")");
        break;
      case FN_HEAD:
      }
      for (Op o : ops) {
        List<TypedSymbol> missingTypes = getMissing(types, o.getParameters());
        if (!missingTypes.isEmpty()) {
          System.out.print(newPrefix + "(exists ");
          printArguments(missingTypes, "");
          System.out.print(newPrefix + "\t" + action(o, "t0", ""));
        } else
          System.out.print(newPrefix + action(o, "t0", ""));
        System.out.println();
        if (!missingTypes.isEmpty())
          System.out.println(newPrefix + ")");
      }
      if (ops.size() > 0)
        System.out.print(prefix + "))");
      else
        System.out.print(prefix + ")");
      if (forAll)
        System.out.print(')');
      System.out.println();
    }
  }

  /// @post Outputs frame axioms for \p modifiedLits at time t1,
  /// according to the types declared in \p d. Each axiom is
  /// prefixed by \p prefix. Both time and objects are quantified.
  private static Map<String, String>
  checkFrameAxiomsNoQuant(Domain d, Map<ComparableExp, List<Op>> modifiedLits,
                          int pTime, Map<String, Object> pEquivalences,
                          Map<String, List<String>> dtypes) throws Exception {
    Map<String, String> newVariables = new Hashtable<>();
    modifiedLits = merge(modifiedLits);
    List<NamedTypedList> lf = new LinkedList<>(d.getPredicates());
    lf.addAll(d.getFunctions());
    for (Map.Entry<ComparableExp, List<Op>> entry : modifiedLits.entrySet()) {
      ComparableExp literal = entry.getKey();
      Connective con = literal.getConnective();
      // Sacar las combinaciones de los parametros.
      Exp atom =
          (con == Connective.NOT) ? literal.getChildren().getFirst() : literal;
      List<Symbol> latom = atom.getAtom();
      List<TypedSymbol> types = getTypes2(lf, latom);
      Hashtable<String, Object> params = establishParameters(types);
      // Hashtable<String, Object> params = establishParameters(types);
      // List<List<String>> paramCombinations =
      // makeCombinatios(literal.getAtom(),dtypes, types);
      for (int i = 0; i < pTime; i++) {
        List<Op> operators = entry.getValue();
        List<TypedSymbol> repeatOperators = new ArrayList<>();
        Map<String, String> localNewVars = new Hashtable<>();
        for (int j = 0; j < operators.size(); j++) {
          List<TypedSymbol> missingTypes =
              getMissing(types, operators.get(j).getParameters());
          checkRepetedParams(repeatOperators, missingTypes, newVariables, i,
                             localNewVars);
        }
      }
    }
    return newVariables;
  }

  /*
  private static void checkRepetedParams(List<TypedSymbol> repeatOperators,
  List<TypedSymbol> missingTypes, Map<String, String> newVariables, int pTime,
  Map<String, String> localNewVariables) { for (TypedSymbol mm: missingTypes){
                  ListIterator<TypedSymbol> iterator =
  repeatOperators.listIterator(); boolean found = false;
                  // No hace falta el iterador pero así lo dejo porque estaba
  hecho otra cosa ya lo combiaré mas adelante. while (iterator.hasNext() &&
  !found){ TypedSymbol rr = iterator.next(); String typemm =
  mm.getTypes().getFirst().getImage(); if
  (rr.getTypes().getFirst().getImage().equals(typemm)) { found = true; String
  namenew = typemm + "_" + pTime + "_new"; boolean esta =
  localNewVariables.containsKey(namenew); while (esta) { namenew += "_new"; esta
  = newVariables.containsKey(namenew);
                                  }
                                  if (!newVariables.containsKey(namenew))
                                          newVariables.put(namenew, typemm);
                                  localNewVariables.put(namenew, typemm);
                          }
                  }
                  if (!found)
                                  repeatOperators.add(mm);
                  if (repeatOperators.isEmpty())
                          iterator.add(mm);
          }
  }*/

  private static void checkRepetedParams(
      List<TypedSymbol> repeatOperators, List<TypedSymbol> missingTypes,
      Map<String, String> newVariables, int pTime,
      Map<String, String>
          localNewVariables /*, Hashtable<String, Object> pParams*/) {
    for (TypedSymbol mm : missingTypes) {
      ListIterator<TypedSymbol> iterator = repeatOperators.listIterator();
      boolean found = false;
      // No hace falta el iterador pero así lo dejo porque estaba hecho otra
      // cosa ya lo combiaré mas adelante.
      // while (iterator.hasNext() && !found){
      // TypedSymbol rr = iterator.next();
      String typemm = mm.getTypes().getFirst().getImage();
      // if (rr.getTypes().getFirst().getImage().equals(typemm)) {
      found = true;
      String namenew = typemm + "_" + pTime + "_new";
      boolean esta = localNewVariables.containsKey(namenew);
      while (esta) {
        namenew += "_new";
        esta = newVariables.containsKey(namenew);
      }
      if (!newVariables.containsKey(namenew))
        newVariables.put(namenew, typemm);
      localNewVariables.put(namenew, typemm);
      //}
      //}
      if (!found)
        repeatOperators.add(mm);
      if (repeatOperators.isEmpty())
        iterator.add(mm);
    }
  }

  /// @post Outputs frame axioms for \p modifiedLits at time t1,
  /// according to the types declared in \p d. Each axiom is
  /// prefixed by \p prefix. Both time and objects are quantified.
  private static Map<String, String>
  checkFrameAxioms(Domain d, Map<ComparableExp, List<Op>> modifiedLits,
                   int pTime, Map<String, Object> pEquivalences,
                   Map<String, List<String>> dtypes) throws Exception {
    Map<String, String> everyVariable = new Hashtable<>();
    modifiedLits = merge(modifiedLits);
    List<NamedTypedList> lf = new LinkedList<>(d.getPredicates());
    lf.addAll(d.getFunctions());
    for (Map.Entry<ComparableExp, List<Op>> entry : modifiedLits.entrySet()) {
      Map<String, String> newVars = new Hashtable<>();
      ComparableExp literal = entry.getKey();
      Connective con = literal.getConnective();
      // Sacar las combinaciones de los parametros.
      Exp atom =
          (con == Connective.NOT) ? literal.getChildren().getFirst() : literal;
      List<Symbol> latom = atom.getAtom();
      List<TypedSymbol> types = getTypes2(lf, latom);
      Hashtable<String, Object> params = establishParameters(types);
      for (int i = 0; i < pTime; i++) {
        List<Op> operators = entry.getValue();
        List<TypedSymbol> varsUtilizadas = new ArrayList<>();
        // Map<String, String> newVars = new Hashtable<>();
        for (int j = 0; j < operators.size(); j++) {
          // for (Op o : entry.getValue()) {
          List<TypedSymbol> missingTypes =
              getMissing(types, operators.get(j).getParameters());
          if (!missingTypes.isEmpty())
            everyVariable = checkFrameIn(operators.get(j), "", pEquivalences,
                                         params, i, varsUtilizadas,
                                         missingTypes, newVars, everyVariable);
        }
      }
    }
    return everyVariable;
  }

  private static void printAtMostOneNoQuant(String prefix, Domain d,
                                            int pTime) {
    List<Op> lf = new LinkedList<>(d.getOperators());
    // lf.addAll(d.getOperators());
    System.out.println(prefix + ";; At most one");
    for (int t = 0; t < pTime; t++) {
      for (int j = 0; j < lf.size(); j++) {
        for (int k = j + 1; k < lf.size(); k++) {
          System.out.print(prefix + "(or ");
          System.out.println("(not " + actionNoQuant(lf.get(j), "", t) + ")");
          System.out.println(prefix + "    (not " +
                             actionNoQuant(lf.get(k), "", t) + ")");
          System.out.println(prefix + ") ");
        }
      }
    }
  }

  private static void printAtLeastOneNoQuant(String prefix, Domain d,
                                             int pTime) {
    List<Op> lf = new LinkedList<>(d.getOperators());
    // lf.addAll(d.getOperators());
    System.out.println();
    System.out.println(prefix + ";; At least one");
    for (int t = 0; t < pTime; t++) {
      System.out.println(prefix + "(or ");
      for (int j = 0; j < lf.size(); j++) {
        System.out.println(prefix + "\t\t " + actionNoQuant(lf.get(j), "", t));
      }
      System.out.println(prefix + ") ");
    }
  }

  /// @post Outputs frame axioms for \p modifiedLits at time t1,
  /// according to the types declared in \p d. Each axiom is
  /// prefixed by \p prefix. Both time and objects are quantified.
  private static void printFrameAxiomsNoQuant(
      String prefix, Domain d,
      Map<String, Map<ComparableExp, List<Op>>> modifiedLits, int pTime,
      Map<String, Object> pEquivalences, Map<String, List<String>> dtypes)
      throws Exception {
    List<NamedTypedList> lf = new LinkedList<>(d.getPredicates());
    lf.addAll(d.getFunctions());
    System.out.println(prefix + ";; Frame axioms");
    for (Map.Entry<String, Map<ComparableExp, List<Op>>> firstEntry :
         modifiedLits.entrySet()) {
      if (firstEntry.getValue().isEmpty())
        continue;
      Map<ComparableExp, List<Op>> innerMap = firstEntry.getValue();
      ComparableExp literal = null;
//      if (innerMap.keySet().iterator().hasNext()) {
//        literal = innerMap.keySet().iterator().next();
//        if (innerMap.get(literal) == null || innerMap.get(literal).isEmpty()) {
//          continue;
//        }
//      } else {
//        continue;
//      }
      Map<ComparableExp, List<Op>> lconst = new TreeMap<>(innerMap);
      Map<ComparableExp, List<Op>> newVarsPrueba = new TreeMap<>(innerMap);
      Iterator<ComparableExp> itInner = innerMap.keySet().iterator();
      while (itInner.hasNext()) {
        literal = itInner.next();
        // O no tiene parametros, o no tiene constantes
        if(innerMap.get(literal) == null || innerMap.get(literal).isEmpty()){
          lconst.remove(literal);
          newVarsPrueba.remove(literal);
        } else if ((literal.getAtom() == null && literal.getChildren().getFirst().getAtom().size() < 2) || !checkIfConstant(literal, pEquivalences)) {
          lconst.remove(literal);
        } else {
          newVarsPrueba.remove(literal);
        }
      }
      if (!newVarsPrueba.isEmpty()) {
        literal = newVarsPrueba.keySet().iterator().next();
        // ComparableExp literal = entry.getKey();
        Connective con = literal.getConnective();
        // Sacar las combinaciones de los parametros.
        Exp atom =
            (con == Connective.NOT) ? literal.getChildren().getFirst() : literal;
        List<Symbol> latom = atom.getAtom();
        List<TypedSymbol> types = getTypes2(lf, latom);
        Hashtable<String, Object> params;
        List<List<Pair<String, String>>> paramCombinations =
            makeCombinatios(literal.getAtom(), dtypes, types, pEquivalences);
        for (List<Pair<String, String>> combination : paramCombinations) {
          // Verifica si el literal es con un not delante para devolver el atom en
          // vez del literal. No es necesario solo se utiliza aqui
          for (int i = 0; i < pTime; i++) {
            boolean entra = false; // Patch bug "))"
            boolean firstPart =
                false; // Si se ha puesto la primera parte del predicado.
            // AQUI CONSTANSTS CAMBIAR FRAME AXIOMS!!!!
            for (Map.Entry<ComparableExp, List<Op>> entry : newVarsPrueba.entrySet()) {
              //              entra = false;
              if (entry.getValue().isEmpty()) {
                continue;
              }
              String newPrefix = prefix + "      ";
              if (!firstPart) {
                literal = entry.getKey();
                con = literal.getConnective();
                // Sacar las combinaciones de los parametros.
                atom = (con == Connective.NOT) ? literal.getChildren().getFirst()
                    : literal;
                latom = atom.getAtom();
                types = getTypes2(lf, latom);
                params = establishParameters(types);
                firstPart = true;
                //firstPart = true;
                System.out.print(prefix + " (=> ");
                switch (con) {
                  case ATOM:
                    printFunctionNoQuantFA("", latom, combination, i + 1,
                        pEquivalences, true);
                    //							printFunctionNoQuant("",
                    // latom, i + 1, params, true);
                    break;
                  case NOT:
                    System.out.print("(not ");
                    printFunctionNoQuantFA("", latom, combination, i + 1,
                        pEquivalences, true);
                    //							printFunctionNoQuant("",
                    // latom, i + 1, params, true);
                    System.out.print(")");
                    break;
                  case FN_HEAD:
                    System.out.print("(not (=");
                    printFunctionNoQuantFA(" ", latom, combination, i + 1,
                        pEquivalences, true);
                    //							printFunctionNoQuant("
                    //", latom, i + 1, params, true);
                    printFunctionNoQuantFA(" ", latom, combination, i,
                        pEquivalences, true);
                    //							printFunctionNoQuant("
                    //", latom, i, params, true);
                    System.out.print("))");
                }
                System.out.println(" (or");
                //                entra = true;
                newPrefix = prefix + "      ";
                switch (con) {
                  case ATOM:
                    printFunctionNoQuantFA(newPrefix, latom, combination, i,
                        pEquivalences, true);
                    //							printFunctionNoQuant(newPrefix,
                    // latom, i, params, true);
                    System.out.println();
                    break;
                  case NOT:
                    System.out.print(newPrefix + "(not ");
                    printFunctionNoQuantFA("", latom, combination, i, pEquivalences,
                        true);
                    //							printFunctionNoQuant("",
                    // latom, i, params, true);
                    System.out.println(")");
                    break;
                  case FN_HEAD:
                }
              } else {
//                literal = new ComparableExp(entry.getKey());
                literal = entry.getKey();
                con = literal.getConnective();
                // Sacar las combinaciones de los parametros.
                atom = (con == Connective.NOT) ? literal.getChildren().getFirst()
                    : literal;
                latom = atom.getAtom();
//                LinkedList lff = deepCopyComparable(lf);
                types = getTypes2(lf, latom);
                params = establishParameters(types);
              }
              List<Op> operators = entry.getValue();
              List<TypedSymbol> varsUtilizadas = new ArrayList<>();
              Map<String, String> newVars = new Hashtable<>();
              for (int j = 0; j < operators.size(); j++) {
                // for (Op o : entry.getValue()) {
                List<TypedSymbol> missingTypes =
                    getMissing(types, operators.get(j).getParameters());
                if (!missingTypes.isEmpty()) {
                  entra = true;
                  // ESTO PARECE QUE ESTA BIEN.
                  // No hace falta el exists
                  // System.out.print(newPrefix + "(exists ");
                  // En consecuencia tampoco los argumentos
                  // printArguments(missingTypes, "");
                  System.out.print(
                      newPrefix + "\t" +
                          actionNoQuantFrame(newPrefix, operators.get(j), "",
                              combination, pEquivalences, params, i,
                              varsUtilizadas, missingTypes, newVars, literal));
                } else {
                  entra = true;
                  System.out.print(
                      newPrefix +
                          actionNoQuantComb(newPrefix, entry.getValue().get(j), "", i,
                              combination, pEquivalences, params, literal));
                }
                System.out.println();
                // if (!missingTypes.isEmpty())
                // System.out.println(newPrefix + ")");
                // if (!missingTypes.isEmpty() && j == operators.size() - 1)
                //	System.out.println(newPrefix + ")");
              }
            }
            if (entra) { // Patch bug "))"
              System.out.print(prefix + " ))");
              // System.out.print(prefix + ")");
              System.out.println();
            }
          }
        }
      } else if (!lconst.isEmpty()){
        for (Map.Entry<ComparableExp, List<Op>> entry : lconst.entrySet()) {
          if (entry.getValue().isEmpty()) {
            continue;
          }
          ComparableExp llliteral = entry.getKey();
          Connective con = llliteral.getConnective();
          // Sacar las combinaciones de los parametros.
          Exp atom =
              (con == Connective.NOT) ? llliteral.getChildren().getFirst() : llliteral;
          List<Symbol> latom = atom.getAtom();
          List<TypedSymbol> types = getTypes2(lf, latom);
          Hashtable<String, Object> params;
          params = establishParameters(types);
          List<List<Pair<String, String>>> paramCombinations =
              makeCombinatios(literal.getAtom(), dtypes, types, pEquivalences);
          for (List<Pair<String, String>> combination : paramCombinations) {
            // Verifica si el literal es con un not delante para devolver el atom en
            // vez del literal. No es necesario solo se utiliza aqui
            for (int i = 0; i < pTime; i++) {
              boolean entra = false;
              String newPrefix = prefix + "      ";
              System.out.print(prefix + " (=> ");
              switch (con) {
                case ATOM:
                  printFunctionNoQuantFA("", latom, combination, i + 1,
                      pEquivalences, true);
                  //							printFunctionNoQuant("",
                  // latom, i + 1, params, true);
                  break;
                case NOT:
                  System.out.print("(not ");
                  printFunctionNoQuantFA("", latom, combination, i + 1,
                      pEquivalences, true);
                  //							printFunctionNoQuant("",
                  // latom, i + 1, params, true);
                  System.out.print(")");
                  break;
                case FN_HEAD:
                  System.out.print("(not (=");
                  printFunctionNoQuantFA(" ", latom, combination, i + 1,
                      pEquivalences, true);
                  //							printFunctionNoQuant("
                  //", latom, i + 1, params, true);
                  printFunctionNoQuantFA(" ", latom, combination, i,
                      pEquivalences, true);
                  //							printFunctionNoQuant("
                  //", latom, i, params, true);
                  System.out.print("))");
              }
              System.out.println(" (or");
              //                entra = true;
              newPrefix = prefix + "      ";
              switch (con) {
                case ATOM:
                  printFunctionNoQuantFA(newPrefix, latom, combination, i,
                      pEquivalences, true);
                  //							printFunctionNoQuant(newPrefix,
                  // latom, i, params, true);
                  System.out.println();
                  break;
                case NOT:
                  System.out.print(newPrefix + "(not ");
                  printFunctionNoQuantFA("", latom, combination, i, pEquivalences,
                      true);
                  //							printFunctionNoQuant("",
                  // latom, i, params, true);
                  System.out.println(")");
                  break;
                case FN_HEAD:
              }
              List<Op> operators = entry.getValue();
              List<TypedSymbol> varsUtilizadas = new ArrayList<>();
              Map<String, String> newVars = new Hashtable<>();
              for (int j = 0; j < operators.size(); j++) {
                // for (Op o : entry.getValue()) {
                List<TypedSymbol> missingTypes =
                    getMissing(types, operators.get(j).getParameters());
                if (!missingTypes.isEmpty()) {
                  entra = true;
                  // ESTO PARECE QUE ESTA BIEN.
                  // No hace falta el exists
                  // System.out.print(newPrefix + "(exists ");
                  // En consecuencia tampoco los argumentos
                  // printArguments(missingTypes, "");
                  System.out.print(
                      newPrefix + "\t" +
                          actionNoQuantFrame(newPrefix, operators.get(j), "",
                              combination, pEquivalences, params, i,
                              varsUtilizadas, missingTypes, newVars, literal));
                } else {
                  entra = true;
                  System.out.print(
                      newPrefix +
                          actionNoQuantComb(newPrefix, entry.getValue().get(j), "", i,
                              combination, pEquivalences, params, literal));
                }
                System.out.println();
              }
              System.out.print(prefix + " ))");
              System.out.println();
            }
          }
        }
      }
    }
  }

  private static LinkedList deepCopyComparable(List<NamedTypedList> lf) {
    LinkedList<NamedTypedList> lff = new LinkedList<>();
    for(NamedTypedList ntl: lf){
      NamedTypedList nnn = new NamedTypedList(ntl);
      lff.add(nnn);
    }
    return lff;
  }

  private static boolean checkIfConstant(ComparableExp pLiteral, Map<String, Object> pEquivalences) {
    List<Symbol> s1 = pLiteral.getAtom();
//    try {
    Exp l;
    if(s1 == null){
      l = pLiteral.getChildren().getFirst();
    } else{
      l = pLiteral;
    }
    for(Symbol s: l.getAtom()) {
      if (pEquivalences.get(s.getImage()) != null) {
        return true;
      }
    }
    return false;
  }

  //	private static String actionNoQuantFrame(Op o, String s, List<String>
  // pCombination,
  // Map<String, Object> pEquivalences, Map<String, Object> pParams, int pTime,
  // List<TypedSymbol> varsUtilizadas, List<TypedSymbol> missingTypes,
  // Map<String, String> localNewVars) { 		StringBuilder r = new
  // StringBuilder("(" + o.getName() + "_" + pTime + " "); 		int
  // count = 0; 		for (TypedSymbol t : o.getParameters()) {
  // if (pParams.containsKey(t.getImage())){ 				String
  // valor = pCombination.get(count); 				count++;
  // Object elem = pEquivalences.get(valor);
  // r.append(((Pair<?, ?>) elem).getSecond()).append("
  // "); 			} else { 				boolean
  // foundone = false; 				for (TypedSymbol mt:
  // missingTypes) { 					if (mt.equals(t)) {
  // foundone = true;
  // ListIterator<TypedSymbol> it =
  // varsUtilizadas.listIterator();
  // boolean found = false; 						while
  // (it.hasNext() &&
  //! found) { 							TypedSymbol vu =
  //! it.next(); 							String
  //! typemm =
  // mt.getTypes().getFirst().getImage();
  // if (vu.getTypes().getFirst().getImage().equals(typemm)) {
  // found = true; String namenew = typemm + "_" + pTime + "_new";
  // boolean esta = localNewVars.containsKey(namenew);
  // while (esta) {
  // namenew += "_new";
  // esta = localNewVars.containsKey(namenew);
  //								}
  //								r.append(namenew).append("
  //");
  // localNewVars.put(namenew, typemm);
  //							}
  //						}
  //						if (!found) {
  //							varsUtilizadas.add(mt);
  //							r.append(t.getTypes().get(0).getImage()).append("_").append(pTime).append(s).append("
  //");
  //						}
  //						break;
  //					}
  //				}
  //				if (!foundone)
  //					r.append(t.getTypes().get(0).getImage()).append("_").append(pTime).append(s).append("
  //");
  //			}
  //		}
  //		r.append(")");
  //		return r.toString();
  //	}
  private static String actionNoQuantFrame(
      String prefix, Op o, String s, List<Pair<String, String>> pCombination,
      Map<String, Object> pEquivalences, Map<String, Object> pParams, int pTime,
      List<TypedSymbol> varsUtilizadas, List<TypedSymbol> missingTypes,
      Map<String, String> localNewVars, ComparableExp pLiteral) {
    StringBuilder actionStrWParameters =
        new StringBuilder("(" + o.getName() + "_" + pTime + " ");
    int count = 0;
    boolean hayParams = false;
    StringBuilder igualdades = new StringBuilder();
    // Codigo para el cambio de frame axioms libres.
    List<String> tiposRepetidos = new ArrayList<>();
    for (TypedSymbol t : o.getParameters()) {
      if (pParams.containsKey(t.getImage())) {
        hayParams = true;
        // count = getPositionFrameActionGrounding(pCombination, t);
        // String valor = pCombination.get(count).first;
        //String valor = getPositionFrameActionGrounding(pCombination, t);
        String valor = "";
          int contador = -1;
          List<Symbol> thelist = pLiteral.getAtom() == null ? pLiteral.getChildren().getFirst().getAtom() : pLiteral.getAtom();
          for (Symbol sy: thelist){
            if (sy.getImage().equals(t.getImage())){
              valor = pCombination.get(contador).getFirst();
              break;
            }
            contador++;
          }
        // count++;
        Object elem = pEquivalences.get(valor);
        Integer numCom = ((Pair<?, Integer>)elem).getSecond();
        String nuevoNombre = ((Pair<String, ?>)elem).getFirst();
        // igualdades.append("\n").append(prefix).append("(=
        // ").append(nombreVar).append("_").append(pTime).append("
        // ").append(numCom).append(")");
        int nVeces = Collections.frequency(tiposRepetidos, nuevoNombre);
        tiposRepetidos.add(nuevoNombre);
        if (nVeces != 0) {
          nuevoNombre = generateNewVar(nuevoNombre, nVeces, pTime);
        } else {
          nuevoNombre += "_" + pTime;
        }
        igualdades.append("\n")
            .append(prefix)
            .append("(= ")
            .append(nuevoNombre)
            .append(" ")
            .append(numCom)
            .append(")");
        actionStrWParameters.append(nuevoNombre).append(" ");
//        actionStrWParameters.append(numCom).append(" ");
      } else {
        String nuevoNombre = t.getTypes().getFirst().getImage();
        int nveces = Collections.frequency(tiposRepetidos, nuevoNombre);
        tiposRepetidos.add(nuevoNombre);
        if (nveces != 0) {
          nuevoNombre = generateNewVar(nuevoNombre, nveces, pTime);
        } else {
          nuevoNombre += "_" + pTime;
        }
        actionStrWParameters.append(nuevoNombre).append(" ");
      }
    }
    actionStrWParameters.append(")");
    StringBuilder total = new StringBuilder("(and ");
    if (hayParams) {
      // Generar los and de igualdad de los parametros.
      total.append(actionStrWParameters).append(" ").append(igualdades);
      // total.setLength(total.length() - 1);
      total.append(")");
      return total.toString();
    } else
        return actionStrWParameters.toString();
  }

  private static String
  getPositionFrameActionGrounding(List<Pair<String, String>> pCombination,
                                  TypedSymbol t) {
    for (int i = 0; i < pCombination.size(); i++) {
      if (t.getTypes().getFirst().getImage().equals(
              pCombination.get(i).second)) {
        return pCombination.get(i).first;
      }
    }
    return null;
  }

  private static Map<String, String>
  checkFrameIn(Op o, String s, Map<String, Object> pEquivalences,
               Map<String, Object> pParams, int pTime,
               List<TypedSymbol> varsUtilizadas, List<TypedSymbol> missingTypes,
               Map<String, String> localNewVars,
               Map<String, String> generalVars) {
    for (TypedSymbol t : o.getParameters()) {
      if (!pParams.containsKey(t.getImage())) {
        Iterator<TypedSymbol> it = missingTypes.iterator();
        boolean salir = false;
        while (it.hasNext() && !salir) {
          TypedSymbol mt = it.next();
          if (mt.equals(t)) {
            String typemm = mt.getTypes().getFirst().getImage();
            String namenew = typemm + "_" + pTime + "_new";
            boolean esta = localNewVars.containsKey(namenew);
            while (esta) {
              namenew += "_new";
              esta = localNewVars.containsKey(namenew);
            }
            localNewVars.put(namenew, typemm);
            generalVars.put(namenew, typemm);
            salir = true;
          }
        }
      }
    }
    return generalVars;
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
  private static int
  printFrameAxiomsUnfolded(String prefix, Domain d,
                           Map<ComparableExp, List<Op>> modifiedLits,
                           Map<String, List<String>> dtypes, boolean atmostone,
                           int i) throws Exception {
    ArrayList<String> actions = new ArrayList<>();
    modifiedLits = merge(modifiedLits);
    List<NamedTypedList> lf = new LinkedList<>(d.getPredicates());
    lf.addAll(d.getFunctions());
    System.out.println(prefix + ";; Frame axioms");
    for (Map.Entry<ComparableExp, List<Op>> entry : modifiedLits.entrySet()) {
      List<Op> ops = entry.getValue();
      ComparableExp literal = entry.getKey();
      Connective con = literal.getConnective();
      boolean isNot = (con == Connective.NOT);
      Exp atom = isNot ? literal.getChildren().get(0) : literal;
      List<Symbol> latom = atom.getAtom();
      String name = latom.get(0).getImage();
      List<TypedSymbol> types = getTypes(lf, latom.get(0));
      replaceArgumentsWithNames(types, latom.subList(1, latom.size()));
      List<List<String>> larg = split(combine(
          types.iterator(), dtypes)); // List of argument value combinations
      List<String> argn = new ArrayList<>(types.size()); // Names of parameters
      List<String> gfun = new ArrayList<>(
          types.size() + 1); // Function name + values of parameters
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
          System.out.print(groundFunction(gfun, "t1"));
          break;
        case NOT:
          System.out.print("(not ");
          System.out.print(groundFunction(gfun, "t1"));
          System.out.print(")");
          break;
        case FN_HEAD:
          System.out.print("(not (=");
          System.out.print(" " + groundFunction(gfun, "t1"));
          System.out.print(" " + groundFunction(gfun, "t0"));
          System.out.print("))");
        }
        if (ops.size() > 0)
          System.out.println(" (or");
        else
          System.out.println(" ");
        String newPrefix = prefix + "      ";
        switch (con) {
        case ATOM:
          System.out.print(newPrefix + groundFunction(gfun, "t0"));
          System.out.println();
          break;
        case NOT:
          System.out.print(newPrefix + "(not ");
          System.out.print(groundFunction(gfun, "t0"));
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
          List<TypedSymbol> missingTypes = getMissing(types, param);
          List<TypedSymbol> sortedTypes = new LinkedList<>(param);
          sortedTypes.removeAll(missingTypes);
          // Reorder parameters of gfun according to sortedTypes, taking as
          // original order that of types.
          List<String> gfunOrdered = new ArrayList<String>(gfun);
          int pos1 = 1;
          for (TypedSymbol ts : types) {
            int pos2 = sortedTypes.indexOf(ts) + 1;
            gfunOrdered.set(pos2, gfun.get(pos1));
            pos1++;
          }
          gfun = gfunOrdered;
          if (!missingTypes.isEmpty()) {
            List<List<String>> missingValues =
                split(combine(missingTypes.iterator(), dtypes));
            List<List<String>> actualParameters =
                combineInto(param, sortedTypes, gfun.subList(1, gfun.size()),
                            missingTypes, missingValues);
            for (List<String> ls : actualParameters) {
              String a = action(o, "t0", ls);
              actions.add(a);
              System.out.print(newPrefix + a);
              System.out.println();
            }
          } else {
            String a = action(o, "t0", gfun.subList(1, gfun.size()));
            actions.add(a);
            System.out.print(newPrefix + a);
            System.out.println();
          }
        }
        if (atmostone) {
          System.out.println(newPrefix + ")");
          i = printAtMostOne(newPrefix, actions, i);
          System.out.println(newPrefix + ")");
        }
        if (ops.size() > 0)
          System.out.println(prefix + "))");
        else
          System.out.println(prefix + ")");
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
        lw.addAll(Arrays.asList(values));
        r.add(lw);
      } else
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
    List<Integer> which = where(types, misTypes, param);
    for (List<String> mvs : misValues) {
      List<String> ls = new ArrayList<>(mvs.size());
      Iterator<String> it1 = values.iterator();
      Iterator<String> it2 = mvs.iterator();
      for (int i : which)
        ls.add((i == 1) ? it1.next() : it2.next());
      l.add(ls);
    }
    return l;
  }

  /// @pre The elements of \p types and \p misTypes are included in
  /// \p param and are disjoint.

  /// @post A list of the form [i_1, i_2, ... , i_n] where n = \p
  /// param.size() and i_j = 1 iff \p param.get(j) occurs in \p
  /// types.
  private static List<Integer> where(List<TypedSymbol> types,
                                     List<TypedSymbol> misTypes,
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

  private static List<TypedSymbol> getTypes2(List<NamedTypedList> lf,
                                             List<Symbol> symbols) {
    List<TypedSymbol> lt = null;
    for (NamedTypedList m : lf)
      if (m.getName().equals(symbols.getFirst())) {
        lt = m.getArguments();
        int i = 0;
        for (TypedSymbol ts : lt) {
          ts.setImage(symbols.get(i + 1).getImage());
          i++;
        }
        break;
      }
    return lt;
  }

  /// @return A list with the types in \p l2 which do not occur in \p l1.
  private static List<TypedSymbol> getMissing(List<TypedSymbol> l1,
                                              List<TypedSymbol> l2) {
    List<TypedSymbol> l = new ArrayList<>(l2);
    l.removeAll(l1);
    return l;
  }

  /// @post Outputs the definition of a function which represents
  /// the initial state as described in \p d and \p p, by adding a
  /// parameter 0 to all predicates and functions whose name is in
  /// \p dtime.

  /// @remarks We adhere to the closed world assumption for
  /// predicates, but undefined values for numeric functions are not
  /// supported.  Instances for the closed world assumption are
  /// generated according to \p dtypes, where the key is a data type
  /// and the value the list of values of that data type.

  /// @exception Exception Some expression in \p p.getInit()
  /// contains an unsupported connective.
  private static void
  printInitialState(Domain d, Problem p, Map<String, List<String>> dtypes,
                    Set<String> dtime,
                    Hashtable<String, Object> equivalences) throws Exception {
    Set<String> s = new HashSet<>();
    System.out.println("\n;; Initial state");
    System.out.println("(define-fun init () Bool (and");
    for (Exp e : p.getInit()) {
      if (e.getConnective() == Connective.ATOM) {
        String t = e.toString();
        String[] guardar = t.substring(1, t.length() - 1).split(" ");
        StringBuilder guardFinal = new StringBuilder();
        for (int i = 0; i < guardar.length; i++) {
          Object elem = equivalences.get(guardar[i]);
          if (elem instanceof Pair<?,?>)
            guardFinal.append(((Pair<?,?>) elem).getSecond());
          else if (dtime.contains(guardar[i])) {
            guardFinal.append(guardar[i]).append("_0");
          } else {
            guardFinal.append(guardar[i]);
          }
          if (i != guardar.length - 1)
            guardFinal.append(" ");
        }
        s.add(guardFinal.toString());
      }
      printExpressionNoQuant("\t", 0, 0, true, e, dtime, true, equivalences,
                             equivalences);
    }
    printClosedWorldNoQuant("\t", s, d, dtypes, dtime, equivalences);
    System.out.println("))");
  }

  /// @pre All names of predicates and functions occurring in \p
  /// p.getGoal() are in \p dtime.

  /// @post Outputs the definition of a function which represents
  /// the goal as described in \p p.

  /// @exception Exception \p p.getGoal() contains some unsupported
  /// connective.
  private static void printGoal(Problem p, Set<String> dtime, int pTime,
                                Hashtable<String, Object> equivalences)
      throws Exception {
    System.out.println("\n;; Goal");
    Exp e = p.getGoal();
    if (pTime < 0) {
      System.out.print("(define-fun goal ((_t _time)) Bool ");
      printExpression("", "_t", "", true, e, dtime, false);
    } else {
      System.out.print("(define-fun goal () Bool ");
      printExpressionNoQuant("", pTime, -1, true, e, dtime, false, equivalences,
                             equivalences);
    }
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
                                       Set<String> assertedPredicates, Domain d,
                                       Map<String, List<String>> dtypes,
                                       Set<String> dtime) {
    System.out.println(prefix + ";; Closed world");
    for (NamedTypedList p : d.getPredicates()) {
      String name = p.getName().getImage();
      boolean print0 = dtime.contains(name);
      Iterator<TypedSymbol> it = p.getArguments().iterator();
      Iterable<String> combinations = combine(it, dtypes);
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

  /// @post Outputs (not (name p1 p2 ... pn)), prefixed by \p
  /// prefix, for every instance of every predicate declared in \p d
  /// such that "name p1 p2 ... pn" is not in \p assertedPredicates.
  /// A last parameter 0 is added for all predicates whose name is
  /// in \p dtime. Instances are generated according to \p dtypes,
  /// where the key is a data type and the value the list of values
  /// of that data type.
  private static void
  printClosedWorldNoQuant(String prefix, Set<String> assertedPredicates,
                          Domain d, Map<String, List<String>> dtypes,
                          Set<String> dtime,
                          Hashtable<String, Object> equivalences) {
    System.out.println(prefix + ";; Closed world");
    for (NamedTypedList p : d.getPredicates()) {
      String name = p.getName().getImage();
      if (!p.getArguments().isEmpty()) {
        Iterator<TypedSymbol> it = p.getArguments().iterator();
        Iterable<String> combinations = combine(it, dtypes);
        for (String s : combinations) {
          String[] elements = s.split(" ");
          StringBuilder ss = new StringBuilder("");
          for (int i = 1; i < elements.length; i++) {
            ss.append(((Pair<?, ?>) equivalences.get(elements[i])).getSecond());
            if (i != elements.length - 1)
              ss.append(" ");
          }
          String t;
          if (dtime.contains(name)) {
            t = name + "_0 " + ss.toString();
          } else {
            t = name + " " + ss.toString();
          }
          //          if (p.getArguments().isEmpty()) {
          //            if (assertedPredicates.contains(t)) {
          //              System.out.print(prefix + "(not " + t);
          //              System.out.println(")");
          //            }
          //          } else {
          if (!assertedPredicates.contains(t)) {
            System.out.print(prefix + "(not (" + t);
            System.out.println("))");
          }
          //          }
        }
      } else {
        String t;
        if (dtime.contains(name)) {
          t = name + "_0";
        } else {
          t = name;
        }
        if (!assertedPredicates.contains(t)) {
          System.out.print(prefix + "(not " + t);
          System.out.println(")");
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
                                          Map<String, List<String>> dtypes) {
    List<String> l = new LinkedList<>();
    if (!it.hasNext())
      l.add("");
    else {
      TypedSymbol t = it.next();
      Iterable<String> combinations = combine(it, dtypes);
      for (String value : dtypes.get(t.getTypes().get(0).getImage()))
        for (String combination : combinations)
          l.add(" " + value + combination);
    }
    return l;
  }

  private static List<List<Pair<String, String>>>
  makeCombinatios(List<Symbol> pGaps, Map<String, List<String>> dtypes,
                  List<TypedSymbol> paramTypes,
                  Map<String, Object> pEquivalences) {
    List<List<Pair<String, String>>> result = new ArrayList<>();
    for (TypedSymbol pt : paramTypes) {
      if (!pEquivalences.containsKey(pt.getImage())) {
        List<String> valores = dtypes.get(pt.getTypes().getFirst().getImage());
        List<Pair<String, String>> pares = new ArrayList<>();
        for (String s : valores) {
          Pair<String, String> p =
              new Pair<>(s, pt.getTypes().getFirst().getImage());
          pares.add(p);
        }
        // result.add(dtypes.get(pt.getTypes().getFirst().getImage()));
        result.add(pares);
      } else {
        List<Pair<String, String>> pares = new ArrayList<>();
        Pair<String, String> p = new Pair<>(pt.getImage(), pt.getTypes().getFirst().getImage());
        pares.add(p);
        result.add(pares);
      }
    }
    List<List<Pair<String, String>>> r = cartesianProduct(result);
    if (r.isEmpty()) {
        List<Pair<String, String>> emptyCombination = new ArrayList<>();
        emptyCombination.add(new Pair<>(null, null));
        r = new ArrayList<>();
        r.add(emptyCombination);
    }
    return r;
  }

  private static List<List<Pair<String, String>>>
  cartesianProduct(List<List<Pair<String, String>>> lists) {
    List<List<Pair<String, String>>> result = new ArrayList<>();
    if (lists == null || lists.isEmpty()) {
      return result;
    }
    cartesianProductHelper(lists, result, 0, new ArrayList<>());
    return result;
  }

  private static void
  cartesianProductHelper(List<List<Pair<String, String>>> lists,
                         List<List<Pair<String, String>>> result, int depth,
                         List<Pair<String, String>> current) {
    if (depth == lists.size()) {
      result.add(new ArrayList<>(current));
      return;
    }

    for (Pair<String, String> element : lists.get(depth)) {
      current.add(element);
      cartesianProductHelper(lists, result, depth + 1, current);
      current.remove(current.size() - 1);
    }
  }

  /// @pre \p dtypes is a map where key = type and value = list of
  /// objects of that type.

  /// @return An ArrayList containing all ground actions according
  /// to the actions defined in \p d and the data types in \p
  /// dtypes.  "t0" is added as a last argument of all actions.
  private static ArrayList<String>
  groundActions(Domain d, Map<String, List<String>> dtypes) {
    ArrayList<String> as = new ArrayList<>();
    for (Op o : d.getOperators()) {
      Iterable<String> it = combine(o.getParameters().iterator(), dtypes);
      String name = o.getName().getImage();
      for (String s : it)
        as.add("(" + name + s + " t0)");
    }
    return as;
  }

  // @post Outputs (quadratic) mutex clauses for \p
  // actions. Clauses are prefixed with \p prefix.

  // @remark Too expensive in terms of space. It easily leads to files of GBs in
  // size. private static void printAtMostOne(String prefix, ArrayList<String>
  // actions) { 	System.out.println(prefix + ";; At most one action is
  // executed"); 	int size = actions.size(); 	for (int i = 0; i <
  // size; i++) { 	    String newPrefix = prefix + "(or (not " +
  // actions.get(i) + ") (not
  // "; 	    for (int j = i + 1; j < size; j++)
  // System.out.println(newPrefix + actions.get(j) + "))");
  // 	}
  // }

  // @post Outputs an at-most-one constraint on the sum of the
  // 'exec' representatives for the \p actions at time "t0". The
  // formula is prefixed with \p prefix.

  // @remark Much better in terms of space, but pretty slow (doesn't propagate
  // much?) private static void printAtMostOne(String prefix, ArrayList<String>
  // actions) { 	System.out.println(prefix + ";; At most one action is
  // executed"); 	int n = actions.size(); 	for (int i = 0; i < n;
  // i++) { 	    System.out.print(prefix); 	    System.out.println("(or (=
  // (exec " + i + " t0) 0) (= (exec " + i + " t0) 1))");
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
  private static int printAtMostOne(String prefix, ArrayList<String> predicates,
                                    int i) {
    System.out.println(prefix + ";; At most one");
    double n = predicates.size();
    int m = (int)Math.ceil(Math.log(n) / Math.log(2));
    System.out.print(prefix + "(let (");
    for (int j = 0; j < m; i++, j++)
      System.out.print(" (_b" + j + " (exec " + i + " t0))");
    System.out.println(" ) (and");
    String newPrefix = prefix + '\t';
    for (int j = 0; j < n; j++) {
      String combination = toBitString(j, m);
      System.out.println(newPrefix + "(let ((_p " + predicates.get(j) +
                         ")) (and");
      for (int k = 0; k < m; k++)
        System.out.println(
            newPrefix + "\t (or (not _p) " +
            ((combination.charAt(k) == '0') ? "(not _b" + k + ")" : "_b" + k) +
            ")");
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
  private static Map<String, List<Integer>>
  unfold(Domain d, Map<String, List<String>> subtypes, Set<String> basetypes)
      throws Exception {
    HashMap<String, List<Integer>> renamedArguments = new HashMap<>();
    unfold(d, subtypes, d.getPredicates(), renamedArguments);
    unfold(d, subtypes, d.getFunctions(), renamedArguments);
    List<Op> ops = d.getOperators();
    List<Op> toAdd = new LinkedList<>();
    List<Op> toDelete = new LinkedList<>();
    for (Op o : ops) {
      Symbol name = o.getName();
      List<TypedSymbol> args = o.getParameters();
      Pair<List<List<TypedSymbol>>, List<Integer>> p =
          combineTypes(d, args, subtypes, 0);
      if (!p.second.isEmpty()) {
        toDelete.add(o);
        for (List<TypedSymbol> newArgs : p.first) {
          Op newOp = new Op(o);
          String newName = rename(name, newArgs, p.second);
          newOp.getName().setImage(newName);
          List<TypedSymbol> cargs = newOp.getParameters();
          cargs.clear();
          cargs.addAll(newArgs);
          updateNames(newOp, renamedArguments, basetypes);
          toAdd.add(newOp);
        }
      } else
        updateNames(o, renamedArguments, basetypes);
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
  private static void unfold(Domain d, Map<String, List<String>> subtypes,
                             List<NamedTypedList> sig,
                             Map<String, List<Integer>> ren) {
    List<NamedTypedList> newSig = new ArrayList<>();
    for (NamedTypedList signature : sig) {
      Pair<List<List<TypedSymbol>>, List<Integer>> p =
          combineTypes(d, signature.getArguments(), subtypes, 0);
      Symbol name = signature.getName();
      ren.put(name.getImage(), p.second);
      if (!p.second.isEmpty()) // Unfolding
        for (List<TypedSymbol> newArgs : p.first) {
          NamedTypedList newSignature = new NamedTypedList(signature);
          List<TypedSymbol> args = newSignature.getArguments();
          args.clear();
          args.addAll(newArgs);
          String newName = rename(name, args, p.second);
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
  private static Pair<List<List<TypedSymbol>>, List<Integer>>
  combineTypes(Domain d, List<TypedSymbol> lt, Map<String, List<String>> types,
               int pos) {
    List<List<TypedSymbol>> l = new LinkedList<>();
    List<Integer> li = new LinkedList<>();
    Pair<List<List<TypedSymbol>>, List<Integer>> p = new Pair<>(l, li);
    if (!lt.isEmpty()) {
      TypedSymbol t = lt.get(0);
      List<TypedSymbol> l1 = new LinkedList<>();
      boolean isEither = t.getTypes().size() > 1;
      for (int k = 0; k < t.getTypes().size(); k++) {
        List<String> typeNames = types.get(t.getTypes().get(k).getImage());
        if (typeNames == null) {
          if (!isEither)
            l1.add(t);
          else {
            if (k == 0)
              li.add(pos);
            TypedSymbol ttt = new TypedSymbol(t);
            boolean trobat = false;
            int w = -1;
            for (int j = 0; j < t.getTypes().size(); j++) {
              if (k != j && !trobat)
                ttt.getTypes().remove(0);
              else if (k != j && trobat)
                ttt.getTypes().remove(w);
              else if (k == j) {
                trobat = true;
                w = j + 1;
              }
            }
            l1.add(ttt);
          }
        } else {
          if (!isEither)
            li.add(pos);
          List<TypedSymbol> domainTypes = d.getTypes();
          for (String name : typeNames) {
            TypedSymbol variable = new TypedSymbol(t);
            Symbol type = new Symbol(getSymbol(domainTypes, name));
            variable.getTypes().set(k, type);
            l1.add(variable);
          }
        }
      }
      Pair<List<List<TypedSymbol>>, List<Integer>> pr =
          combineTypes(d, lt.subList(1, lt.size()), types, pos + 1);
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
  private static String rename(Symbol s, List<TypedSymbol> args,
                               List<Integer> whichArgs) {
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
  private static void updateNames(Op o, Map<String, List<Integer>> whichArgs,
                                  Set<String> basetypes) throws Exception {
    List<TypedSymbol> parameters = o.getParameters();
    updateNames(parameters, o.getPreconditions(), whichArgs, basetypes);
    updateNames(parameters, o.getEffects(), whichArgs, basetypes);
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
                                  Map<String, List<Integer>> whichArgs,
                                  Set<String> basetypes) throws Exception {
    switch (e.getConnective()) {
    case ATOM:
    case FN_HEAD:
      List<Symbol> atom = e.getAtom();
      Symbol name = atom.get(0);
      List<TypedSymbol> args = new LinkedList<>();
      List<Symbol> argNames = atom.subList(1, atom.size());
      for (Symbol s : argNames) {
        int i = param.indexOf(s);
        if (i != -1)
          args.add(param.get(i));
      }
      name.setImage(rename(name, args, whichArgs.get(name.getImage())));
      break;
    case FORALL:
    case EXISTS:
      // Check if all variables are of base type
      List<TypedSymbol> lv = e.getVariables();
      boolean allBase = true;
      for (TypedSymbol ts : lv)
        if (!basetypes.contains(ts.getTypes().get(0).getImage())) {
          allBase = false;
          break;
        }
      if (!allBase)
        throw new Exception("Non-base types in quantifiers unsupported:\n\n" +
                            e);
      param = new ArrayList<>(param);
      param.addAll(lv);
    default:
      for (Exp f : e.getChildren())
        updateNames(param, f, whichArgs, basetypes);
    }
  }

  /// @pre \p whichArgs.keySet() contains all names of predicates
  /// and functions occurring in \p e.

  /// @post Every predicate and function f occurring in \p e with
  /// name m has been renamed as m_t0_t1..._tn-1 where n is the
  /// length of \p whichArgs.get(m) and each ti is \p
  /// objTypes.get(arg_i) where arg_i is the i-th argument of f.
  private static void updateNames(Exp e, Map<String, List<Integer>> whichArgs,
                                  Map<String, String> objTypes) {
    switch (e.getConnective()) {
    case ATOM:
    case FN_HEAD:
      List<Symbol> atom = e.getAtom();
      Symbol name = atom.get(0);
      List<Symbol> args = atom.subList(1, atom.size());
      StringBuilder s = new StringBuilder(name.getImage());
      List<Integer> which = whichArgs.get(s.toString());
      for (Integer i : which)
        s.append("_").append(objTypes.get(args.get(i).getImage()));
      // CAMBIO: Incluir el tiempo en la variable s?????
      name.setImage(s.toString());
      break;
    default:
      for (Exp f : e.getChildren())
        updateNames(f, whichArgs, objTypes);
    }
  }

  /// @pre \p whichArgs.keySet() contains all names of predicates
  /// and functions occurring in \p p.

  /// @post Every predicate and function f occurring in \p p with
  /// name m has been renamed as m_t0_t1..._tn-1 where n is the
  /// length of \p whichArgs.get(m) and each ti is \p
  /// objTypes.get(arg_i) where arg_i is the i-th argument of f.
  private static void updateNames(Problem p,
                                  Map<String, List<Integer>> whichArgs,
                                  Map<String, String> objTypes) {
    updateNames(p.getGoal(), whichArgs, objTypes);
    for (Exp e : p.getInit())
      updateNames(e, whichArgs, objTypes);
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
        Iterator<Symbol> it1 = atom1.iterator();
        it1.next();
        Iterator<Symbol> it2 = atom2.iterator();
        it2.next();
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
  private static Map<ComparableExp, List<Op>>
  merge(Map<ComparableExp, List<Op>> modifiedLits) throws Exception {
    Map<ComparableExp, List<Op>> newMap = new TreeMap<>();
    for (Map.Entry<ComparableExp, List<Op>> entry : modifiedLits.entrySet()) {
      Pair<Map.Entry<ComparableExp, List<Op>>, List<Integer>> renamed =
          findRenamed(newMap, entry.getKey());
      if (renamed == null)
        newMap.put(entry.getKey(), entry.getValue());
      else
        merge(newMap, renamed.first, entry, renamed.second);
    }
    return newMap;
  }

  /// @pre The keys of \p m, and \p e, are expressions with
  /// connectives ATOM, NOT, or FN_HEAD.

  /// @return A pair with an entry in \p m whose key is an argument
  /// renamed version of \p e, and a list with the positions of
  /// arguments that have different name, if such a renamed version
  /// exists; null otherwise.
  private static Pair<Map.Entry<ComparableExp, List<Op>>, List<Integer>>
  findRenamed(Map<ComparableExp, List<Op>> m, ComparableExp e) {
    Pair<Map.Entry<ComparableExp, List<Op>>, List<Integer>> r = null;
    for (Map.Entry<ComparableExp, List<Op>> entry : m.entrySet()) {
      List<Integer> diff = isRename(entry.getKey(), e);
      if (diff != null) {
        r = new Pair<>(entry, diff);
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
  private static void merge(Map<ComparableExp, List<Op>> m,
                            Map.Entry<ComparableExp, List<Op>> e1,
                            Map.Entry<ComparableExp, List<Op>> e2,
                            List<Integer> diff) throws Exception {
    Map<String, String> ren1 = new HashMap<>();
    Map<String, String> ren2 = new HashMap<>();
    Exp k1 = e1.getKey();
    Exp k2 = e2.getKey();
    List<Symbol> atom1 = null;
    List<Symbol> atom2 = null;
    if (k1.getConnective() != Connective.NOT) {
      atom1 = k1.getAtom();
      atom2 = k2.getAtom();
    } else {
      atom1 = k1.getChildren().get(0).getAtom();
      atom2 = k2.getChildren().get(0).getAtom();
    }
    for (int i : diff) {
      String arg1 = atom1.get(i).getImage();
      String arg2 = atom2.get(i).getImage();
      if (arg1.charAt(0) != '?' || arg2.charAt(0) != '?')
        throw new Exception("Frame axioms -> merge : arguments which are not "
                            + "variables cannot be renamed");
      String newName = null;
      if (arg1.charAt(1) == '_')
        newName = arg1;
      else {
        newName = "?_" + arg1.substring(1);
        ren1.put(arg1, newName);
      }
      ren2.put(arg2, newName);
    }
    List<Op> l1 = rename(e1.getValue(), ren1);
    List<Op> l2 = rename(e2.getValue(), ren2);
    l1.addAll(l2);
    ComparableExp newK1 = new ComparableExp(k1);
    newK1.renameVariables(ren1);
    m.remove(k1);
    m.put(newK1, l1);
  }

  /// @return A list with all operators in \p l renamed according to
  /// \p r.
  private static List<Op> rename(List<Op> l, Map<String, String> r) {
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
  private static Map<String, Integer> constants(Problem p,
                                                Set<ComparableExp> s) {
    Set<Symbol> fNames = functionNamesIn(s);
    Map<String, Integer> m = new TreeMap<>();
    for (Exp e : p.getInit())
      if (e.getConnective() == Connective.FN_ATOM) {
        List<Exp> children = e.getChildren();
        Exp function = children.get(0);
        Exp value = children.get(1);
        Symbol fname = function.getAtom().get(0);
        if (!fNames.contains(fname) &&
            value.getConnective() == Connective.NUMBER)
          m.put(function.toString(), value.getValue().intValue());
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
  private static Set<String> valuesOf(Map<String, List<String>> m) {
    Set<String> r = new HashSet<>();
    for (List<String> l : m.values())
      r.addAll(l);
    return r;
  }

  private static Map<String, Set<Integer>> getRestrictedValues(Domain d, String jsonPath, Map<String, Object> equivalences) throws Exception {
      Map<String, Set<Integer>> restricted = new HashMap<>();
      
      String jsonContent = new String(Files.readAllBytes(Paths.get(jsonPath)));
      JsonReader jsonReader = Json.createReader(new StringReader(jsonContent));
      JsonObject jsonObject = jsonReader.readObject();
      jsonReader.close();
      
      if (!jsonObject.containsKey("operators")) return restricted;
      JsonObject operatorsJson = jsonObject.getJsonObject("operators");
      
      for (Op o : d.getOperators()) {
          String opName = o.getName().getImage().toLowerCase();
          if (!operatorsJson.containsKey(opName)) continue;
          
          JsonArray tuples = operatorsJson.getJsonArray(opName);
          List<TypedSymbol> params = o.getParameters();
          
          List<String> paramVarNames = new ArrayList<>();
          List<String> elemRepeated = new ArrayList<>();
          
          for (TypedSymbol t : params) {
              String type = t.getTypes().getFirst().getImage();
              int nVeces = Collections.frequency(elemRepeated, type);
              elemRepeated.add(type);
              String varName = type;
              if (nVeces > 0) {
                  varName = generateBaseVar(type, nVeces);
              }
              paramVarNames.add(varName);
          }
          
          for (JsonValue val : tuples) {
              JsonArray tuple = (JsonArray) val;
              for (int i = 0; i < params.size(); i++) {
                  String objName = tuple.get(i).toString().replace("\"", "");
                  Object eq = equivalences.get(objName);
                  if (eq instanceof Pair) {
                      Integer id = ((Pair<?, Integer>) eq).getSecond();
                      String var = paramVarNames.get(i);
                      restricted.computeIfAbsent(var, k -> new TreeSet<>()).add(id);
                  }
              }
          }
      }
      return restricted;
  }


  private static Set<String> collectInitAtoms(Problem pProblem) {
      Set<String> initAtoms = new HashSet<>();
      if (pProblem == null) {
          return initAtoms;
      }
      for (Exp e : pProblem.getInit()) {
          if (e.getConnective() != Connective.ATOM) {
              continue;
          }
          List<Symbol> atom = e.getAtom();
          if (atom == null || atom.isEmpty()) {
              continue;
          }
          StringBuilder key = new StringBuilder(atom.get(0).getImage());
          for (int i = 1; i < atom.size(); i++) {
              key.append("_").append(atom.get(i).getImage());
          }
          initAtoms.add(key.toString());
      }
      return initAtoms;
  }

  private static Set<String> collectGoalAtoms(Problem pProblem) {
      Set<String> goalAtoms = new HashSet<>();
      if (pProblem == null || pProblem.getGoal() == null) {
          return goalAtoms;
      }
      collectAtomsFromExp(pProblem.getGoal(), goalAtoms);
      return goalAtoms;
  }

  private static void collectAtomsFromExp(Exp e, Set<String> out) {
      if (e == null) {
          return;
      }
      Connective c = e.getConnective();
      if (c == Connective.ATOM) {
          List<Symbol> atom = e.getAtom();
          if (atom == null || atom.isEmpty()) {
              return;
          }
          StringBuilder key = new StringBuilder(atom.get(0).getImage());
          for (int i = 1; i < atom.size(); i++) {
              key.append("_").append(atom.get(i).getImage());
          }
          out.add(key.toString());
          return;
      }
      if (c == Connective.NOT && !e.getChildren().isEmpty()) {
          Exp child = e.getChildren().get(0);
          if (child.getConnective() == Connective.ATOM) {
              List<Symbol> atom = child.getAtom();
              if (atom == null || atom.isEmpty()) {
                  return;
              }
              StringBuilder key = new StringBuilder(atom.get(0).getImage());
              for (int i = 1; i < atom.size(); i++) {
                  key.append("_").append(atom.get(i).getImage());
              }
              out.add(key.toString());
              return;
          }
      }
      for (Exp child : e.getChildren()) {
          collectAtomsFromExp(child, out);
      }
  }

  private static Set<String> collectPreconditionAtomsFromJsonOperators(String jsonPath, Domain d) throws Exception {
      Set<String> atoms = new HashSet<>();

      String jsonContent = new String(Files.readAllBytes(Paths.get(jsonPath)));
      JsonReader jsonReader = Json.createReader(new StringReader(jsonContent));
      JsonObject jsonObject = jsonReader.readObject();
      jsonReader.close();

      JsonObject operatorsJson = jsonObject.getJsonObject("operators");
      if (operatorsJson == null) {
          return atoms;
      }

      Map<String, Op> domainOps = new HashMap<>();
      for (Op op : d.getOperators()) {
          domainOps.put(normalizeActionName(op.getName().getImage()), op);
      }

      for (String opName : operatorsJson.keySet()) {
          Op op = domainOps.get(normalizeActionName(opName));
          if (op == null) {
              continue;
          }
          JsonArray tuples = operatorsJson.getJsonArray(opName);
          if (tuples == null) {
              continue;
          }

          List<TypedSymbol> params = op.getParameters();
          for (JsonValue val : tuples) {
              if (val.getValueType() != JsonValue.ValueType.ARRAY) {
                  continue;
              }
              JsonArray tuple = (JsonArray) val;
              if (tuple.size() != params.size()) {
                  continue;
              }

              Map<String, String> binding = new HashMap<>();
              for (int i = 0; i < params.size(); i++) {
                  binding.put(params.get(i).getImage(), tuple.getString(i));
              }
              collectPreconditionAtomsFromExp(op.getPreconditions(), binding, atoms);
          }
      }

      return atoms;
  }

  private static Set<String> collectEffectAtomsFromJsonOperators(String jsonPath, Domain d) throws Exception {
      Set<String> atoms = new HashSet<>();

      String jsonContent = new String(Files.readAllBytes(Paths.get(jsonPath)));
      JsonReader jsonReader = Json.createReader(new StringReader(jsonContent));
      JsonObject jsonObject = jsonReader.readObject();
      jsonReader.close();

      JsonObject operatorsJson = jsonObject.getJsonObject("operators");
      if (operatorsJson == null) {
          return atoms;
      }

      Map<String, Op> domainOps = new HashMap<>();
      for (Op op : d.getOperators()) {
          domainOps.put(normalizeActionName(op.getName().getImage()), op);
      }

      for (String opName : operatorsJson.keySet()) {
          Op op = domainOps.get(normalizeActionName(opName));
          if (op == null) {
              continue;
          }
          JsonArray tuples = operatorsJson.getJsonArray(opName);
          if (tuples == null) {
              continue;
          }

          List<TypedSymbol> params = op.getParameters();
          for (JsonValue val : tuples) {
              if (val.getValueType() != JsonValue.ValueType.ARRAY) {
                  continue;
              }
              JsonArray tuple = (JsonArray) val;
              if (tuple.size() != params.size()) {
                  continue;
              }

              Map<String, String> binding = new HashMap<>();
              for (int i = 0; i < params.size(); i++) {
                  binding.put(params.get(i).getImage(), tuple.getString(i));
              }
              collectEffectAtomsFromExp(op.getEffects(), binding, atoms);
          }
      }

      return atoms;
  }

  private static void collectPreconditionAtomsFromExp(Exp e, Map<String, String> binding, Set<String> out) {
      if (e == null) {
          return;
      }
      Connective c = e.getConnective();
      if (c == Connective.ATOM) {
          List<Symbol> atom = e.getAtom();
          if (atom == null || atom.isEmpty()) {
              return;
          }
          out.add(buildGroundAtomKey(atom, binding));
          return;
      }
      if (c == Connective.NOT && !e.getChildren().isEmpty()) {
          Exp child = e.getChildren().get(0);
          if (child.getConnective() == Connective.ATOM) {
              List<Symbol> atom = child.getAtom();
              if (atom != null && !atom.isEmpty()) {
                  out.add(buildGroundAtomKey(atom, binding));
              }
              return;
          }
      }
      for (Exp child : e.getChildren()) {
          collectPreconditionAtomsFromExp(child, binding, out);
      }
  }

  private static void collectEffectAtomsFromExp(Exp e, Map<String, String> binding, Set<String> out) {
      if (e == null) {
          return;
      }
      Connective c = e.getConnective();
      if (c == Connective.ATOM) {
          List<Symbol> atom = e.getAtom();
          if (atom == null || atom.isEmpty()) {
              return;
          }
          out.add(buildGroundAtomKey(atom, binding));
          return;
      }
      if (c == Connective.NOT && !e.getChildren().isEmpty()) {
          Exp child = e.getChildren().get(0);
          if (child.getConnective() == Connective.ATOM) {
              List<Symbol> atom = child.getAtom();
              if (atom != null && !atom.isEmpty()) {
                  out.add(buildGroundAtomKey(atom, binding));
              }
          }
          return;
      }
      if (c == Connective.WHEN && e.getChildren().size() >= 2) {
          // In conditional effects, only the second child is the effect literal/formula.
          collectEffectAtomsFromExp(e.getChildren().get(1), binding, out);
          return;
      }
      for (Exp child : e.getChildren()) {
          collectEffectAtomsFromExp(child, binding, out);
      }
  }

  private static String buildGroundAtomKey(List<Symbol> atom, Map<String, String> binding) {
      StringBuilder key = new StringBuilder(atom.get(0).getImage());
      for (int i = 1; i < atom.size(); i++) {
          String arg = atom.get(i).getImage();
          key.append("_").append(binding.getOrDefault(arg, arg));
      }
      return key.toString();
  }

  private static String normalizeActionName(String name) {
      String normalized = name.toLowerCase();
      if (normalized.startsWith("_")) {
          normalized = normalized.substring(1);
      }
      return normalized;
  }

  private static void loadStaticAtoms(String jsonPath) throws Exception {
      Set<String> atoms = new HashSet<>();
      Set<String> predicates = new HashSet<>();

      String jsonContent = new String(Files.readAllBytes(Paths.get(jsonPath)));
      JsonReader jsonReader = Json.createReader(new StringReader(jsonContent));
      JsonObject jsonObject = jsonReader.readObject();
      jsonReader.close();

      if (!jsonObject.containsKey("static")) {
          staticAtoms = atoms;
          staticPredicates = predicates;
          return;
      }

      JsonArray staticJson = jsonObject.getJsonArray("static");
      for (JsonValue val : staticJson) {
          if (val.getValueType() != JsonValue.ValueType.STRING) {
              continue;
          }
          String entry = ((JsonString) val).getString().trim();
          if (entry.isEmpty()) {
              continue;
          }
          String[] parts = entry.split("\\s+");
          if (parts.length == 0) {
              continue;
          }
          String predicate = parts[0];
          predicates.add(predicate);
          StringBuilder key = new StringBuilder(predicate);
          for (int i = 1; i < parts.length; i++) {
              key.append("_").append(parts[i]);
          }
          atoms.add(key.toString());
      }

      staticAtoms = atoms;
      staticPredicates = predicates;
  }

  private static void loadJsonOperators(String jsonPath, Map<String, Object> equivalences) throws Exception {
      Map<String, List<List<Integer>>> opTuples = new HashMap<>();

      String jsonContent = new String(Files.readAllBytes(Paths.get(jsonPath)));
      JsonReader jsonReader = Json.createReader(new StringReader(jsonContent));
      JsonObject jsonObject = jsonReader.readObject();
      jsonReader.close();

      JsonObject operatorsJson = jsonObject.getJsonObject("operators");
      if (operatorsJson == null) {
          jsonOperatorTuples = opTuples;
          return;
      }

      for (String opName : operatorsJson.keySet()) {
          JsonArray tuples = operatorsJson.getJsonArray(opName);
          List<List<Integer>> converted = new ArrayList<>();
          for (JsonValue val : tuples) {
              JsonArray tuple = (JsonArray) val;
              List<Integer> ids = new ArrayList<>();
              boolean tupleValid = true;
              for (JsonValue arg : tuple) {
                  String objName = arg.toString().replace("\"", "");
                  Object eq = equivalences.get(objName);
                  if (eq instanceof Pair<?, ?>) {
                      Integer id = ((Pair<?, Integer>) eq).getSecond();
                      ids.add(id);
                  } else {
                      // If not found in equivalences, skip this tuple (inconsistent JSON)
                      tupleValid = false;
                      break;
                  }
              }
              // Keep nullary tuples as valid allowed instances (e.g. [[]] for zero-arity actions).
              if (tupleValid) {
                  converted.add(ids);
              }
          }
          opTuples.put(opName.toLowerCase(), converted);
      }

      jsonOperatorTuples = opTuples;
  }

  private static void printOperatorFilter(String prefix, Op o, int time) {
      if (jsonOperatorTuples == null || jsonOperatorTuples.isEmpty()) {
          return;
      }
      String opKey = o.getName().getImage().toLowerCase();
      if (opKey.startsWith("_")) {
          opKey = opKey.substring(1);
      }
      String lookupKey = normalizeOperatorKeyForJson(opKey);
      List<List<Integer>> tuples = jsonOperatorTuples.get(lookupKey);
      if (tuples == null || tuples.isEmpty()) {
          System.out.println(prefix + "(not " + actionNoQuant(o, "", time) + ")");
          return;
      }

      // Build variable names in parameter order, using the same scheme as actionNoQuant
      List<String> varNames = new ArrayList<>();
      Map<String, Integer> typeCounts = new HashMap<>();
      for (TypedSymbol tp : o.getParameters()) {
          String type = tp.getTypes().get(0).getImage();
          int count = typeCounts.getOrDefault(type, 0);
          String varName = generateVarType(type, count, time);
          typeCounts.put(type, count + 1);
          varNames.add(varName);
      }
      if (varNames.isEmpty()) {
          return;
      }

      System.out.println(prefix + ";; JSON operator filter");
      System.out.print(prefix + "(or");
      for (List<Integer> tuple : tuples) {
          System.out.print(" (and");
          for (int i = 0; i < tuple.size(); i++) {
              System.out.print(" (= " + varNames.get(i) + " " + tuple.get(i) + ")");
          }
          System.out.print(")");
      }
      System.out.println(")");
  }

  private static void printOperatorFilterDom(String prefix, Op o, int time) {
      if (jsonOperatorTuples == null || jsonOperatorTuples.isEmpty()) {
          return;
      }
      String opKey = o.getName().getImage().toLowerCase();
      if (opKey.startsWith("_")) {
          opKey = opKey.substring(1);
      }
      String lookupKey = normalizeOperatorKeyForJson(opKey);
      List<List<Integer>> tuples = jsonOperatorTuples.get(lookupKey);
      if (tuples == null || tuples.isEmpty()) {
          System.out.println(prefix + "(not " + actionNoQuant(o, "", time) + ")");
          return;
      }

      // Build variable names in parameter order, using the same scheme as actionNoQuant
      List<String> varNames = new ArrayList<>();
      Map<String, Integer> typeCounts = new HashMap<>();
      for (TypedSymbol tp : o.getParameters()) {
          String type = tp.getTypes().get(0).getImage();
          int count = typeCounts.getOrDefault(type, 0);
          String varName = generateVarType(type, count, time);
          typeCounts.put(type, count + 1);
          varNames.add(varName);
      }
      if (varNames.isEmpty()) {
          return;
      }

      String allowedName = "allowed_" + opKey;
      System.out.print(prefix + "(" + allowedName);
      for (String v : varNames) {
          System.out.print(" " + v);
      }
      System.out.println(")");
  }

  private static void printOperatorFilterTables(List<Op> ops) {
      if (jsonOperatorTuples == null || jsonOperatorTuples.isEmpty()) {
          return;
      }
      System.out.println(";; Operator filter tables");
      for (Op o : ops) {
          String opKey = o.getName().getImage().toLowerCase();
          if (opKey.startsWith("_")) {
              opKey = opKey.substring(1);
          }
          String lookupKey = normalizeOperatorKeyForJson(opKey);
          List<List<Integer>> tuples = jsonOperatorTuples.get(lookupKey);

          String allowedName = "allowed_" + opKey;
          System.out.print("(define-fun " + allowedName + " (");
          for (int i = 0; i < o.getParameters().size(); i++) {
              System.out.print(" (x!" + i + " Int)");
          }
          System.out.println(" ) Bool");

          if (tuples == null || tuples.isEmpty()) {
              System.out.println("  false)");
              continue;
          }

          if (o.getParameters().isEmpty()) {
              // Nullary operator: any listed empty tuple means the action is allowed.
              System.out.println("  true)");
              continue;
          }

          System.out.print("  (or");
          for (List<Integer> tuple : tuples) {
              System.out.print(" (and");
              for (int i = 0; i < tuple.size(); i++) {
                  System.out.print(" (= x!" + i + " " + tuple.get(i) + ")");
              }
              System.out.print(")");
          }
          System.out.println("))");
      }
      System.out.println();
  }

  private static String normalizeOperatorKeyForJson(String opKey) {
      if (jsonOperatorTuples.containsKey(opKey)) {
          return opKey;
      }
      String key = opKey;
      while (!jsonOperatorTuples.containsKey(key) && key.contains("_")) {
          key = key.substring(0, key.lastIndexOf('_'));
      }
      return key;
  }

  private static String generateBaseVar(String pName, int pNTimes) {
    String namenew = pName;
    if (pNTimes > 0) {
        namenew += "_new";
        for (int i = 0; i < pNTimes - 1; i++) {
          namenew += "_new";
        }
    }
    return namenew;
  }
private static void printFrameAxiomsFromJSON(String jsonPath, int pTime, Map<String, Object> equivalences, Map<String, Map<ComparableExp, List<Op>>> modifiedLitsQuants, Domain d, Map<String, List<String>> dtypes, Set<String> dtime, boolean inertiaAtoms, Set<String> initAtoms, boolean useInertiaEffSkip, boolean useInertiaEffExpl) throws Exception {
    System.out.println(";; Frame Axioms (Explanation style) from Strict JSON");
    
    // 1. Read JSON and build Known Atoms Set using NAMES for robust matching
    Set<String> knownAtoms = new HashSet<>();
    String jsonContent = new String(Files.readAllBytes(Paths.get(jsonPath)));
    JsonReader jsonReader = Json.createReader(new StringReader(jsonContent));
    JsonObject jsonObject = jsonReader.readObject();
    jsonReader.close();
    JsonObject atomsJson = jsonObject.getJsonObject("atoms");
    Set<String> jsonPredicateNames = new HashSet<>(atomsJson.keySet());
    Set<String> domainTypeNames = new HashSet<>();
    for (TypedSymbol ts : d.getTypes()) {
        domainTypeNames.add(ts.getImage());
    }
    Map<String, String> jsonBasePredicateCache = new HashMap<>();
    
    for (String pred : atomsJson.keySet()) {
        JsonArray instances = atomsJson.getJsonArray(pred);
        for (JsonValue val : instances) {
            JsonArray args = (JsonArray) val;
            StringBuilder sb = new StringBuilder(pred);
            for (JsonValue arg : args) {
                String argName = arg.toString().replace("\"", "");
                sb.append("_").append(argName);
            }
            knownAtoms.add(sb.toString());
        }
    }
    Set<String> effectAtomsFromJsonOps = (useInertiaEffSkip || useInertiaEffExpl)
        ? collectEffectAtomsFromJsonOperators(jsonPath, d)
        : Collections.emptySet();

    // 2. Iterate over ALL dynamic domain predicates AND functions
    List<NamedTypedList> allDynamic = new ArrayList<>(d.getPredicates());
    allDynamic.addAll(d.getFunctions());

    for (NamedTypedList p : allDynamic) {
        String predicate = p.getName().getImage();
        
        // ONLY generate Frame Axioms for DYNAMIC predicates (those that depend on time)
        if (!dtime.contains(predicate)) {
            continue; 
        }

        Iterable<String> combinations = combine(p.getArguments().iterator(), dtypes);
        for (String comb : combinations) {
            String[] values = comb.trim().split("\\s+");
            if (comb.trim().isEmpty()) values = new String[0];
            
            StringBuilder nameKeySb = new StringBuilder(predicate);
            List<String> argsList = new ArrayList<>();
            List<String> argsNamesList = new ArrayList<>(); 
            
            for (String v : values) {
                Object eq = equivalences.get(v);
                String id = (eq instanceof Pair) ? ((Pair<?, Integer>) eq).getSecond().toString() : v;
                nameKeySb.append("_").append(v);
                argsList.add(id);
                argsNamesList.add(v);
            }
            
            String atomKey = nameKeySb.toString();
            String jsonBasePredicate = jsonBasePredicateCache.computeIfAbsent(
                predicate,
                key -> mapPredicateToJsonBase(key, jsonPredicateNames, domainTypeNames)
            );
            String atomKeyJsonBase = buildAtomKeyFromPredicateAndArgs(jsonBasePredicate, argsNamesList);

            if (useStaticPredicates && (staticAtoms.contains(atomKey) || staticAtoms.contains(atomKeyJsonBase))) {
                continue;
            }

            boolean inJsonOrInit =
                knownAtoms.contains(atomKey) ||
                knownAtoms.contains(atomKeyJsonBase) ||
                (initAtoms != null && (initAtoms.contains(atomKey) || initAtoms.contains(atomKeyJsonBase)));

            // STRICT JSON FILTERING WITH INERTIA:
            if (inJsonOrInit) {
                // In JSON: Generate Explanatory Axioms (can change via actions)
                Map<ComparableExp, List<Op>> positiveReasons = modifiedLitsQuants.get(predicate);
                Map<ComparableExp, List<Op>> negativeReasons = modifiedLitsQuants.get("not_" + predicate);
                
                List<Map.Entry<ComparableExp, List<Op>>> adders = new ArrayList<>();
                List<Map.Entry<ComparableExp, List<Op>>> deleters = new ArrayList<>();
                if (positiveReasons != null) adders.addAll(positiveReasons.entrySet());
                if (negativeReasons != null) deleters.addAll(negativeReasons.entrySet());

                printExplanatoryAxioms(predicate, argsList, argsNamesList, pTime, equivalences, adders, deleters);
            } else {
                boolean inJsonEffects = effectAtomsFromJsonOps.contains(atomKey);
                // NOT in JSON: Strict Inertia Axiom (P_t+1 = P_t)
                // This prevents "miracles" for atoms that SAS+ pruned.
                if (inertiaAtoms){
                    if (inJsonEffects && useInertiaEffExpl) {
                        Map<ComparableExp, List<Op>> positiveReasons = modifiedLitsQuants.get(predicate);
                        Map<ComparableExp, List<Op>> negativeReasons = modifiedLitsQuants.get("not_" + predicate);

                        List<Map.Entry<ComparableExp, List<Op>>> adders = new ArrayList<>();
                        List<Map.Entry<ComparableExp, List<Op>>> deleters = new ArrayList<>();
                        if (positiveReasons != null) adders.addAll(positiveReasons.entrySet());
                        if (negativeReasons != null) deleters.addAll(negativeReasons.entrySet());
                        printExplanatoryAxioms(predicate, argsList, argsNamesList, pTime, equivalences, adders, deleters);
                        continue;
                    }
                    if (inJsonEffects && useInertiaEffSkip) {
                        continue;
                    }
                    if (useInertiaEffSkip) {
                        // With eff-skip mode, rigid atoms are fixed from the initial truth value
                        // (init + closed world), instead of chaining equalities across time.
                        boolean initTrue = initAtoms != null &&
                            (initAtoms.contains(atomKey) || initAtoms.contains(atomKeyJsonBase));
                        for (int t = 1; t <= pTime; t++) {
                            if (initTrue) {
                                System.out.print("          ");
                                printAtomSimple(predicate, argsList, t, !argsList.isEmpty());
                                System.out.println();
                            } else {
                                System.out.print("          (not ");
                                printAtomSimple(predicate, argsList, t, !argsList.isEmpty());
                                System.out.println(")");
                            }
                        }
                        continue;
                    }
                    for (int t = 0; t < pTime; t++) {
                        System.out.print("          (= ");
                        printAtomSimple(predicate, argsList, t + 1, !argsList.isEmpty());
                        System.out.print(" ");
                        printAtomSimple(predicate, argsList, t, !argsList.isEmpty());
                        System.out.println(")");
                    }
                }
            }
        }
    }
  }  private static void printExplanatoryAxioms(String predicate, List<String> argsIDs, List<String> argsNames, int pTime, Map<String, Object> equivalences, List<Map.Entry<ComparableExp, List<Op>>> adders, List<Map.Entry<ComparableExp, List<Op>>> deleters) {
      boolean hasArgs = !argsIDs.isEmpty();
      for (int t = 0; t < pTime; t++) {
          // 1. Positive Frame Axiom: (=> P_t+1 (or P_t Adders))
          System.out.print("          (=> ");
          printAtomSimple(predicate, argsIDs, t + 1, hasArgs);
          System.out.println(" (or");
          System.out.print("               ");
          printAtomSimple(predicate, argsIDs, t, hasArgs);
          System.out.println("");
          printReasonActions(adders, argsNames, t, equivalences);
          System.out.println("          ))");

          // 2. Negative Frame Axiom: (=> (not P_t+1) (or (not P_t) Deleters))
          System.out.print("          (=> (not ");
          printAtomSimple(predicate, argsIDs, t + 1, hasArgs);
          System.out.println(") (or");
          System.out.print("               (not ");
          printAtomSimple(predicate, argsIDs, t, hasArgs);
          System.out.println(")");
          printReasonActions(deleters, argsNames, t, equivalences);
          System.out.println("          ))");
      }
  }

  private static void printAtomSimple(String predicate, List<String> argsIDs, int t, boolean hasArgs) {
      if (hasArgs) System.out.print("(");
      System.out.print(predicate + "_" + t);
      for (String id : argsIDs) {
          System.out.print(" " + id);
      }
      if (hasArgs) System.out.print(")");
  }

  private static String buildAtomKeyFromPredicateAndArgs(String predicate, List<String> argNames) {
      StringBuilder sb = new StringBuilder(predicate);
      for (String arg : argNames) {
          sb.append("_").append(arg);
      }
      return sb.toString();
  }

  private static String mapPredicateToJsonBase(String predicate, Set<String> jsonPredicates, Set<String> domainTypeNames) {
      if (jsonPredicates.contains(predicate)) {
          return predicate;
      }
      String best = predicate;
      int bestLen = -1;
      for (String candidate : jsonPredicates) {
          if (!predicate.startsWith(candidate + "_")) {
              continue;
          }
          String suffix = predicate.substring(candidate.length() + 1);
          if (suffix.isEmpty()) {
              continue;
          }
          String[] tokens = suffix.split("_");
          boolean allTypes = true;
          for (String token : tokens) {
              if (!domainTypeNames.contains(token)) {
                  allTypes = false;
                  break;
              }
          }
          if (allTypes && candidate.length() > bestLen) {
              best = candidate;
              bestLen = candidate.length();
          }
      }
      return best;
  }

  private static void printReasonActions(List<Map.Entry<ComparableExp, List<Op>>> reasons, List<String> argsNames, int t, Map<String, Object> equivalences) {
      for (Map.Entry<ComparableExp, List<Op>> entry : reasons) {
          ComparableExp effectLiteral = entry.getKey();
          List<Op> ops = entry.getValue();
          List<Symbol> effectAtom = (effectLiteral.getConnective() == Connective.NOT) ? 
                                     effectLiteral.getChildren().get(0).getAtom() : 
                                     effectLiteral.getAtom();
          List<Symbol> effectArgs = effectAtom.subList(1, effectAtom.size());

          for (Op o : ops) {
              List<TypedSymbol> actionParams = o.getParameters();
              String actionAtTime = o.getName().getImage() + "_" + t;
              if (actionParams.isEmpty()) {
                  // Nullary action symbols must be used directly, not as function calls.
                  System.out.println("               (and " + actionAtTime);
              } else {
                  System.out.print("               (and (" + actionAtTime + " ");
                  Map<String, Integer> typeCounts = new HashMap<>();
                  for (TypedSymbol tp : actionParams) {
                      String type = tp.getTypes().get(0).getImage();
                      int count = typeCounts.getOrDefault(type, 0);
                      System.out.print(generateVarType(type, count, t) + " ");
                      typeCounts.put(type, count + 1);
                  }
                  System.out.println(")");
              }

              Map<String, Integer> typeCounts = new HashMap<>();
              typeCounts.clear();
              for (int pIdx = 0; pIdx < actionParams.size(); pIdx++) {
                  TypedSymbol param = actionParams.get(pIdx);
                  String type = param.getTypes().get(0).getImage();
                  int count = typeCounts.getOrDefault(type, 0);
                  typeCounts.put(type, count + 1);
                  String varName = generateVarType(type, count, t);

                  for (int aIdx = 0; aIdx < effectArgs.size(); aIdx++) {
                      if (effectArgs.get(aIdx).getImage().equals(param.getImage())) {
                          String objName = argsNames.get(aIdx); // Use Name to look up in equivalences
                          Object eq = equivalences.get(objName);
                          Integer objId = (eq instanceof Pair) ? ((Pair<?, Integer>) eq).getSecond() : null;
                          // If objId is null, check if objName is a numeric string (unlikely) or just use it (if it's a constant handled elsewhere)
                          System.out.println("               (= " + varName + " " + (objId != null ? objId : objName) + ")");
                      }
                  }
              }
              System.out.println("               )");
          }
      }
  }


  /// @return A string of length \p bits, corresponding to the
  /// binary representation of \p x. Most significant bits are
  /// truncated if the length is not enough.
  private static String toBitString(int x, int bits) {
    String bitString = Integer.toBinaryString(x);
    int size = bitString.length();
    StringBuilder sb = new StringBuilder(bits);
    if (bits > size) {
      for (int i = 0; i < bits - size; i++)
        sb.append('0');
      sb.append(bitString);
    } else {
      sb = sb.append(bitString.substring(size - bits, size));
    }
    return sb.toString();
  }
  private static void regenerateJsonFile(String domainPath, String problemPath, String outputFileName) {
      try {
          String scriptPath = resolveTranslateScriptPath();
          if (scriptPath == null) {
              System.err.println(";; Error: Could not find run_translate_and_parse_sas.py");
              System.err.println(";; Checked: ./run_translate_and_parse_sas.py and ./src/translate/run_translate_and_parse_sas.py (from current/parent directories)");
              System.exit(1);
          }
          ProcessBuilder pb = new ProcessBuilder("python3", scriptPath, domainPath, problemPath);
          Process process = pb.start();

          BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
          BufferedReader errorReader = new BufferedReader(new InputStreamReader(process.getErrorStream()));
          
          StringBuilder output = new StringBuilder();
          String line;
          while ((line = reader.readLine()) != null) {
              output.append(line).append("\n");
          }
          
          StringBuilder errors = new StringBuilder();
          while ((line = errorReader.readLine()) != null) {
              errors.append(line).append("\n");
          }

          int exitCode = process.waitFor();
          if (exitCode == 0) {
              String content = output.toString().trim();
              if (!content.isEmpty()) {
                  Files.write(Paths.get(outputFileName), content.getBytes());
              } else {
                  System.err.println(";; Warning: Python script returned empty JSON.");
              }
          } else {
              System.err.println(";; Error regenerating JSON (Exit Code " + exitCode + ")");
              System.err.println(errors.toString());
              System.exit(1);
          }
      } catch (Exception e) {
          System.err.println(";; Error executing Python script: " + e.getMessage());
          e.printStackTrace();
          System.exit(1);
      }
  }

  private static String resolveTranslateScriptPath() {
      List<Path> candidates = Arrays.asList(
          Paths.get("run_translate_and_parse_sas.py"),
          Paths.get("src", "translate", "run_translate_and_parse_sas.py")
      );
      Path cwd = Paths.get(System.getProperty("user.dir")).toAbsolutePath().normalize();
      Path current = cwd;
      while (current != null) {
          for (Path rel : candidates) {
              Path candidate = current.resolve(rel).normalize();
              if (Files.isRegularFile(candidate)) {
                  return candidate.toString();
              }
          }
          current = current.getParent();
      }
      return null;
  }
}
