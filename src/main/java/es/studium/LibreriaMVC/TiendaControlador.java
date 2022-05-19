package es.studium.LibreriaMVC;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Formatter;
import java.util.Iterator;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
@WebServlet("/shopping")
public class TiendaControlador extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
	public void init(ServletConfig conf) throws ServletException
	{
		super.init(conf);

	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws 
	ServletException, IOException 
	{
		doPost(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws 
	ServletException, IOException 
	{
		LibrosControlador.cargarLibros();

		request.setCharacterEncoding("UTF-8");
		// Recupera la sesión actual o crea una nueva si no existe
		HttpSession session = request.getSession(true);


		String usuario = (String)session.getAttribute("usuario");

		if(usuario==null) {
			try {
				response.sendRedirect(request.getContextPath() + "/login.jsp");
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else {
			// Recupera el carrito de la sesiefefón actual
			@SuppressWarnings("unchecked")
			ArrayList<ElementoPedido> elCarrito = (ArrayList<ElementoPedido>) session.getAttribute("carrito");
			// Determina a qué página jsp se redirigirá
			String nextPage = "";
			String todo = request.getParameter("todo");
			if(todo==null)
			{
				// Primer acceso, redirigir a order.jsp
				nextPage = "/order.jsp";
			}
			else if(todo.equals("add"))
			{
				// Mandado por order.jsp con los parámetros idLibro y cantidad
				// Creamos un elementoPedido y lo añadimos al carrito
				ElementoPedido nuevoElementoPedido = new ElementoPedido(Integer.parseInt(request.getParameter("idLibro")),
																		Integer.parseInt(request.getParameter("cantidad")),
																		Integer.parseInt(request.getParameter("indiceLibro"))	);
				
				if(elCarrito==null)
				{
					// El carrito está vacío
					elCarrito = new ArrayList<>();
					elCarrito.add(nuevoElementoPedido);
					// Enlazar el carrito con la sesión
					session.setAttribute("carrito", elCarrito);
				}
				else
				{
					// Comprueba si el libro está ya en el carrito
					// Si lo está, actualizamos la cantidad
					// Si no está, lo añadimos
					boolean encontrado = false;
					Iterator<ElementoPedido> iter = elCarrito.iterator();
					while(!encontrado && iter.hasNext()) {
						ElementoPedido unElementoPedido = (ElementoPedido)iter.next();
						if(unElementoPedido.getIdLibro() == nuevoElementoPedido.getIdLibro()) {
							unElementoPedido.setCantidad(unElementoPedido.getCantidad() + nuevoElementoPedido.getCantidad());
							encontrado = true;
						}
					}
					
					if(!encontrado)
					{
						// Lo añade al carrito
						elCarrito.add(nuevoElementoPedido);
					}
				}
				// Volvemos a order.jps para seguir con la compra
				nextPage = "/order.jsp";
			} else if(todo.equals("remove"))	{
				// Enviado por order.jsp con el parámetro indiceElemento
				// Borra el elemento indiceElemento del carrito
				int indiceCarrito = Integer.parseInt(request.getParameter("indiceElemento"));
				elCarrito.remove(indiceCarrito);
				// Vuelve a order.jsp para seguir con la compra
				nextPage = "/order.jsp";
			}
			else if (todo.equals("checkout"))	{
				
				
				// Enviado por order.jsp
				// Calcula el precio total de todos los elementos del carrito
				double precioTotal = 0;
				int cantidadTotalOrdenada = 0;
				for(ElementoPedido item: elCarrito)
				{
					double precio = item.getPrecio();
					int cantidadOrdenada = item.getCantidad();
					precioTotal += precio * cantidadOrdenada;
					cantidadTotalOrdenada += cantidadOrdenada;
				}
				// Da formato al precio con dos decimales
				StringBuilder sb = new StringBuilder();
				Formatter formatter = new Formatter(sb);
				formatter.format("%.2f", precioTotal);
				formatter.close();
				// Coloca el precioTotal y la cantidadtotal en el request
				request.setAttribute("precioTotal", sb.toString());
				request.setAttribute("cantidadTotal", cantidadTotalOrdenada+"");
				// Redirige a checkout.jsp
				nextPage = "/checkout.jsp";
				
				
			} else if(todo.equals("erase")) {
				
				nextPage = "/order.jsp";
				request.getSession().removeAttribute("carrito");
				
			}
			ServletContext servletContext = getServletContext();
			RequestDispatcher requestDispatcher = servletContext.getRequestDispatcher(nextPage);
			requestDispatcher.forward(request, response);

		}
	}
}
