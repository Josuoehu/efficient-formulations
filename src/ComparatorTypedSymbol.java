

import fr.uga.pddl4j.parser.Symbol;
import fr.uga.pddl4j.parser.TypedSymbol;

import java.util.Comparator;
import java.util.List;

public class ComparatorTypedSymbol implements Comparator<TypedSymbol> {

    @Override
    public int compare(TypedSymbol o1, TypedSymbol o2) {
        List<Symbol> tipos1 = o1.getTypes();
        List<Symbol> tipos2 = o2.getTypes();
        if (tipos2.isEmpty()) {
            return 1;
        } else if (tipos1.isEmpty()) {
            return -1;
        } else {
            int i = 0;
            while (i < tipos2.size() & i < tipos1.size()) {
                String nameT1 = tipos1.get(i).getImage();
                String nameT2 = tipos2.get(i).getImage();
                if (nameT1.equals("object"))
                    return -1;
                if (nameT2.equals("object"))
                    return 1;
                int comp = tipos1.get(i).getImage().compareTo(tipos2.get(i).getImage());
                if (comp != 0)
                    return comp;
                i++;
            }
            return 0;
        }
    }
}
