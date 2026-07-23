package model;



public class ProductBean {
    private int id;
    private String name;
    private double price;
    private int stock;
    
    public ProductBean() {}
    
    public ProductBean(int id, String name, double price, int stock) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.stock = stock;
    }
    
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    
    public int getStock() { return stock; }
    public void setStock(int stock) { this.stock = stock; }
    
    // 業務方法
    public String getStockStatus() {
        if (stock == 0) return "缺貨";
        if (stock <= 5) return "庫存不足";
        return "現貨";
    }
}
