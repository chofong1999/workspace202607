package model;


public class User2 {
    private String name;
    private int age;
    private String email;
    private boolean active;
    
    public User2() {}
    
    public User2(String name, int age, String email, boolean active) {
        this.name = name;
        this.age = age;
        this.email = email;
        this.active = active;
    }
    
    // Getter 方法
    public String getName() { return name; }
    public int getAge() { return age; }
    public String getEmail() { return email; }
    public boolean isActive() { return active; }
    
    // Setter 方法
    public void setName(String name) { this.name = name; }
    public void setAge(int age) { this.age = age; }
    public void setEmail(String email) { this.email = email; }
    public void setActive(boolean active) { this.active = active; }
    
    // 業務方法
    public boolean isAdult() {
        return age >= 18;
    }
    
    public String getStatus() {
        return active ? "啟用" : "停用";
    }
}
