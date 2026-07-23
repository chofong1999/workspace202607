package model;
//Entity class
public class Employee {
   int employeeNumber;
   String firstName;
   String lastName;
   String extension;
   String email;
   String officeCode;
   int reportsTo;
   String jobTitle;
   public Employee() {	
   }
   public Employee(int employeeNumber, String firstName, String lastName, String extension, String email,
		String officeCode, int reportsTo, String jobTitle) {	
	this.employeeNumber = employeeNumber;
	this.firstName = firstName;
	this.lastName = lastName;
	this.extension = extension;
	this.email = email;
	this.officeCode = officeCode;
	this.reportsTo = reportsTo;
	this.jobTitle = jobTitle;
   }
   public int getEmployeeNumber() {
	return employeeNumber;
   }
   public void setEmployeeNumber(int employeeNumber) {
	this.employeeNumber = employeeNumber;
   }
   public String getFirstName() {
	return firstName;
   }
   public void setFirstName(String firstName) {
	this.firstName = firstName;
   }
   public String getLastName() {
	return lastName;
   }
   public void setLastName(String lastName) {
	this.lastName = lastName;
   }
   public String getExtension() {
	return extension;
   }
   public void setExtension(String extension) {
	this.extension = extension;
   }
   public String getEmail() {
	return email;
   }
   public void setEmail(String email) {
	this.email = email;
   }
   public String getOfficeCode() {
	return officeCode;
   }
   public void setOfficeCode(String officeCode) {
	this.officeCode = officeCode;
   }
   public int getReportsTo() {
	return reportsTo;
   }
   public void setReportsTo(int reportsTo) {
	this.reportsTo = reportsTo;
   }
   public String getJobTitle() {
	return jobTitle;
   }
   public void setJobTitle(String jobTitle) {
	this.jobTitle = jobTitle;
   }
   @Override
   public String toString() {
	return "Employee [employeeNumber=" + employeeNumber + ", firstName=" + firstName + ", lastName=" + lastName
			+ ", extension=" + extension + ", email=" + email + ", officeCode=" + officeCode + ", reportsTo="
			+ reportsTo + ", jobTitle=" + jobTitle + "]";
   }
   
   
   
}
