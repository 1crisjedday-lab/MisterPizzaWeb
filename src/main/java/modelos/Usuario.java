package modelos;

public class Usuario {
    
    private int id;
    private String nombre;
    private String correo;
    private int rol_id;

    // 1. Constructor vacío (Obligatorio para que no te dé el error "no arguments")
    public Usuario() {
    }

    // 2. Constructor con parámetros (El que ya tenías y Java estaba pidiendo)
    public Usuario(int id, String nombre, String correo, int rol_id) {
        this.id = id;
        this.nombre = nombre;
        this.correo = correo;
        this.rol_id = rol_id;
    }

    // 3. Métodos Getters y Setters (Obligatorios para leer y escribir datos)
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public int getRolId() {
        return rol_id;
    }

    public void setRolId(int rol_id) {
        this.rol_id = rol_id;
    }
}