/**
 * @class ComparableExp
 * @author Miquel Bofill
 * @version 2016.04.13
 *
 * @brief Comparable PDDL4J expression
 */

import fr.uga.pddl4j.parser.*;
import java.util.List;
import java.util.LinkedList;
import java.util.Iterator;

public class ComparableExp extends Exp implements Comparable<ComparableExp> {

    public ComparableExp(final Exp other) {
	super(other);
    }

    public ComparableExp(Connective c) {
	super(c);
    }

    @Override
    public int compareTo(ComparableExp e) {
	    return this.toString().compareTo(e.toString());
    }

//     @Override
//    public int compareTo(ComparableExp e) {
//        if (e.getConnective().equals(Connective.ATOM) && this.getConnective().equals(Connective.ATOM)){
//            if (e.getAtom().getFirst().equals(this.getAtom().getFirst())){
//                return e.getAtom().size() - this.getAtom().size();
//            } else {
//                return this.getAtom().getFirst().toString().compareTo(e.getAtom().getFirst().toString());
//            }
//        } else if (e.getConnective().equals(Connective.NOT) && this.getConnective().equals(Connective.NOT)){
//            Exp e1 = e.getChildren().getFirst();
//            Exp e2 = this.getChildren().getFirst();
//            if (e1.getAtom().getFirst().equals(e2.getAtom().getFirst())){
//                return e1.getAtom().size() - e2.getAtom().size();
//            } else {
//                return e2.getAtom().getFirst().toString().compareTo(e1.getAtom().getFirst().toString());
//            }
//        }else{
//            return this.toString().compareTo(e.toString());
//        }
//    }

//    @Override
//    public boolean equals(Object object) {
//       if (object instanceof ComparableExp){
//           return ((ComparableExp) object).getConnective().equals(this.getConnective()) && this.getChildren().size() == ((ComparableExp) object).getChildren().size();
//       } else {
//           return false;
//       }
//    }
}

