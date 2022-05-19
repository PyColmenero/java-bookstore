<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page session="true" import="java.util.*, es.studium.LibreriaMVC.*"%>
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Autores</title>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
		
		<%
		String username = (String)session.getAttribute("usuario");
		if(username==null){  
			response.sendRedirect("./login.jsp");
		}
		%>
		
	</head>
	<body class="overflow-hidden vh-100">
		<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
			<div class="container">
				<a class="navbar-brand" href="./login.jsp">Librería Honson - Autores</a>
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

	    <div class="position-relative vh-100 vw-100">
	        <div class="position-absolute top-50 start-50 translate-middle bg-light rounded-3 border p-3" style="min-width: 50vw;">
	
	
	            <h1 class="mb-4">Autores </h1>
	  
				<table class="table table-striped ">
	                <thead>
	                    <tr>
	                        <td>ID</td>
	                        <td>Nombre</td>
	                        <td>Apellidos</td>
	                    </tr>
	                </thead>
	                <tbody>
	                
		               		<%
		    				ArrayList<Autor> listautores = AutoresControlador.getAutores();

			                for (int x = 0; x < listautores.size(); x++) {
								Autor currentAutor = listautores.get(x);
		                	%>
		                	
		                    <tr>
								<td><%=currentAutor.getId() %></td>
								<td><%=currentAutor.getNombre() %></td>
								<td><%=currentAutor.getApellidos() %></td>
							</tr>
							
							<%} %>
	                </tbody>
	            </table>
	
	        </div>
	    </div>

	<script>
		window.history.replaceState( null, null, window.location.href );
	</script>

	</body>
</html>