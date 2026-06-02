package modelos;

public class Pizza {
    private int id;
    private String nombre;
    private String ingredientes;
    private double precio;
    private String imagenUrl;
    
    // 1. NUEVA VARIABLE: Categoría
    private String categoria; 

    // Constructor completo (NUEVO - Incluye categoría)
    public Pizza(int id, String nombre, String ingredientes, double precio, String imagenUrl, String categoria) {
        this.id = id;
        this.nombre = nombre;
        this.ingredientes = ingredientes;
        this.precio = precio;
        this.imagenUrl = imagenUrl;
        this.categoria = categoria;
    }

    // Constructor original (Mantenido para que tu código anterior no arroje errores 500)
    public Pizza(int id, String nombre, String ingredientes, double precio, String imagenUrl) {
        this.id = id;
        this.nombre = nombre;
        this.ingredientes = ingredientes;
        this.precio = precio;
        this.imagenUrl = imagenUrl;
        this.categoria = "Pizzas Clásicas"; // Valor por defecto seguro
    }

    // Getters originales
    public int getId() { return id; }
    public String getNombre() { return nombre; }
    public String getIngredientes() { return ingredientes; }
    public double getPrecio() { return precio; }
    public String getImagenUrl() { return imagenUrl; }
    
    // 2. NUEVOS MÉTODOS para la categoría
    public String getCategoria() { return categoria; }
    public void setCategoria(String categoria) { this.categoria = categoria; }
}