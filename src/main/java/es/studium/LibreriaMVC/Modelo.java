package es.studium.LibreriaMVC;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.sql.DataSource;

public class Modelo {
	
	static Connection conn = null;
	static Statement statement = null;
	private static DataSource pool;
	public static void conectar() throws ServletException
	{
		try
		{
			// Crea un contexto para poder luego buscar el recurso DataSource
			InitialContext ctx = new InitialContext();
			// Busca el recurso DataSource en el contexto
			pool = (DataSource)ctx.lookup("java:comp/env/jdbc/mysql_tiendalibros");
			if(pool == null)
			{
				throw new ServletException("DataSource desconocida mysql_tiendalibros'");
			} else {
				try {
					conn = pool.getConnection();
					statement = conn.createStatement();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					System.out.println(e.toString());
				}
			}
			
		}
		catch(NamingException ex){}
		
		
	}
	public DataSource getPool() {
		return pool;
	}
	public static void cerrarConexion() {
		try
		{
			// Cerramos el resto de recursos
			if(statement != null)
			{
				statement.close();
			}
			if(conn != null)
			{
				conn.close();
			}
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
	}
}
