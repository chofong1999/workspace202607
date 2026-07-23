package model;

public class User {
    private String name;
    private int age;
    private String email;
    private boolean active;
    
    public User() {}
    
    public User(String name, int age, String email, boolean active) {
        this.name = name;
        this.age = age;
        this.email = email;
        this.active = active;
    }
    
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    public int getAge() { return age; }
    public void setAge(int age) { this.age = age; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public boolean isActive() { return active; }
    public void setActive(boolean active) { this.active = active; }
    
    // 業務方法
    public boolean isAdult() {
        return age >= 18;
    }
    
    public String getStatus() {
        return active ? "啟用" : "停用";
    }
    
    public String getGreeting() {
        return "您好，我是 " + name + "！";
    }
}