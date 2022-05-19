package es.studium.LibreriaMVC;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Login
 */
@WebServlet("/LoginServlet")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Login() {
		super();
	}

	
	private String nextPage = "";
	
	public static final int LOGIN_NOERROR = -1;
	
	public static final int LOGIN_ERROR_NULLUSER = 0;
	public static final int LOGIN_ERROR_EMPTYUSER = 1;
	public static final int LOGIN_ERROR_NULLPSWD = 2;
	public static final int LOGIN_ERROR_EMPTYPSWD = 3;
	public static final int LOGIN_ERROR_WRONG_LOG = 4;
	
	public static final int CONNECTION_ERROR = 5;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		Modelo.conectar();
		HttpSession session = request.getSession(false);


		// Recuperar los parámetros usuario y password de la petición request
		String user = request.getParameter("username");
		String password = request.getParameter("password");

		boolean error = false;
		if(user == null) {
			error = true;
			session.setAttribute("login-msg", LOGIN_ERROR_NULLUSER);
		} 
		if(user.length()==0)
		{
			error = true;
			session.setAttribute("login-msg", LOGIN_ERROR_EMPTYUSER);
		}
		if(password == null) {
			error = true;
			session.setAttribute("login-msg", LOGIN_ERROR_NULLPSWD);
		} 
		if(password.length()==0)
		{
			error = true;
			session.setAttribute("login-msg", LOGIN_ERROR_EMPTYPSWD);
		}

		

		if(!error) {
			try {
				login(request,response, user, password, session);
			} catch (SQLException e) {
				nextPage = "./login.jsp";
				System.out.println(e.getMessage());
				session.setAttribute("login-msg", CONNECTION_ERROR);
			}
		}
		
		System.out.println(nextPage);
		response.sendRedirect(nextPage);


	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		//doPost(request, response);
	}


	private void login(HttpServletRequest request, HttpServletResponse response, String usuario, String password, HttpSession session) throws SQLException {
		// Verificar que existe el usuario y su correspondiente clave
		String query = "SELECT * FROM usuarios WHERE STRCMP(usuarios.nombreUsuario,'"+usuario+"') = 0 AND STRCMP(usuarios.claveUsuario, MD5('"+password+"')) = 0";

		try {
			Modelo.conectar();
		
			if(Modelo.statement != null) {
				ResultSet resultSet = Modelo.statement.executeQuery(query);
				if(!resultSet.next())
				{
					// Si el resultset está vacío, no hay coincidencias
					session.removeAttribute("usuario");
					session.setAttribute("login-msg", LOGIN_ERROR_WRONG_LOG);
				}
				else
				{
					// Si los datos introducidos son correctos
					synchronized(session)
					{
						
						int privileges = resultSet.getInt("privilegiosUsuario");
						nextPage = (privileges==0) ? "./manager.jsp" : "./shopping";
						
						session.setAttribute("usuario", usuario);
						session.setAttribute("privileges", privileges);
						session.setAttribute("userid", resultSet.getInt("idUsuario"));
						session.setAttribute("login-msg", LOGIN_NOERROR);
		
					}
		
				}
			} else {
				session.setAttribute("login-msg", CONNECTION_ERROR);
			}
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
