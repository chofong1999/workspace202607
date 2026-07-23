package model;
import java.sql.*;
import java.util.*;
public class EmployeeDAO {
   Connection create() {
	  String url="jdbc:mysql://localhost:3306/classicmodels";
	  String user="root";
	  String password="1234";
	  try {
		 Class.forName("com.mysql.cj.jdbc.Driver"); 
		 Connection cn= DriverManager.getConnection(url, user, password);
		 return cn;
	  }catch(Exception ex) {
		  System.out.println("Connection error "+ex.getMessage());
	  }
	  return null;
   }
   public List<Employee> execGetEmpInOffice(String city){
	   Connection cn=create();
	   if(cn==null) return new ArrayList<Employee>();
	   try {
		 CallableStatement st=cn.prepareCall("call classicmodels.GetEmpInOffice(?)");
		 st.setString(1, city);
		 ResultSet rs=st.executeQuery();
		 List<Employee> data=new ArrayList<>();
		 while(rs.next()) {
		    Employee e1=new Employee();
		    int no=rs.getInt("employeeNumber");
		    String fn=rs.getString("firstName");
		    String ln=rs.getString("lastName");
		    String ex=rs.getString("extension");
		    String em=rs.getString("email");
		    String code=rs.getString("officeCode");
		    int rpt=rs.getInt("reportsTo");
		    String job=rs.getString("jobTitle");
		    e1.setEmployeeNumber(no);
		    e1.setFirstName(fn);
		    e1.setLastName(ln);
		    e1.setExtension(ex);
		    e1.setEmail(em);
		    e1.setOfficeCode(code);
		    e1.setReportsTo(rpt);
		    e1.setJobTitle(job);
		    data.add(e1);
		 }
		 return data;
	   }catch(Exception ex) {
		   System.out.println("execGetEmpInOffice error "+ex.getMessage());
	   }
	   return new ArrayList<Employee>();
   }
   public int execGetEmpCountInOffice(String city) {
	   Connection cn=create();
	   if(cn==null) return -1;
	   try {
		   CallableStatement st=cn.prepareCall("call classicmodels.GetEmpCountInOffice(?,?)");
		   st.setString(1, city);
		   st.registerOutParameter(2, Types.INTEGER);
		   st.execute();
		   return st.getInt(2);
	   }catch(Exception ex) {
		   System.out.println("execGetEmpCountInOffice error "+ex.getMessage());
	   }
	   return -1;
   }
}
