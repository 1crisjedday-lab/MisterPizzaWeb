package servlets;

import config.Conexion;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet(name = "GestorProductosServlet", urlPatterns = {"/GestorProductosServlet"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 10)
public class GestorProductosServlet extends HttpServlet {

    // RUTA BLINDADA: Aquí las imágenes se guardarán físicamente en tu código fuente
    private static final String RUTA_PERMANENTE_PC = "C:\\Users\\USUARIO\\Documents\\9no semestre\\taller de desarrollo de sotware\\MisterPizzaWeb\\MisterPizzaWeb\\src\\main\\webapp\\img";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        
        String idStr = request.getParameter("id_producto");
        String nombre = request.getParameter("nombre");
        String precioStr = request.getParameter("precio");
        String ingredientes = request.getParameter("ingredientes");
        String categoria = request.getParameter("categoria");
        
        String urlWeb = request.getParameter("imagen_url_web");

        Part filePart = null;
        try {
            filePart = request.getPart("imagen_foto"); 
        } catch (Exception e) { }
        
        boolean hayNuevaImagen = filePart != null && filePart.getSize() > 0;
        String imagenUrlFinal = "img/default.png";

        if (urlWeb != null && !urlWeb.trim().isEmpty()) {
            imagenUrlFinal = urlWeb.trim();
        } else if (hayNuevaImagen) {
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            fileName = System.currentTimeMillis() + "_" + fileName.replaceAll(" ", "_");
            
            // 1. Ruta temporal de Tomcat
            String tempPath = getServletContext().getRealPath("") + File.separator + "img";
            File tempDir = new File(tempPath);
            if (!tempDir.exists()) tempDir.mkdir();
            String finalFileTemp = tempPath + File.separator + fileName;
            filePart.write(finalFileTemp);
            
            // 2. Copia de seguridad a la carpeta fuente permanente
            try {
                File permDir = new File(RUTA_PERMANENTE_PC);
                if (!permDir.exists()) permDir.mkdirs();
                
                String finalFilePerm = RUTA_PERMANENTE_PC + File.separator + fileName;
                Files.copy(Paths.get(finalFileTemp), Paths.get(finalFilePerm), StandardCopyOption.REPLACE_EXISTING);
                System.out.println("Imagen guardada en: " + finalFilePerm);
            } catch(Exception e) {
                System.err.println("Error copiando imagen: " + e.getMessage());
            }

            imagenUrlFinal = "img/" + fileName;
        }

        try (Connection con = Conexion.getConnection()) {
            if (idStr == null || idStr.isEmpty()) {
                String sql = "INSERT INTO pizzas (nombre, precio, ingredientes, imagen_url, categoria) VALUES (?, ?, ?, ?, ?)";
                try (PreparedStatement ps = con.prepareStatement(sql)) {
                    ps.setString(1, nombre);
                    ps.setDouble(2, Double.parseDouble(precioStr));
                    ps.setString(3, ingredientes);
                    ps.setString(4, imagenUrlFinal);
                    ps.setString(5, categoria); 
                    ps.executeUpdate();
                }
            } else {
                int id = Integer.parseInt(idStr);
                String sql;
                PreparedStatement ps;

                boolean actualizaImagen = (urlWeb != null && !urlWeb.trim().isEmpty()) || hayNuevaImagen;

                if (actualizaImagen) {
                    sql = "UPDATE pizzas SET nombre=?, precio=?, ingredientes=?, imagen_url=?, categoria=? WHERE id=?";
                    ps = con.prepareStatement(sql);
                    ps.setString(1, nombre);
                    ps.setDouble(2, Double.parseDouble(precioStr));
                    ps.setString(3, ingredientes);
                    ps.setString(4, imagenUrlFinal);
                    ps.setString(5, categoria); 
                    ps.setInt(6, id);
                } else {
                    sql = "UPDATE pizzas SET nombre=?, precio=?, ingredientes=?, categoria=? WHERE id=?";
                    ps = con.prepareStatement(sql);
                    ps.setString(1, nombre);
                    ps.setDouble(2, Double.parseDouble(precioStr));
                    ps.setString(3, ingredientes);
                    ps.setString(4, categoria); 
                    ps.setInt(5, id);
                }
                ps.executeUpdate();
                ps.close();
            }
            response.sendRedirect("admin_productos.jsp");
        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
            response.sendRedirect("admin_productos.jsp?error=true");
        }
    }
}