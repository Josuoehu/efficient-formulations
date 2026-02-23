

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class GeneratePlan {
    private List<String> variableNames;
    private String variablesNameDir;
    private String satModelDir;

    public GeneratePlan(String pVariablesNameDir, String pSatModelDir){
        variableNames = new ArrayList();
        variablesNameDir = pVariablesNameDir;
        satModelDir = pSatModelDir;
    }

    private void parseVariablesNames() {
        try (BufferedReader reader = new BufferedReader(new FileReader(variablesNameDir))) {
            String line;
            while ((line = reader.readLine()) != null && line.substring(0, 2).equals("c ")) {
                variableNames.add(line.split("\s")[2]);
            }
        } catch (IOException e) {
            System.err.println("Error parsing file.");
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void parseModel(){
        try (BufferedReader reader = new BufferedReader(new FileReader(satModelDir))) {
            String line;
            boolean cent = true;
            int i = 0;
            while ((line = reader.readLine()) != null && cent) {
                if (i == 0 && !(line.equals("SAT"))){
                    System.err.println("The result of the model file is UNSAT");
                    cent = false;
                }
                else if (i != 0){
                    // Obtain the model in an array
                    String[] model = line.split("\s");
                    for(String number: model){
                        Integer var = Integer.valueOf(number);
                        // Check if the true variables
                        if (var > 0){
                            String varName = variableNames.get(var - 1);
                            // Check if is an action variable
                            if (!(varName.charAt(0) == '#')){
                                String[] separation = varName.split("__");
                                // Print the action in the correct way
                                System.out.print("(");
                                int j = 0;
                                for(String sep: separation){
                                    if (j == separation.length - 2){
                                        System.out.print(sep);
                                        break;
                                    }
                                    System.out.print(sep + " ");
                                    j++;
                                }
                                System.out.println(")");
                            }
                        }
                    }
                }
                i++;
            }
        } catch (IOException e){
            e.printStackTrace();
        }
    }

    public void generateSolPlan(){
        parseVariablesNames();
        parseModel();
    }

    public static void main(String[] args){
        GeneratePlan plan = new GeneratePlan("/home/josu/Documents/PDDL2SAT/pddl-parser/socks4_new.dimacs", "/home/josu/Documents/PDDL2SAT/pddl-parser/result.txt");
        plan.generateSolPlan();
    }
}

