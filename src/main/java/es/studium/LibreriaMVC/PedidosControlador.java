package es.studium.LibreriaMVC;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class PedidosControlador
 */
@WebServlet("/PedidosControlador")
public class PedidosControlador extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PedidosControlador() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		HttpSession session = request.getSession(true);
		String todo = request.getParameter("todo");
		String respuesta = "";

		int userid = 0;
		String username = (String) session.getAttribute("usuario");
		if(username!=null) {
			
			userid = (int) session.getAttribute("userid");

			if(todo.equals("add")) {

				ArrayList<ElementoPedido> cesta = (ArrayList<ElementoPedido>) session.getAttribute("carrito");

				Double random = ((Math.random()*8999999)+1000000);
				int idPedido = random.intValue();


				if (cesta != null && cesta.size() > 0) {

					int restas = 0; // cuantas veces ha restado, osea que ha habido suficiente stock
					for (int i = 0; i < cesta.size(); i++) { // por cada LIBRO del pedido

						ElementoPedido elementoPedido = cesta.get(i); // current libro pedido

						// datos de este
						int cantidadLibrosPedido = elementoPedido.getCantidad();
						int idLibro = elementoPedido.getIdLibro();
						int cantidadLibrosBBDD = cantidadLibros(idLibro);
						int quedanLibros = cantidadLibrosBBDD - cantidadLibrosPedido;
						String titulo = elementoPedido.getTitulo();
						
						
						if(quedanLibros >= 0) { // si hay suficientes librosss
							// restamos dicha cantidad a la base de datos

							int error = restarLibros(idLibro,quedanLibros);

							if(error == 1) {
								//respuesta += "Restado</br>";
								restas++;

								// insertar LibroPedido
								int error1 = insertarLibroPedido(idPedido, idLibro, cantidadLibrosPedido);
								if(error1 == 1) {
									respuesta += "<span class='text-success'>Libro '"+titulo+"' pedido correctamente.</span></br>";
								} else {
									respuesta += "<span class='text-danger'>Error insertado LibroPedido</span></br>";
								}
							} else {
								//respuesta += "Error restando</br>";
							}
						} else {
							respuesta += "<span class='text-danger'>No quedan suficientes unidades del libro '" + titulo + "'.</span></br>";
						}
					}

					if(restas!=0) {
						// CREAR PEDIDO
						
						int error = crearPedido(idPedido, userid);
						if(error == 1) {
							respuesta += "<span class='text-success'>Pedido creado correctamente.</span></br>";
						}
						
					} else {
						respuesta += "<span class='text-danger'>No se pudo realizar el pedido, todos los libros estaban agotados.</span></br>";
					}
					
					// BORRAR CARRITO
					session.removeAttribute("carrito");
				}
			} else if(todo.equals("send")) {
				String id = request.getParameter("id");
				int error = markAsSent(id);
				if(error == 1) {
					respuesta = "<span class='text-success'>Pedido #"+id+" marcado como enviado.</span></br>";
				} else {
					respuesta = "<span class='text-danger'>Error al marcar como enviado el pedido #"+id+".</span></br>";
				}
			}

			//response.getWriter().append(respuesta);
			// redirección
			try {
				session.setAttribute("msg", respuesta);
				response.sendRedirect(request.getContextPath() + "/pedidos.jsp");
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else {
			try {
				session.setAttribute("msg", respuesta);
				response.sendRedirect(request.getContextPath() + "/login.jsp");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	private int markAsSent(String id) {


		String query = "UPDATE pedidos SET enviadoPedido = 1, fechaEnviadoPedido = NOW() WHERE idPedido = " + id;
		try {

			Modelo.conectar();

			return Modelo.statement.executeUpdate(query);

		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return 0;
	}

	
	public static ArrayList<Pedido> getPedidos(int idUsuario, int privilegios) throws ServletException {
		
		ArrayList<Pedido> listapedidos = new ArrayList<Pedido>();
	
		try {
			
			Modelo.conectar();
			
			// Paso 4: Ejecutar las sentencias
			String query = "SELECT idPedidoFK, libros.nombreLibro, cantidadLibrosPedido, libros.precioLibro, pedidos.fechaPedido, pedidos.enviadoPedido, pedidos.fechaEnviadoPedido FROM librospedidos JOIN pedidos ON idPedidoFK = pedidos.idPedido JOIN libros ON idLibroFK = libros.idLibro WHERE pedidos.idUsuarioFK = "+idUsuario+" OR "+privilegios+" = 0 ORDER BY pedidos.fechaPedido DESC, idPedidoFK;";

			ResultSet rs = Modelo.statement.executeQuery(query);
			Pedido pedido;
			while(rs.next())
			{
				pedido = new Pedido(	rs.getInt("idPedidoFK"), 
										rs.getString("libros.nombreLibro"), 
										rs.getInt("cantidadLibrosPedido"), 
										rs.getDouble("libros.precioLibro"), 
										rs.getString("pedidos.fechaPedido"), 
										rs.getInt("pedidos.enviadoPedido"), 
										rs.getString("pedidos.fechaEnviadoPedido")	);


				listapedidos.add(pedido);
			}
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		
		
		return listapedidos;
	}

	private int insertarLibroPedido(int idPedido, int idLibro, int cantidadLibrosPedido) {

		String query = "INSERT INTO librospedidos VALUES(NULL,"+idPedido+", "+idLibro+", "+cantidadLibrosPedido+")";

		try {

			Modelo.conectar();

			return Modelo.statement.executeUpdate(query);


		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
	}

	private int crearPedido(int idPedido, int usuario) {
		// TODO Auto-generated method stub
		String query = "INSERT INTO pedidos VALUES("+idPedido+", "+usuario+", NOW(), 0,NULL)";

		try {

			Modelo.conectar();			
			return Modelo.statement.executeUpdate(query);


		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
	}


	
	private int restarLibros(int idLibro, int quedanLibros) {
		// TODO Auto-generated method stub

		try {

			Modelo.conectar();

			String query = "UPDATE libros SET cantidadLibro = " + quedanLibros + " WHERE idLibro = " + idLibro;
			return Modelo.statement.executeUpdate(query);


		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}


	private int cantidadLibros(int idLibro)  {

		int amount = 0;

		try {
			Modelo.conectar();

			String query = "SELECT * FROM libros WHERE idLibro = " + idLibro;
			ResultSet rs = Modelo.statement.executeQuery(query);
			rs.next();
			amount = rs.getInt("cantidadLibro");

		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}


		return amount;
	}

}
