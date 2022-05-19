package es.studium.LibreriaMVC;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.ServletException;

public class EditorialesControlador  {
	
	public static ArrayList<Editorial> getEditoriales() throws ServletException {
		
		ArrayList<Editorial> listaeditoriales = new ArrayList<Editorial>();
		
		// Creamos objetos para la conexión
		Modelo.conectar();
		
		try {
			
			// Paso 4: Ejecutar las sentencias
			String query = "SELECT * FROM editoriales ORDER BY nombreEditorial;";
			ResultSet rs = Modelo.statement.executeQuery(query);
			Editorial editorial;
			while(rs.next())
			{
				editorial = new Editorial(	rs.getInt("idEditorial"), 
											rs.getString("nombreEditorial"));
				listaeditoriales.add(editorial);
			}
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		finally
		{
			Modelo.cerrarConexion();
		}
		
		
		return listaeditoriales;
	}
	
}
