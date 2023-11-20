public class HashCodeDemo {
    
    Map<Integer,String> mapValues = new Map<Integer,String>();
    String demoHashCode;
    integer hashCodeValues;
    integer hashCodeStringValues;
    
   
    public void run(){
        
        mapValues.put(100, 'value1');
        mapValues.put(101, 'value2');
        mapValues.put(102, 'value3');
        mapValues.put(103, 'value4');
        mapValues.put(104, '11');
        mapValues.put(105, '22');
        
        demoHashCode='new values';
        
        hashCodeStringValues=demoHashCode.hashCode();
        hashCodeValues=mapValues.hashCode();
        
        system.debug('HashCode Map :: '+hashCodeValues+'  HashCode String :: '+hashCodeStringValues);
    }
    
    
    public static void numberOfOccurrence(String input) {
        String sentence = 'apple mango apple orange apple ';
        Integer match=sentence.countMatches(input);
        system.debug('M  '+match);
    }
    
    @InvocableMethod
    Public static void testFutureWithFlow(List<Account> accList){
        
    }
}