package modelos;

public class ItemCarrito {
    private String nombre;
    private String descripcion;
    private double precio;
    private int cantidad;

    public ItemCarrito() {}

    public ItemCarrito(String nombre, String descripcion, double precio, int cantidad) {
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.precio = precio;
        this.cantidad = cantidad;
    }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }

    public double getPrecio() { return precio; }
    public void setPrecio(double precio) { this.precio = precio; }

    public int getCantidad() { return cantidad; }
    public void setCantidad(int cantidad) { this.cantidad = cantidad; }
    
    // Calcula el subtotal de este ítem
    public double getSubtotal() { return precio * cantidad; }
}