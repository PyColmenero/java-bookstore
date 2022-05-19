<%-- Página de órdenes de pedido --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true" import="java.util.*, es.studium.LibreriaMVC.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Pedido</title>
	<link
		href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
		rel="stylesheet"
		integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<%
		String username = (String)session.getAttribute("usuario");
		if(username==null){  
			response.sendRedirect("./login.jsp");
		}
	%>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
		<div class="container">
			<a class="navbar-brand" href="./login.jsp">Librería Honson - Tienda</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav ms-auto mb-2 mb-lg-0">
					<li class="nav-item me-3"><a
						class="btn btn-outline-light rounded-0" href="./manager.jsp">Gestor</a>
					</li>
					<li class="nav-item me-3"><a
						class="btn btn-outline-light rounded-0" href="./pedidos.jsp">Pedidos</a>
					</li>
					<li class="nav-item me-3">
						<a class="btn btn-outline-light rounded-0" href="./login.jsp">
							<i class="bi bi-person-circle"></i>
						</a>
					</li>
					<li class="nav-item">
						<a class="btn btn-light rounded-0" href="./shopping">Tienda</a>
					</li>
				</ul>
			</div>
		</div>
	</nav>

	<div class="container my-5">
		<h1>LIBROS</h1>
		<%="Hola " + username %>
		<table class="table table-striped">
			<thead>
				<tr>
					<th>#</th>
					<th>Autor</th>
					<th>Título</th>
					<th>Cantidad</th>
					<th>Precio</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<%
				String disable = "";
				ArrayList<Libro> listalibros = LibrosControlador.getListaLibros();
				if (listalibros != null) {
					for (int x = 0; x < listalibros.size(); x++) {
						Libro currentLibro = listalibros.get(x);
						%>
						<tr>
							<td><%=(x + 1) %></td>
							<td><%=currentLibro.getAutor() %></td>
							<td><%=currentLibro.getTitulo() %></td>
							<td><%=currentLibro.getCantidad() %></td>
							<td><%=currentLibro.getPrecio() %>€</td>
							<td width="25%">
								<form action="shopping" method="POST" class="d-flex">
									<input type='hidden' name='todo' value='add'>
									<input type='hidden' name='idLibro' value="<%=currentLibro.getId() %>">
									<input type='hidden' name='indiceLibro' value="<%=x %>">
									<% 
										
										disable = (currentLibro.getCantidad() == 0) ? "disabled" : "";
									
										out.println("<select name='cantidad' class='form-select w-75'"+disable+">");
										for (int y = 1; y <= 10; y++){
											out.println("<option value='" + y + "'>" + y + "</option>");
										}
										out.println("<select name='cantidad' class='form-select w-75'>");
	
										
									%>
									<button type="submit" class="btn btn-warning ms-1 w-50" <%=disable %>>Añadir </button> 
								</form>
							</td>
						</tr>
						<%  
					}
				}
				%>
			</tbody>
		</table>
	



		<%
		// Scriplet 2: Chequea el contenido de la cesta
		ArrayList<ElementoPedido> cesta = (ArrayList<ElementoPedido>) session.getAttribute("carrito");
		
		if (cesta != null && cesta.size() > 0) {
			System.out.println(cesta.size());
		%>
			<p class="mt-5">			<strong>Tu cesta contiene:</strong>		</p>
			<table class="table table-striped">
				<thead>
					<tr>
						<th>Autor</th>
						<th>Título</th>
						<th>Precio</th>
						<th>Cantidad</th>
						<th>-</th>
					</tr>
				</thead>
				
				<tbody>
					<%
					System.out.println(cesta.size() + ",");
					for (int i = 0; i < cesta.size(); i++) {
						ElementoPedido elementoPedido = cesta.get(i);
						System.out.println(elementoPedido.getIdLibro());
					%>
					<tr>
						<form name="deleteForm" action="shopping" method="POST">
						
							<input type="hidden" name="todo" value="remove"> 
							<input type="hidden" name="indiceElemento" value="<%=i%>">
							
							<td><%=elementoPedido.getAutor()%></td>
							<td><%=elementoPedido.getTitulo()%></td>
							<td><%=elementoPedido.getPrecio()%> €</td>
							<td><%=elementoPedido.getCantidad()%></td>
							<td class="text-end"><input class="btn btn-danger" type="submit" value="Eliminar de la cesta"></td>
							
						</form>
					</tr>
					<%
					}
					%>
					
					<tr>
						<td colspan="5">
							<form action="PedidosControlador" method="POST" class="text-end">
								<input type="hidden" name="todo" value="add">
								<input type="submit" class="btn btn-success" value="Confirmar compra">
							</form>
						</td>
					</tr>
				</tbody>
			</table>

			
		<%
		}
		%>


	</div>
	
	
	<script>
		window.history.replaceState( null, null, window.location.href );
	</script>

</body>
</html>
