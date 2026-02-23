

import fr.uga.pddl4j.parser.*;

import javax.swing.tree.*;

import java.io.*;
import java.nio.file.*;
import java.util.*;

import javax.json.*;


public class pddl2sat {

    private static Map<String, Integer> variables;
    private static Map<Integer, String> variablesInv;
    private static Set<String> initVariables;
    private static Map<String, Set<String>> addOperators; // Operators that add a predicate
    private static Map<String, Set<String>> delOperators; // Operators that delete a predicate
    private static Hashtablelist<Symbol, Symbol> tiposObjetos;
    private static TreeModel typesTree;
    private static int varNumber;
    private static List<List<Integer>> expression;
    private static List<String> formula;
    private static int t;
    private static boolean isActionCost;
    private static boolean useJsonFilter;
    private static String jsonPath;
    private static Set<String> jsonAtoms;
    private static Set<String> jsonStaticAtoms;
    private static Set<String> jsonStaticPredicates;
    private static Map<String, Set<String>> jsonOperators;
    private static Set<String> allPredicateBaseNames;
    private static Set<String> initPredicateBaseNames;
    private static int stepsTotal;
    private static boolean useStaticPredicates;
    private static boolean useInertia;
    private static boolean useInitPredicates;

    public static void main(String[] args) throws Exception {
        String domainPath = null;
        String problemPath = null;
        String stepsStr = null;
        String formulaPath = null;
        String modelPath = null;
        boolean generateJson = false;
        useJsonFilter = false;
        useStaticPredicates = false;
        useInertia = false;
        useInitPredicates = false;
        jsonPath = "output.json";
        //Cambios

        for (int i = 0; i < args.length; i++) {
            switch (args[i]) {
                case "-d":
                    if (i + 1 < args.length) domainPath = args[++i];
                    break;
                case "-p":
                    if (i + 1 < args.length) problemPath = args[++i];
                    break;
                case "-s":
                    if (i + 1 < args.length) stepsStr = args[++i];
                    break;
                case "-f":
                    if (i + 1 < args.length) formulaPath = args[++i];
                    break;
                case "-m":
                    if (i + 1 < args.length) modelPath = args[++i];
                    break;
                case "-j":
                    generateJson = true;
                    useJsonFilter = true;
                    // Using -j implies the --init --static behavior.
                    useInitPredicates = true;
                    useStaticPredicates = true;
                    if (i + 1 < args.length && !args[i + 1].startsWith("-")) {
                        jsonPath = args[++i];
                    }
                    break;
                case "--inertia":
                    useInertia = true;
                    break;
                case "-h":
                case "--help":
                    printHelp();
                    return;
            }
        }

        if (Arrays.asList(args).contains("--init") || Arrays.asList(args).contains("--static")) {
            System.err.println("Error: --init and --static are no longer accepted explicitly. Use -j (it already implies both).");
            printHelp();
            return;
        }

        if (useJsonFilter) {
            if (useInertia) {
                System.err.println("Error: when using -j, --inertia is not allowed.");
                printHelp();
                return;
            }
        }

        if (args.length == 0) {
            printHelp();
            return;
        }
        if (formulaPath != null && modelPath != null) {
            GeneratePlan gp = new GeneratePlan(formulaPath, modelPath);
            gp.generateSolPlan();
        }
        else if (domainPath != null && problemPath != null && stepsStr != null) {
            Parser parser = new Parser();
            try {
                t = 0;
                int steps = Integer.parseInt(stepsStr);
                stepsTotal = steps;
                variables = new HashMap<>();
                variablesInv = new HashMap<>();
                initVariables = new HashSet<>();
                initPredicateBaseNames = new HashSet<>();
                addOperators = new HashMap<>();
                delOperators = new HashMap<>();
                tiposObjetos = new Hashtablelist<>();
                expression = new ArrayList<>();
                varNumber = 1;
                formula = new ArrayList<>();
                allPredicateBaseNames = new HashSet<>();
                if (generateJson && !Files.exists(Paths.get(jsonPath))) {
                    regenerateJsonFile(domainPath, problemPath, jsonPath);
                }
                if (useJsonFilter) {
                    loadJsonData(jsonPath);
                }
                parseSilently(parser, domainPath, problemPath);
                Domain d = parser.getDomain();
                Problem p = parser.getProblem();
                readTypes(d);
                readInit(p);
                readConstants(d);
                readObjects(p);
                readPredicate(d);
                for (t = 1; t <= steps; t++) {
                    readActions(d);
                }
                t--;
                generateFrameAxioms();
                generateJsonInertiaAxioms();
                readGoal(p);
                mostrar();
            } catch (NumberFormatException e){
                System.err.println("The number steps introduced by parameter is not a number.");
            } catch (Exception e) {
                System.err.println();
                System.err.println("Error processing " + domainPath + " + " + problemPath);
                System.err.println();
                e.printStackTrace();
            }
        }
        else{
            printHelp();
        }
    }

    private static void printHelp() {
        System.out.println("Usage:");
        System.out.println("  java pddl2sat -d <domain.pddl> -p <problem.pddl> -s <steps>");
        System.out.println("  java pddl2sat -d <domain.pddl> -p <problem.pddl> -s <steps> -j [json]");
        System.out.println("  java pddl2satnew -f <formula.cnf> -m <model>");
        System.out.println();
        System.out.println("Options:");
        System.out.println("  -d <file>         PDDL domain file");
        System.out.println("  -p <file>         PDDL problem file");
        System.out.println("  -s <int>          Number of steps");
        System.out.println("  -j [file]         Use JSON; generate if it does not exist (default: output.json). Implies --init --static");
        System.out.println("  --inertia         Not allowed together with -j");
        System.out.println("  -f <file> -m <file>  Generate plan from CNF/model");
    }

    private static void mostrar(int pSteps) {
        String filePath = "/home/josu/Documents/PhD_Girona/pddl-parser/formula" + pSteps +".cnf";
        try (FileWriter fileWriter = new FileWriter(filePath)){
            fileWriter.write("p cnf ");
            fileWriter.write(variables.size() + " ");
            fileWriter.write(" ");
            fileWriter.write(expression.size() + "\n");
            fileWriter.write("\n");
            for (List<Integer> l: expression) {
                for (Integer n: l){
                    fileWriter.write(n.toString());
                    fileWriter.write(" ");
                }
                fileWriter.write("0");
                fileWriter.write("\n");
            }
        } catch (IOException e){
            e.printStackTrace();
        }
    }

    private static void mostrar() {
        //for (Map.Entry<Integer, String > e: variablesInv.entrySet())
            //System.out.println("c " + e.getKey() + " " + e.getValue());
        System.out.print("p cnf ");
        System.out.print(variables.size() + " ");
        System.out.println(expression.size());
        for (List<Integer> l: expression) {
            for (Integer n: l){
                System.out.print(n.toString());
                System.out.print(" ");
            }
            System.out.println("0");
        }
    }

    private static void readInit(Problem pProblem) throws Exception {
        List<Exp> init = pProblem.getInit();
        for (Exp e : init) {
            if (useStaticPredicates) {
                Boolean staticVal = evalStaticAtom(e, null, null, ExpType.INIT);
                if (staticVal != null) {
                    if (staticVal) {
                        String var = generateVarPreOrEff(e, null, null, ExpType.INIT);
                        if (var != null) {
                            initVariables.add(var);
                            if (useInitPredicates) {
                                initPredicateBaseNames.add(baseNameFromTimedLiteral(var));
                            }
                        }
                    } else {
                        expression.add(new ArrayList<>());
                    }
                    continue;
                }
            }
            List<String> initVars = getExpressionVariables(e, null, null, ExpType.INIT);
            if (initVars != null) {
                if (useInitPredicates) {
                    for (String v : initVars) {
                        initPredicateBaseNames.add(baseNameFromTimedLiteral(v));
                    }
                }
                initVariables.addAll(initVars);
                if (!initVars.isEmpty()) {
                    expression.add(generateDimacsOr(initVars, false));
                }
            }
        }
    }

    private static void readFunctions(Domain d) {
        List<NamedTypedList> functions = d.getFunctions();
        int i = 0;
        while (!isActionCost && i < functions.size()){
            if (functions.get(i).getName().getImage().equals("total-cost")){
                isActionCost = true;
//                System.out.println("c This file originally works with action-costs");
//                System.out.println("c We are omitting the costs during the encoding");
            }
        }
    }

    private static void readGoal(Problem pProblem) throws Exception {
        Exp goal = pProblem.getGoal();
        List<String> goalVars = getExpressionVariables(goal, null, null, ExpType.GOAL);
        // Adds the element in the list as clausules
        generateDimacsAnd(null, goalVars, false);
    }

    private static void readObjects(Problem pProblem) {
        List<TypedSymbol> objects = pProblem.getObjects();
        for (TypedSymbol o : objects) {
            //Voy a añadir suponiendo que hay un unico tipo por objeto o que el más bajo es el que esta en la cero.
            //Probablemente en el futuro esto tenga que se modificado.
            tiposObjetos.putSingle(o.getTypes().getFirst(), o);
        }
    }
    private static void readConstants(Domain pDomain) {
        List<TypedSymbol> objects = pDomain.getConstants();
        for (TypedSymbol o : objects) {
            //Voy a añadir suponiendo que hay un unico tipo por objeto o que el más bajo es el que esta en la cero.
            //Probablemente en el futuro esto tenga que se modificado.
            tiposObjetos.putSingle(o.getTypes().getFirst(), o);
        }
    }

    private static void readPredicate(Domain pDomain) throws Exception {
        List<NamedTypedList> predicates = pDomain.getPredicates();
        for (NamedTypedList predicate: predicates){
            generateNegatedInit(predicate);
        }
    }

    private static void readTypes(Domain d){
        List<TypedSymbol> tipos = d.getTypes();
        tipos.sort(new ComparatorTypedSymbol());
        tipos.removeFirst();
//        System.out.println("Purged types: " + tipos);
        TreeNode root = new DefaultMutableTreeNode("object");
        typesTree = new DefaultTreeModel(root);
        ((DefaultTreeModel) typesTree).setAsksAllowsChildren(true);
        // Caution: types are not well sorted, so failed attempts to add nodes to the tree are queued until completion.
        // @TODO Need to avoid types with more than one parent? (e.g. type area in storage STRIPS benchmark); currently taking the first parent.
        Queue<TypedSymbol> queue = new LinkedList<>(tipos);
        while (!queue.isEmpty()) {
            TypedSymbol t = queue.poll();
            DefaultMutableTreeNode nodo = new DefaultMutableTreeNode(t.getImage());
            DefaultMutableTreeNode padre = new DefaultMutableTreeNode(t.getTypes().getFirst().getImage());
            ((DefaultTreeModel) typesTree).insertNodeInto(nodo, padre, padre.getChildCount());
            if (!addNodeToTree(root, nodo, padre))
                queue.add(t);
        }
        /* for (TypedSymbol t: tipos){
            DefaultMutableTreeNode nodo = new DefaultMutableTreeNode(t.getImage());
            DefaultMutableTreeNode padre = new DefaultMutableTreeNode(t.getTypes().getFirst().getImage());
            ((DefaultTreeModel) typesTree).insertNodeInto(nodo, padre, padre.getChildCount());
            if (!addNodeToTree(root, nodo, padre))
                throw new InternalError("It has not been possible to add the node " + nodo + " to the father " + padre);
        }*/
    }

    private static void generateFrameAxioms() {
        for (Map.Entry<String, Set<String>> entry : addOperators.entrySet()) {
            String pred = entry.getKey();
            if (useJsonFilter && useInertia
                    && !isAtomAllowed(baseNameFromTimedLiteral(pred))
                    && (!useInitPredicates || initPredicateBaseNames == null || !initPredicateBaseNames.contains(baseNameFromTimedLiteral(pred)))) {
                continue;
            }
            List<String> addOps = new ArrayList<>();
            int time = Integer.parseInt(pred.substring(pred.lastIndexOf('_') + 1));
            if (time > 0) {
                addOps.add(changeTime(pred, -1));
                addOps.add(negateVar(pred));
                addOps.addAll(entry.getValue());
                expression.add(generateDimacsOr(addOps, false));
            }
        }
        for (Map.Entry<String, Set<String>> entry : delOperators.entrySet()) {
            String pred = entry.getKey();
            if (useJsonFilter && useInertia
                    && !isAtomAllowed(baseNameFromTimedLiteral(pred))
                    && (!useInitPredicates || initPredicateBaseNames == null || !initPredicateBaseNames.contains(baseNameFromTimedLiteral(pred)))) {
                continue;
            }
            List<String> delOps = new ArrayList<>();
            int time = Integer.parseInt(pred.substring(pred.lastIndexOf('_') + 1));
            if (time > 0) {
                delOps.add(negateVar(changeTime(pred, -1)));
                delOps.add(pred);
                delOps.addAll(entry.getValue());
                expression.add(generateDimacsOr(delOps, false));
            }
        }
    }

    /**
     * Changes the signature of a variable depending on the parameter pTime.
     *
     * @param pVarName Name of the variable.
     * @param pTime Units of time is wanted to be decreased or increased.
     * @return Returns the new variable name.
     */
    private static String changeTime(String pVarName, int pTime){
        /*
        char[] name = pVarName.toCharArray();
        int numero = 0, j = 0;
        for (int i = (name.length - 1); i >= 0 ; i--) {
            String c = String.valueOf(name[i]);
//            System.out.println(c);
            if (c.matches("\\d")){
                numero += (int) (Integer.parseInt(c) * Math.pow(10, j));
                j++;
            }else{
                break;
            }
        }
//        System.out.println(numero);
        return pVarName.substring(0, (name.length - j)) + (numero + pTime);
        */

        String[] name = pVarName.split("__");
        String number = name[name.length - 1];
        int n = Integer.parseInt(number);
        return pVarName.substring(0, pVarName.length() - number.length()) + (n + pTime);
    }

    private static String negateVar(String pVar){
        if (isNegated(pVar)){
            return pVar.substring(2);
        }else{
            return "! " + pVar;
        }
    }

    private static void generateNegatedInit(NamedTypedList predicate) throws Exception {
        List<TypedSymbol> arguments = predicate.getArguments();
        List<List<Symbol>> combinations = generateCombinations(arguments);
        //System.out.println("Combinations (negated init of " + predicate + "): " + combinations);
        for (List<Symbol> c: combinations) {
            Symbol predName = predicate.getName();
            String baseName = buildBaseName(predName.getImage(), c);
            allPredicateBaseNames.add(baseName);
            StringBuilder vName = new StringBuilder(baseName);
            vName.append("__").append(0);
            String name = vName.toString();
            if (!initVariables.contains(name)) {
                Integer vNumber = variables.get(name);
                if (vNumber == null) {
                    vNumber = addVariable(name, false);
                }
                expression.add(new ArrayList<>(List.of(-vNumber)));
                String formulae = vName.insert(0, "! ").toString();
                formula.add(formulae);
            }
        }
    }

    private static void readActions(Domain pDomain) throws Exception {
        List<String> actionsVariables = new ArrayList<>();
        List<Op> acciones = pDomain.getOperators();
        for (Op a : acciones) {
            actionsVariables.addAll(generateActionStatements(a));
        }
        generateAtMostOne(actionsVariables);
    }

    private static void generateAtMostOne(List<String> pActionsVariablesList) {
        // Binomial encoding
        /*for (int i = 0; i < pActionsVariablesList.size(); i++) {
            for (int j = i + 1 ; j < pActionsVariablesList.size(); j++) {
                expression.add(generateDimacsOr(Arrays.asList("! " + pActionsVariablesList.get(i), "! " + pActionsVariablesList.get(j))));
            }
        }*/

        // Binary encoding
        int n = pActionsVariablesList.size();
        int log2n = (int) Math.ceil(Math.log(n) / Math.log(2));
        List<String> auxVars = addAuxiliaryVariables(log2n);
        List<BitSet> lBitSet = bitsets(n);
        for (int i = 0; i < n; i++) {
            BitSet bs = lBitSet.get(i);
            for (int j = 0; j < log2n; j++) {
                expression.add(generateDimacsOr(Arrays.asList(
                        "! " + pActionsVariablesList.get(i),
                        (bs.get(j)? "" : "! ") + auxVars.get(j)
                ), false));
            }
        }
    }

    // Returns a list with n different bitsets
    private static List<BitSet> bitsets(int n) {
        List<BitSet> r = new ArrayList<>();
        for (int i = 0; i < n; i++)
            r.add(BitSet.valueOf(new long[]{i}));
        return r;
    }

    // Returns a list with n new auxiliary variables
    private static List<String> addAuxiliaryVariables(int n) {
        List<String> r = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            String newVar = "aux__" + i + "__" + t;
            r.add(newVar);
            addAuxiliaryVariable(newVar);
        }
        return r;
    }

    /**
     * Given the root (pRoot) of the tree and the node (pFather) from which the node (pNode) must be added.
     *
     * @param pRoot Root node.
     * @param pNode Node to add.
     * @param pFather Father node of pNode.
     * @return Returns true if it has been possible, false if not.
     */
    private static boolean addNodeToTree(TreeNode pRoot, TreeNode pNode, TreeNode pFather) {
        if ((pRoot instanceof DefaultMutableTreeNode) & (pNode instanceof DefaultMutableTreeNode)){
            if (((DefaultMutableTreeNode) pRoot).getUserObject().equals(((DefaultMutableTreeNode)pFather).getUserObject())) {
                ((DefaultMutableTreeNode) pRoot).add((DefaultMutableTreeNode)pNode);
                    return true;
            } else {
                for (int i = 0; i < pRoot.getChildCount(); i++) {
                    if (addNodeToTree(pRoot.getChildAt(i), pNode, pFather))
                        return true;
                }
            }
        }
        return false;
    }


    private static List<String> generateActionStatements(Op a) throws Exception {
        List<String> actionVarList = new ArrayList<>();
        List<TypedSymbol> parametros = a.getParameters();
        String[] ordParam = new String[parametros.size()];
        for (int i = 0; i < parametros.size(); i++) {
            ordParam[i] = parametros.get(i).getImage();
        }
        List<List<Symbol>> combinations = generateCombinations(parametros);
        //System.out.println("Combinations (action statements of " + a + "): " + combinations);
        for (List<Symbol> c: combinations){
            if (!isActionInstanceAllowed(a.getName().getImage(), c)) {
                continue;
            }
            StringBuilder actionName = new StringBuilder();
            actionName.append(a.getName().getImage());
            actionName = concatSymbolsAndTime(actionName, c, -1, true);
            String actionVar = actionName.toString();
            // PUEDE SER QUE NO EXISTA NUNCA ESTA ACCION
            // actionVarList.add(actionVar);
            Exp preconditions = a.getPreconditions();
            List<String> preconditionsList = generatePreAndEffects(c, actionVar, preconditions, ordParam, ExpType.PRECONDITION);
            if (preconditionsList != null) {
                addVariable(actionName.toString(), true);
                actionVarList.add(actionVar);
                updateAddDelOperators(preconditionsList);
                Exp effects = a.getEffects();
                List<String> effectsList = generatePreAndEffects(c, actionVar, effects, ordParam, ExpType.EFFECT);
                updateAddDelOperators(actionVar, effectsList);
            }
        }
        return actionVarList;
    }

    private static void updateAddDelOperators(List<String> preconditionsList) {
        for (String e: preconditionsList)
            if (isNegated(e)) {
                String realE = e.substring(2);
                delOperators.computeIfAbsent(realE, k -> new HashSet<>());
            }
            else
                addOperators.computeIfAbsent(e, k -> new HashSet<>());
    }

    private static void updateAddDelOperators(String actionVar, List<String> effectsList) {
        for (String e: effectsList)
            if (isNegated(e)) {
                String realE = e.substring(2);
                delOperators.computeIfAbsent(realE, k -> new HashSet<>()).add(actionVar);
            }
            else
                addOperators.computeIfAbsent(e, k -> new HashSet<>()).add(actionVar);
    }

    /**
     * Creates and stores the preconditions or effects of an action in DIMACS format
     *
     * @param pCombination A concrete combination of the parameters of the action
     * @param pName Name of the action
     * @param pPreOrEffExp Expression of the precondition
     * @param pOrdParam Order of the parameters of the action
     * @param pEffect Is it is a precondition or an effect
     * @return Returns a list with the literals of the preconditions or effects
     */
    private static List<String> generatePreAndEffects(List<Symbol> pCombination, String pName, Exp pPreOrEffExp, String[] pOrdParam, ExpType pEffect) throws Exception {
        List<String> rightExpressions = getExpressionVariables(pPreOrEffExp, pCombination, pOrdParam, pEffect);
        //Negate the left to be an OR instead of an implication.
        if (rightExpressions != null){
            for(String variable: rightExpressions){
                if(variable.startsWith("!")){
                    addVariable(variable.substring(2), false);
                }else{
                    addVariable(variable, false);
                }
            }
            generateDimacsAnd("! " + pName, rightExpressions, true);
        }
        return rightExpressions;
    }

    /**
     * Given a String or an StringBuilder, and a list of Symbols concats them generating a variable name with the time.
     *
     * @param actionName   The name of the action
     * @param pCombination A concrete combination of the parameters of the action
     * @param pTime        It is zero or one.
     * @param pIsAction
     * @throws Exception
     */
    private static StringBuilder concatSymbolsAndTime(Object actionName, List<Symbol> pCombination, int pTime, boolean pIsAction) throws Exception {
        StringBuilder aName;
        if (actionName instanceof String){
            aName = new StringBuilder((String) actionName);
        }else if (actionName instanceof StringBuilder){
            aName = (StringBuilder) actionName;
        }else{
            throw new Exception();
        }
        for (Symbol symbol : pCombination) {
            aName.append("__").append(symbol.getImage());
        }
        aName.append("__").append(t+pTime);
        //addVariable(aName.toString(), pIsAction);
        return aName;
    }

    /**
     * For each precondition generates the DIMACS expression given the left and the right part of the implication
     * Indeed it is an OR.
     *
     * @param pLeftName   Left part of the disjunction.
     * @param pRightNames List of the right parts of the disjunction.
     * @param pIsAction
     */
    private static void generateDimacsAnd(String pLeftName, List<String> pRightNames, boolean pIsAction){
        if (pLeftName == null){
            for (String variableClausula: pRightNames) {
                Integer varNum = variables.get(variableClausula);
                if (varNum == null){
                    expression.add(new ArrayList<>(List.of(varNumber)));
                    formula.add(variableClausula);
                    addVariable(variableClausula, pIsAction);
                }else{
                    expression.add(new ArrayList<>(List.of(varNum)));
                    formula.add(variableClausula);
                }
            }
        }else {
            for (String ln : pRightNames) {
                List<Integer> f = generateDimacsOr(new ArrayList<>(Arrays.asList(pLeftName, ln)), pIsAction);
                expression.add(f);
            }
        }
    }

    /**
     * This method given a clause generates the same clause in DIMACS format and adds the clause to the original formula.
     *
     * @param pLiterals is an ArrayList of Strings (indeed a clause), where each String is a literal.
     * @param pIsAction
     * @return a List of the Integer class which is a DIMACS expression.
     */
    private static List<Integer> generateDimacsOr(List<String> pLiterals, boolean pIsAction) {
        List<Integer> dimacsExp = new ArrayList<>();
        StringBuilder logicFormula = new StringBuilder();
        for (int i = 0; i < pLiterals.size(); i++) {
            Object l = pLiterals.get(i);
            Integer varNum;
            if (isNegated((String) l)) {
                String realL = ((String) l).substring(2); //Porque es "! " es decir el espacio tambien
                varNum = variables.get(realL);
                if (varNum == null){
                    varNum = addVariable(realL, pIsAction);
                }
                dimacsExp.add(-varNum);
            } else {
                varNum = variables.get(l);
                if (varNum == null){
                    varNum = addVariable((String) l, pIsAction);
                }
                dimacsExp.add(varNum);
            }
            if (i == pLiterals.size()-1)
                logicFormula.append(l);
            else
                logicFormula.append(l).append(" | ");
        }
        formula.add(logicFormula.toString());
//        Integer[] dimacsExpArr = (Integer[]) dimacsExp.toArray();
        return dimacsExp;
    }

    /**
     * Given a literal in a string returns if is negated.
     *
     * @param pLiteral A literal in a String.
     * @return True if the literal name starts with !, False in other case.
     */
    private static boolean isNegated(String pLiteral) {
        return pLiteral.startsWith("!");
    }

    /**
     * Given an Expression, a combination of the parameters, the order and the type of the expression (INIT, GOAL, etc.)
     * returns a list of the variables of the expression codified.
     *
     * @param pExp The expression from the variables are extracted.
     * @param pCombination Combination of the parameters/arguments of the action/predicate.
     * @param pOrdParam The name of the variables of the parameters.
     * @param pExpressionType Type of expression (INIT, GOAL, PREDICATE, EFFECT).
     * @return Returns a list of String, they are variables.
     * @throws Exception
     */
    private static List<String> getExpressionVariables(Exp pExp, List<Symbol> pCombination, String[] pOrdParam, ExpType pExpressionType) throws Exception {
        if (pExp.getConnective().equals(Connective.ATOM)){
            Boolean staticVal = evalStaticAtom(pExp, pCombination, pOrdParam, pExpressionType);
            if (staticVal != null) {
                return staticVal ? new ArrayList<>() : null;
            }
            String var = generateVarPreOrEff(pExp, pCombination, pOrdParam, pExpressionType);
            if (var == null) return null;
            return new ArrayList<>(List.of(var));
        }else if(pExp.getConnective().equals(Connective.FN_ATOM)) {
            // When its an action-cost
            return null;
        }else if(pExp.getConnective().equals(Connective.EQUAL_ATOM)){
            // Check when objects are equal (2 params)
            List<Symbol> listE = pExp.getAtom();
            int[] paramPositions = getPositionOfParams(pOrdParam, listE);
            if (compareEqNotEqObjetParam(pCombination, paramPositions, true)){
                // Cuando son iguales y tenian que ser iguales
                return new ArrayList<>();
            }else{
                // Cuando no son iguales y tenian que ser iguales
                // Not adding: action, any precondition and any effect.
                return null;
            }
        }else if(pExp.getConnective().equals(Connective.INCREASE)){
            // When its an action-cost
//            System.out.println(pExp.getChildren().getFirst().getAtom().getFirst().getImage() + "Es el nombre del increase del action");
            if (pExp.getChildren().getFirst().getAtom().getFirst().getImage().equals("total-cost")){
                return new ArrayList<>();
            }else{
                throw new Exception("We cannot handle INCREASE operations yet.");
            }
        }else if(pExp.getConnective().equals(Connective.NOT)){
            //It depends on the children
            List<Exp> children = pExp.getChildren();
            for(Exp child: children){
                if(child.getConnective().equals(Connective.ATOM)){
                    Boolean staticVal = evalStaticAtom(child, pCombination, pOrdParam, pExpressionType);
                    if (staticVal != null) {
                        return staticVal ? null : new ArrayList<>();
                    }
                    String var = generateVarPreOrEff(pExp, pCombination, pOrdParam, pExpressionType);
                    if (var == null) return null;
                    return new ArrayList<>(List.of("! " + var));
                }else if(child.getConnective().equals(Connective.EQUAL_ATOM)){
                    //Check when objects are not equal
                    List<Symbol> listE = child.getAtom();
                    int[] paramPositions = getPositionOfParams(pOrdParam, listE);
                    if (compareEqNotEqObjetParam(pCombination, paramPositions, false)){
                        // Cuando no son iguales y efectivamente, no tenian que ser iguales
                        return new ArrayList<>();
                    }else{
                        // Cuando son iguales y no tenían que ser iguales
                        // Not adding: action, any precondition and any effect.
                        return null;
                    }
                }else{
                    throw new Exception("We cannot handle NOT whenever is not a variable, or after there is an equal.");
                }
            }
        }else if(pExp.getConnective().equals(Connective.AND)){
            List<Exp> lExp = pExp.getChildren();
            List<String> fullExpStr = new ArrayList<>();
            for (Exp e: lExp){
                List<String> lista = getExpressionVariables(e, pCombination, pOrdParam, pExpressionType);
                if(lista != null) {
                    fullExpStr.addAll(lista);
                }else{
                    return null;
                }
            }
            return fullExpStr;
        }else{
            throw new Exception("The connector is not ATOM, NOT or AND. It is " + pExp.getConnective());
        }
        throw new Exception("I dont know the case where this happens.");
    }

    private static boolean compareEqNotEqObjetParam(List<Symbol> pCombination, int[] paramPositions, boolean pAreEqual) {
        //NXOR !(pCombination.get(paramPositions[0]).equals(pCombination.get(paramPositions[1])) ^ pAreEqual)
        return pCombination.get(paramPositions[0]).equals(pCombination.get(paramPositions[1])) == pAreEqual;
    }

    private static int[] getPositionOfParams(String[] pOrdParam, List<Symbol> pConcreteParams) {
        boolean p1 = false, p2 = false;
        int p1pos = -1, p2pos = -1, i = 0;
        while(i < pOrdParam.length && (!p1 || !p2)) {
            if (!p1 && (pConcreteParams.get(0).getImage().equals(pOrdParam[i]))) {
                p1 = true;
                p1pos = i;
            } else if (!p2 && pConcreteParams.get(1).getImage().equals(pOrdParam[i])){
                p2 = true;
                p2pos = i;
            }
            i++;
        }
        return new int[]{p1pos, p2pos};
    }

    /**
     * Generates the variable of the precondition and adds it to the variable list.
     *
     * @param pExp Expresion of the type ATOM
     * @param pCombination Concrete combination of the parameters of the action.
     * @param pOrdParam Table of the order of the parameters in the combination.
     * @return The variable name.
     * @throws Exception
     */
    private static String generateVarPreOrEff(Exp pExp, List<Symbol> pCombination, String[] pOrdParam, ExpType pExpressionType) throws Exception {
        List<Symbol> listE = pExp.getAtom();
        // Patch for the negated expressions
        if (pExp.getConnective().equals(Connective.NOT)) {
            listE = pExp.getChildren().getFirst().getAtom();
        }
        StringBuilder var = new StringBuilder();
        var.append(listE.getFirst());
        for (int i = 1; i < listE.size(); i++) {
            // Appends the object which corresponds to the combinations and parameter.
            // Looks into the pOrdParam
            if (pExpressionType.equals(ExpType.GOAL) || pExpressionType.equals(ExpType.INIT)){
                var.append("__").append(listE.get(i).getImage());
            } else {
                String parName = listE.get(i).getImage();
                int j = lookForName(parName, pOrdParam);
                if (j >= 0)
                    var.append("__").append(pCombination.get(j).getImage());
                else
                    var.append("__").append(parName);
            }
        }
        String baseName = var.toString();
        int ttt;
        // For INIT, GOAL and EFFECT is 1.
        if (pExpressionType.equals(ExpType.PRECONDITION)){
            ttt = 0;
        }else{
            ttt = 1;
        }
        /*if (pExpressionType.equals(ExpType.EFFECT) || pExpressionType.equals(ExpType.GOAL) || pExpressionType.equals(ExpType.INIT)) {
            ttt = 1;
        }else{
            ttt = 0;
        }*/
        int tt = t-1+ttt;
        var.append("__").append(tt);
        // BECAUSE MAYBE IF THERE IS AN EQUALITY THAT VARIABLE DOES NOT EXIST
        // addVariable(var.toString(), false);
        return var.toString();
    }

    /**
     * Looks for the position of the variable name in the list.
     *
     * @param pVar The name of the variable in the preconditions.
     * @param pOrdParam The table which relates the name of the variables w/ the position in the combination.
     * @return The position of the pVar in the combination or -1 if it is a constant.
     */
    private static int lookForName(String pVar, String[] pOrdParam) throws Exception {
        for (int i = 0; i < pOrdParam.length; i++) {
            if (pVar.equals(pOrdParam[i])){
                return i;
            }
        }
        // If the parameter does not exist in the list, it is a constant.
        return -1;
    }

    /*
    private static void readExpression(Exp pExpression){
        List<String> variables = new ArrayList<>();
        if (pExpression.isLiteral()){
            if (pExpression.getConnective() == Connective.NOT){
                Exp nExp = new Exp(pExpression.getChildren().getFirst());
            }
        }else{
            switch (pExpression.getConnective()){
                case AND -> andExpression(pExpression.getChildren());
                case NOT -> notExpression(pExpression.getChildren());
            }
        }
    }



    private static void notExpression(List<Exp> pExpression) {

    }

    private static void andExpression(List<Exp> pExpression){

    }
*/

    /**
     * Given a list of parameters of an Action, returns for each parameter the possible objects that could activate
     * that action.
     *
     * @param pParametros A list of parameters of an action.
     * @return All the possible combinations of the objects for the activation of an Action.
     */
    private static List<List<Symbol>> generateCombinations(List<TypedSymbol> pParametros) {
        List<List<Symbol>> tabla = new ArrayList<>();
        for (TypedSymbol param: pParametros){
            //Symbol paramType = param.getTypes().getFirst();
            List<Symbol> obj = getParamTypeObjects(param);
            //List<Symbol> obj = tiposObjetos.get(paramType);
            tabla.add(obj);
        }
        return cartesianProduct(tabla);
    }

    private static List<Symbol> getParamTypeObjects(TypedSymbol pParametro) {
        List<String> tipos = new ArrayList<>();
        for (Symbol t: pParametro.getTypes())
            tipos.addAll(getAllTypesParam(t.getImage()));
        List<Symbol> objetos = new ArrayList<>();
        for (String t: tipos){
            Symbol s = new Symbol(Symbol.Kind.TYPE, t);
            List<Symbol> l = tiposObjetos.get(s);
            if (l != null)
                objetos.addAll(l);
        }
        return objetos;
    }

    private static List<String> getAllTypesParam(String pParamName) {
        TreeNode nodo = (DefaultMutableTreeNode) typesTree.getRoot();
        TreeNode nodoParam = getAllTypesParamSearch(pParamName, nodo);
        if (nodoParam == null) {
            return new ArrayList<>(Collections.singletonList(pParamName));
        }
        List<String> allTypesList = getAllTypesParamRec(nodoParam);
        // Include the declared type itself so objects typed directly at a non-leaf
        // supertype (e.g., object) are not lost in grounding.
        if (!allTypesList.contains(pParamName)) {
            allTypesList.add(pParamName);
        }
        return allTypesList;
    }

    private static TreeNode getAllTypesParamSearch(String pParamName, TreeNode nodo) {
        if (((DefaultMutableTreeNode)nodo).getUserObject().equals(pParamName)){
            return nodo;
        }
        for (int i = 0; i < nodo.getChildCount(); i++) {
            TreeNode n = getAllTypesParamSearch(pParamName, nodo.getChildAt(i));
            if (n != null)
                return n;
        }
        return null;
    }

    /**
     * From the nodo pNode return the name of all the leaves that hang from it.
     *
     * @param pNode of a tree.
     * @return all the leaves that hang from the node.
     */
    private static List<String> getAllTypesParamRec(TreeNode pNode) {
        int nChildren = pNode.getChildCount();
        if (nChildren == 0){
            return new ArrayList<>(Collections.singletonList((String) ((DefaultMutableTreeNode) pNode).getUserObject()));
        }
        List<String> l = new ArrayList<>();
        for (int i = 0; i < nChildren; i++) {
            List<String> l2 = getAllTypesParamRec(pNode.getChildAt(i));
            l.addAll(l2);
        }
        return l;
    }

    /**
     * Generates the cartesian product given a lists of lists.
     *
     * @param pLists A list of lists.
     * @return The cartesian product of the elements in the lists.
     */
    protected static <T> List<List<T>> cartesianProduct(List<List<T>> pLists) {
        List<List<T>> resultLists = new ArrayList<>();
        if (pLists.isEmpty()) {
            resultLists.add(new ArrayList<>());
            return resultLists;
        } else {
            List<T> firstList = pLists.getFirst();
            List<List<T>> remainingLists = cartesianProduct(pLists.subList(1, pLists.size()));
            for (T condition : firstList) {
                for (List<T> remainingList : remainingLists) {
                    ArrayList<T> resultList = new ArrayList<>();
                    resultList.add(condition);
                    resultList.addAll(remainingList);
                    resultLists.add(resultList);
                }
            }
        }
        return resultLists;
    }

    /**
     * This function adds the variable to the variable list if not, returns its numeric value.
     *
     * @param pVarName  A name of a variable.
     * @param pIsAction
     * @return the number of the variable.
     */
    private static Integer addVariable(String pVarName, boolean pIsAction){
        Integer varNum = variables.get(pVarName);
        if (varNum == null){
//            expression.add(new Integer[varNumber]);
            variables.put(pVarName, varNumber);
            variablesInv.put(varNumber, pVarName);
            if (pIsAction)
                System.out.println("c " + varNumber + " " + pVarName);
            else
                System.out.println("c " + varNumber + " #" + pVarName);
            varNum = varNumber;
            varNumber++;
        }
        return varNum;
    }

    private static void addAuxiliaryVariable(String pVarName){
        Integer varNum = variables.get(pVarName);
        if (varNum != null)
            throw new IllegalArgumentException("The variable " + pVarName + " already exists.");
        else {
            variables.put(pVarName, varNumber);
            variablesInv.put(varNumber, pVarName);
            System.out.println("c " + varNumber + " #" + pVarName);
            varNum = varNumber;
            varNumber++;
        }
    }

    private static void loadJsonData(String jsonFilePath) throws Exception {
        jsonAtoms = new HashSet<>();
        jsonStaticAtoms = new HashSet<>();
        jsonStaticPredicates = new HashSet<>();
        jsonOperators = new HashMap<>();
        String jsonContent = new String(Files.readAllBytes(Paths.get(jsonFilePath)));
        JsonReader jsonReader = Json.createReader(new StringReader(jsonContent));
        JsonObject jsonObject = jsonReader.readObject();
        jsonReader.close();

        JsonObject atomsJson = jsonObject.getJsonObject("atoms");
        if (atomsJson != null) {
            for (String pred : atomsJson.keySet()) {
                JsonArray instances = atomsJson.getJsonArray(pred);
                for (JsonValue val : instances) {
                    JsonArray args = (JsonArray) val;
                    List<String> argNames = new ArrayList<>();
                    for (JsonValue arg : args) {
                        argNames.add(arg.toString().replace("\"", ""));
                    }
                    jsonAtoms.add(buildBaseNameFromStrings(pred, argNames));
                }
            }
        }

        JsonArray staticArray = jsonObject.getJsonArray("static");
        if (staticArray != null) {
            for (JsonValue val : staticArray) {
                String atom = val.toString().replace("\"", "").trim();
                if (atom.isEmpty()) continue;
                String[] parts = atom.split("\\s+");
                String pred = parts[0];
                jsonStaticPredicates.add(pred);
                List<String> args = new ArrayList<>();
                for (int i = 1; i < parts.length; i++) args.add(parts[i]);
                jsonStaticAtoms.add(buildBaseNameFromStrings(pred, args));
            }
        }

        JsonObject operatorsJson = jsonObject.getJsonObject("operators");
        if (operatorsJson != null) {
            for (String opName : operatorsJson.keySet()) {
                JsonArray instances = operatorsJson.getJsonArray(opName);
                Set<String> allowed = new HashSet<>();
                for (JsonValue val : instances) {
                    JsonArray args = (JsonArray) val;
                    List<String> argNames = new ArrayList<>();
                    for (JsonValue arg : args) {
                        argNames.add(arg.toString().replace("\"", ""));
                    }
                    allowed.add(buildBaseNameFromStrings(opName, argNames));
                }
                jsonOperators.put(opName, allowed);
            }
        }
    }

    private static void generateJsonInertiaAxioms() {
        if (!useJsonFilter || !useInertia || allPredicateBaseNames == null) {
            return;
        }
        for (String baseName : allPredicateBaseNames) {
            if (isAtomAllowed(baseName)) {
                continue;
            }
            if (useInitPredicates && initPredicateBaseNames != null && initPredicateBaseNames.contains(baseName)) {
                continue;
            }
            for (int time = 1; time <= stepsTotal; time++) {
                String curr = baseName + "__" + time;
                String prev = baseName + "__" + (time - 1);
                expression.add(generateDimacsOr(Arrays.asList("! " + curr, prev), false));
                expression.add(generateDimacsOr(Arrays.asList(curr, "! " + prev), false));
            }
        }
    }

    private static boolean isAtomAllowed(String baseName) {
        if (!useJsonFilter) return true;
        return (jsonAtoms != null && jsonAtoms.contains(baseName))
                || (jsonStaticAtoms != null && jsonStaticAtoms.contains(baseName));
    }

    private static String baseNameFromTimedLiteral(String literal) {
        String name = isNegated(literal) ? literal.substring(2) : literal;
        int lastIdx = name.lastIndexOf("__");
        if (lastIdx < 0) return name;
        return name.substring(0, lastIdx);
    }

    private static Boolean evalStaticAtom(Exp e, List<Symbol> pCombination, String[] pOrdParam, ExpType pExpressionType) throws Exception {
        if (!useStaticPredicates || jsonStaticPredicates == null || jsonStaticPredicates.isEmpty()) {
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
        if (!jsonStaticPredicates.contains(predicate)) {
            return null;
        }
        StringBuilder key = new StringBuilder(predicate);
        for (int i = 1; i < atom.size(); i++) {
            String argName = atom.get(i).getImage();
            String argVal = argName;
            if (pExpressionType.equals(ExpType.GOAL) || pExpressionType.equals(ExpType.INIT)) {
                // Use names directly.
            } else {
                int j = lookForName(argName, pOrdParam);
                if (j >= 0) {
                    argVal = pCombination.get(j).getImage();
                }
            }
            if (argVal.startsWith("?")) {
                return null;
            }
            key.append("__").append(argVal);
        }
        return jsonStaticAtoms != null && jsonStaticAtoms.contains(key.toString());
    }

    private static boolean isActionInstanceAllowed(String actionName, List<Symbol> combination) {
        if (!useJsonFilter) return true;
        if (jsonOperators == null || jsonOperators.isEmpty()) return true;
        Set<String> allowed = jsonOperators.get(actionName);
        if (allowed == null) return false;
        String baseName = buildBaseName(actionName, combination);
        return allowed.contains(baseName);
    }

    private static String buildBaseName(String name, List<Symbol> symbols) {
        StringBuilder sb = new StringBuilder(name);
        for (Symbol s : symbols) {
            sb.append("__").append(s.getImage());
        }
        return sb.toString();
    }

    private static String buildBaseNameFromStrings(String name, List<String> args) {
        StringBuilder sb = new StringBuilder(name);
        for (String s : args) {
            sb.append("__").append(s);
        }
        return sb.toString();
    }

    private static void regenerateJsonFile(String domainPath, String problemPath, String outputFileName) {
        try {
            String scriptPath = resolveTranslateScriptPath();
            if (scriptPath == null) {
                System.err.println("c Error: Could not find run_translate_and_parse_sas.py");
                System.err.println("c Checked: ./run_translate_and_parse_sas.py and ./src/translate/run_translate_and_parse_sas.py (from current/parent directories)");
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
                    System.err.println("c Warning: Python script returned empty JSON.");
                }
            } else {
                System.err.println("c Error regenerating JSON (Exit Code " + exitCode + ")");
                System.err.println(errors.toString());
                System.exit(1);
            }
        } catch (Exception e) {
            System.err.println("c Error executing Python script: " + e.getMessage());
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

    private static void parseSilently(Parser parser, String domainPath, String problemPath) throws Exception {
        PrintStream originalOut = System.out;
        try {
            System.setOut(System.err);
            parser.parse(domainPath, problemPath);
        } finally {
            System.setOut(originalOut);
        }
    }
}
