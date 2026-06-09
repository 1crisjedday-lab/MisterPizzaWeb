package dao;

import config.Conexion;
import modelos.Usuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAO {

    /**
     * Obtiene la lista completa de usuarios registrados en la base de datos,
     * ordenados por ID descendente.
     * 
     * @return Lista de objetos Usuario.
     */
    public List<Usuario> listarUsuarios() {
        List<Usuario> lista = new ArrayList<>();
        String sql = "SELECT id, nombre, correo, telefono, rol_id, fecha_registro FROM usuarios ORDER BY id DESC";
        
        try (Connection con = Conexion.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Usuario u = new Usuario();
                u.setId(rs.getInt("id"));
                u.setNombre(rs.getString("nombre"));
                u.setCorreo(rs.getString("correo"));
                u.setTelefono(rs.getString("telefono"));
                u.setRolId(rs.getInt("rol_id"));
                u.setFechaRegistro(rs.getTimestamp("fecha_registro"));
                lista.add(u);
            }
        } catch (SQLException e) {
            System.err.println("Error al listar usuarios: " + e.getMessage());
            e.printStackTrace();
        }
        return lista;
    }

    /**
     * Elimina un usuario de la base de datos por su ID.
     * Para mantener la integridad referencial sin generar excepciones,
     * primero desvincula los pedidos asociados a este usuario (pone usuario_id = NULL)
     * dentro de una transacción.
     * 
     * @param id Identificador único del usuario a eliminar.
     * @return true si la eliminación fue exitosa, false de lo contrario.
     */
    public boolean eliminarUsuario(int id) {
        String sqlUpdatePedidos = "UPDATE pedidos SET usuario_id = NULL WHERE usuario_id = ?";
        String sqlDeleteUsuario = "DELETE FROM usuarios WHERE id = ?";
        
        Connection con = null;
        PreparedStatement psUpdate = null;
        PreparedStatement psDelete = null;
        
        try {
            con = Conexion.getConnection();
            if (con == null) {
                return false;
            }
            // Iniciar transacción
            con.setAutoCommit(false);
            
            // 1. Desvincular pedidos del usuario
            psUpdate = con.prepareStatement(sqlUpdatePedidos);
            psUpdate.setInt(1, id);
            psUpdate.executeUpdate();
            
            // 2. Eliminar al usuario
            psDelete = con.prepareStatement(sqlDeleteUsuario);
            psDelete.setInt(1, id);
            int rowsDeleted = psDelete.executeUpdate();
            
            // Confirmar transacción
            con.commit();
            return rowsDeleted > 0;
            
        } catch (SQLException e) {
            System.err.println("Error al eliminar usuario con ID " + id + ": " + e.getMessage());
            e.printStackTrace();
            if (con != null) {
                try {
                    con.rollback();
                } catch (SQLException ex) {
                    System.err.println("Error al realizar rollback: " + ex.getMessage());
                }
            }
            return false;
        } finally {
            try {
                if (psUpdate != null) psUpdate.close();
                if (psDelete != null) psDelete.close();
                if (con != null) con.close();
            } catch (SQLException ex) {
                System.err.println("Error al cerrar recursos en eliminarUsuario: " + ex.getMessage());
            }
        }
    }
}
