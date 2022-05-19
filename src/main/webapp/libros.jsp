<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true" import="java.util.*, es.studium.LibreriaMVC.*"%>

<!DOCTYPE html>
<html lang="es">
<head>
	<meta charset="UTF-8">
	<meta content="width=device-width, initial-scale=1" name="viewport">
	<title>Libros</title>
	<link
		href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
		rel="stylesheet"
		integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
		crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
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
			<a class="navbar-brand" href="./login.jsp">Librería Honson - Libro</a>
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
		
		<p class=""> <%
			String msg = (String) session.getAttribute("response");
			if(msg != null){
				out.println(msg);
				session.removeAttribute("response");
			}
		%> </p>
		
		<table class="table table-striped">
			<thead>
				<tr>
					<th width="5%">#</th>
					<th width="25%">Autor</th>
					<th width="20%">Editorial</th>
					<th width="20%">Título</th>
					<th width="10%">Cantidad</th>
					<th width="10%">Precio</th>
					
					<th width="10%"></th>
				</tr>
			</thead>
			<tbody>
				<%
				String autorHtmlOptions = "";
				String editorialHtmlOptions = "";
					
				ArrayList<Autor> listautores = AutoresControlador.getAutores();
				for (int x = 0; x < listautores.size(); x++) {
					Autor currentAutor = listautores.get(x);
					autorHtmlOptions += "<option value='"+currentAutor.getId()+"'> "+currentAutor.getNombre()+" </option>";
				}
				ArrayList<Editorial> listeditoriales = EditorialesControlador.getEditoriales();
				for (int x = 0; x < listeditoriales.size(); x++) {
					Editorial currentEditorial = listeditoriales.get(x);
					editorialHtmlOptions += "<option value='"+currentEditorial.getId()+"'> "+currentEditorial.getNombre()+" </option>";
				}
			
				String libroeditando = (String) request.getParameter("id");
				int idLibroEditando = -1;
				if(libroeditando!=null){
					idLibroEditando = Integer.parseInt(libroeditando);
				}
				

				//LibreriaMVC.cargarDatos();
				ArrayList<Libro> listalibros = LibrosControlador.getListaLibros();
				
				
				if (listalibros != null) {
					for (int x = 0; x < listalibros.size(); x++) {
						
						Libro currentLibro = listalibros.get(x);
						int id = currentLibro.getId();
						if (id == idLibroEditando) {
						%>
							
							<tr>
								<form method="POST" action="LibrosControlador" class="d-flex w-100">
									<input type="hidden" name="todo" value="edit" /> <input type="hidden" name="id" value="<%=id %>" />
									
									<td>
										<%=x %>
									</td>
									<td>
										<select name="idAutorLibroFK" class="form-select">
							                <%=autorHtmlOptions %>
							            </select>
									</td>
									<td>
										 <select name="idEditorialFK" class="form-select">
							                <%=editorialHtmlOptions %>
							            </select>
									</td>
									<td>
										<input type="text" value="<%=currentLibro.getTitulo() %>" class="form-control" placeholder="Titulo" name="nombreLibro" />
									</td>
									<td>
										<input type="number" step="0.01" value="<%=currentLibro.getCantidad() %>" class="form-control" placeholder="Cantidad" name="cantidadLibro" />
									</td>
									<td>
										<input type="number" step="0.01" value="<%=currentLibro.getPrecio() %>" class="form-control" placeholder="Precio" name="precioLibro" />
									</td>
									<td>
										<div class="px-1 d-flex">
								        	<button type="submit" class="btn btn-warning">Confirmar</button>
								        	<a type="submit" href="./libros.jsp" class="btn btn-danger ms-2">X</a>
								        </div>
									</td>
								    
								</form>
							</tr>
						<% 
						} else {
						%>
							<tr>
							    <td><%=x %></td>
							    <td><%=currentLibro.getAutor() %></td>
							    <td><%=currentLibro.getEditorial() %></td>
							    <td><%=currentLibro.getTitulo() %></td>
							    <td><%=currentLibro.getCantidad() %></td>
							    <td><%=currentLibro.getPrecio() %>€</td>
							    <td class='text-end pe-3'><a href="libros.jsp?id=<%=id %>" class="btn btn-warning"> Editar </a></td>
							</tr>
							<%
						}
					}
				} else {
					%> <tr> <td> NADA </td> </tr> <%
				}
				%>
				<tr>
					<form method="POST" action="LibrosControlador" class="d-flex w-100">
					
						<input type="hidden" name="todo" value="new" />
						
						<td></td>
						
						<td>
							<select name="idAutorFK" class="form-select">
								<%
								out.println(autorHtmlOptions);
								%>
							</select>
						</td>
						<td>
							<select name="idEditorialFK" class="form-select">
								<%
								out.println(editorialHtmlOptions);
								%>
							</select>
						</td>
						<td>
							<input type="text" class="form-control" placeholder="Titulo" name="nombreLibro" required>
						</td>
						<td>
							<input type="number" step="0.01" class="form-control" placeholder="Cantidad"	name="cantidadLibro" required>
						</td>
						<td>
							<input type="number" step="0.01" class="form-control" placeholder="Precio" name="precioLibro" required>
						</td>
						<td>
							<div class="text-end"><button type="submit" class="btn btn-success">	Añadir 	</button></div>
						</td>
					</form>
				</tr>
			</tbody>
		</table>
	</div>


	<script>
		window.history.replaceState( null, null, window.location.href );
	</script>

</body>
</html>