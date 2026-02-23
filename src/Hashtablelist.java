


import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

public class Hashtablelist<K, V> extends Hashtable<K, List<V>> implements Map<K, List<V>> {
    public void putSingle(K key, V value) {
        if (!containsKey(key))
            put(key, new ArrayList<>(){{add(value);}});
        else{
            get(key).add(value);
        }
    }
    public List<V> getValues(K key){
        return get(key);
    }
}
