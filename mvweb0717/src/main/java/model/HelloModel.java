package model;
import java.util.*;
public class HelloModel {
    Map<String,String> model=new HashMap<>();
    public HelloModel() {
    	   model.put("Mary", "Good Day");
    	   model.put("Janet", "Hi");
    	   model.put("Alan", "Good Afternoon");    	   
    }
    
    public String says(String n) {
    	    String greet=model.get(n);
    	    return "Your Name is "+n + " says "+greet;
    }
}
