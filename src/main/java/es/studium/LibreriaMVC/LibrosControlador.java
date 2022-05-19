package es.studium.LibreriaMVC;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class ModeloLibros
 */
@WebServlet("/LibrosControlador")
public class LibrosControlador extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LibrosControlador() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession(true);
		String todo = request.getParameter("todo");
		
		if(todo.equals("new")) {
			// datos del formulario
			String nombreLibro = request.getParameter("nombreLibro");
			String cantidadLibro = request.getParameter("cantidadLibro");
			String precioLibro = request.getParameter("precioLibro");
			String idAutorFK = request.getParameter("idAutorFK");
			String idEditorialFK = request.getParameter("idEditorialFK");
			
			String query = "INSERT INTO libros VALUES(NULL,'"+nombreLibro+"', "+cantidadLibro+", "+precioLibro+", "+idAutorFK+", "+idEditorialFK+")";
			
			int error = insert(query);
			if(error==1) {
				session.setAttribute("response", "Libro '" + nombreLibro + "' creado correctamente.");
			} else {
				session.setAttribute("response", "Error al crear el libro.");
			}

			// redirección
			try {
				response.sendRedirect(request.getContextPath() + "/libros.jsp");
			} catch (IOException e) {
				e.printStackTrace();
			}
				
		} else if(todo.equals("edit")) {
			
			// datos del formylario
			String id = request.getParameter("id");
			String idAutorLibroFK = request.getParameter("idAutorLibroFK");
			String nombreLibro = request.getParameter("nombreLibro");
			String cantidadLibro = request.getParameter("cantidadLibro");
			String precioLibro = request.getParameter("precioLibro");
			String idEditorialFK = request.getParameter("idEditorialFK");

			String query = "UPDATE libros SET nombreLibro = '"+nombreLibro+"'";
			query += ", cantidadLibro = " + cantidadLibro;
			query += ", precioLibro = " + precioLibro;
			query += ", idAutorFK = " + idAutorLibroFK;
			query += ", idEditorialFK = " + idEditorialFK;
			query += " WHERE idLibro = "+ id;
						
			int error = update(query);
			if(error==1) {
				session.setAttribute("response", "Libro editado correctamente.");
			} else {
				session.setAttribute("response", "Error al editar libro.");
			}

			// redirección
			try {
				response.sendRedirect(request.getContextPath() + "/libros.jsp");
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	static ArrayList<Libro> listalibros = new ArrayList<Libro>();
	
	public static void cargarLibros() throws ServletException
	{

		listalibros.clear();
		
		try {
			
			Modelo.conectar();
			
			// Paso 4: Ejecutar las sentencias
			String query = "SELECT idLibro, nombreLibro, cantidadLibro, precioLibro, idAutorFK, idEditorialFK, autor.nombreAutor, editorial.nombreEditorial FROM libros JOIN autores AS autor ON idAutorFK = autor.idAutor JOIN editoriales AS editorial ON idEditorialFK = editorial.idEditorial ORDER BY idLibro;";
			ResultSet rs = Modelo.statement.executeQuery(query);
			Libro libro;
			while(rs.next())
			{
				libro = new Libro(	rs.getInt("idLibro"), 
									rs.getString("nombreLibro"), 
									rs.getInt("cantidadLibro"), 
									rs.getDouble("precioLibro"), 
									rs.getInt("idAutorFK"), 
									rs.getString("autor.nombreAutor"), 
									rs.getInt("idEditorialFK"), 
									rs.getString("editorial.nombreEditorial")	);
				listalibros.add(libro);
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
	}

	public static ArrayList<Libro> getListaLibros() {
		try {
			cargarLibros();
			return listalibros;
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
		
	}
	
	
	private int insert(String sentencia) throws ServletException {
			
		int error = 0;
		try {
			Modelo.conectar();
			error =  Modelo.statement.executeUpdate(sentencia);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			Modelo.cerrarConexion();
		}
		
		return error;
		
	}
	
	private int update(String sentencia) throws ServletException {
		
		int error = 0;
		try {
			Modelo.conectar();
			error =  Modelo.statement.executeUpdate(sentencia);
            
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			Modelo.cerrarConexion();
		}
		
		return error;
		
	}
	
	
	/*public static int getRsLength(ResultSet rs) throws SQLException {

		int rows = 0;
		if (rs.last()) {
		    rows = rs.getRow();
		    rs.first();
		}
		System.out.println(rows);
		return rows;

	}*/
	
	/*
		
	public static String[][] getLibros() throws ServletException {
		
		connections = new Connections();
		connections.connect2();
		try {
			conn = connections.getPool().getConnection();
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
			String query = "SELECT idLibro, nombreLibro, cantidadLibro, precioLibro, autores.nombreAutor, editoriales.nombreEditorial FROM libros JOIN autores ON idAutorLibroFK = autores.idAutor JOIN editoriales ON idEditorialFK = editoriales.idEditorial ORDER BY idLibro;";
			rs = stmt.executeQuery(query);
			int length = getRsLength(rs);
			String[][] libros = new String[length][6];
			for(int x = 0; x < length; x++) {
				libros[x][0] = rs.getString("autores.nombreAutor");
				libros[x][1] = rs.getString("nombreLibro");
				libros[x][2] = rs.getString("cantidadLibro");
				libros[x][3] = rs.getString("precioLibro");
				libros[x][4] = rs.getString("idLibro");
				libros[x][5] = rs.getString("editoriales.nombreEditorial");
				rs.next();
			}
			System.out.println( length );
			return libros;
		} catch (SQLException e) {

			e.printStackTrace();
			return null;
		}
		
	}*/
	
}
