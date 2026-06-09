package modelos;

import java.sql.Timestamp;

public class Usuario {
    
    private int id;
    private String nombre;
    private String correo;
    private String telefono;
    private int rol_id;
    private Timestamp fecha_registro;

    // 1. Constructor vacío (Obligatorio para que no te dé el error "no arguments")
    public Usuario() {
    }

    // 2. Constructor original con parámetros
    public Usuario(int id, String nombre, String correo, int rol_id) {
        this.id = id;
        this.nombre = nombre;
        this.correo = correo;
        this.rol_id = rol_id;
    }

    // 3. Constructor completo con nuevos parámetros
    public Usuario(int id, String nombre, String correo, String telefono, int rol_id, Timestamp fecha_registro) {
        this.id = id;
        this.nombre = nombre;
        this.correo = correo;
        this.telefono = telefono;
        this.rol_id = rol_id;
        this.fecha_registro = fecha_registro;
    }

    // 4. Métodos Getters y Setters
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

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public int getRolId() {
        return rol_id;
    }

    public void setRolId(int rol_id) {
        this.rol_id = rol_id;
    }

    public Timestamp getFechaRegistro() {
        return fecha_registro;
    }

    public void setFechaRegistro(Timestamp fecha_registro) {
        this.fecha_registro = fecha_registro;
    }
}