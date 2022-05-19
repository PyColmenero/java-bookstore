package es.studium.LibreriaMVC;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.ServletException;

/**
 * Servlet implementation class ModeloAutores
 */
public class AutoresControlador  {

	
	public static ArrayList<Autor> getAutores() throws ServletException {
		
		ArrayList<Autor> listautores = new ArrayList<Autor>();
		
		
		
		try {
			// Creamos objetos para la conexión
			Modelo.conectar();
			
			// Paso 4: Ejecutar las sentencias
			String query = "SELECT * FROM autores ORDER BY apellidosAutor, nombreAutor;";
			ResultSet rs = Modelo.statement.executeQuery(query);
			Autor autor;
			while(rs.next())
			{
				autor = new Autor(	rs.getInt("idAutor"), 
									rs.getString("nombreAutor"), 
									rs.getString("apellidosAutor")	);
				listautores.add(autor);
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
		
		
		return listautores;
	}
	
}
