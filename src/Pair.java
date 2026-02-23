/**
 * @class Pair
 * @brief A pair of objects
 *
 * @author mbofill
 * @date 2012-04-16
 */

public class Pair<S,T> {

    public S first;
    public T second;

    public Pair(S x, T y) {
	first = x;
	second = y;
    }

    public S getFirst(){
        return first;
    }

    public T getSecond(){
        return second;
    }

    @Override
    public String toString() {
	return "<" + first + "," + second + ">";
    }

}
