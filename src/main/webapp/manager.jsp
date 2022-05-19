<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>MANAGER</title>
	    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
		
		<% 
		String user = (String) session.getAttribute("usuario");
		int priv = 0;
		
		if(user==null){
			response.sendRedirect("./login.jsp");
		} else {
			priv = (int) session.getAttribute("privileges");
		}
		
		%>
	</head>
	<body>
	
		<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
			<div class="container">
				<a class="navbar-brand" href="./login.jsp">Librería Honson - Manager</a>
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
	
		
		<div class="container py-5">
		
			<div class="row"> 
				<div class="col-12 col-md-10 col-lg-8 mx-auto">
					<%
					System.out.println(priv);
					if(priv==0) {
					%>
						<h1 class='mb-4'>Manager</h1>
						<div class="py-2 px-3 bg-light rounded shadow-sm mb-4"><a class="link-dark" href="libros.jsp">Libros</a></div>
						<div class="py-2 px-3 bg-light rounded shadow-sm mb-4"><a class="link-dark" href="autores.jsp">Autores</a></div>
						<div class="py-2 px-3 bg-light rounded shadow-sm mb-4"><a class="link-dark" href="editoriales.jsp">Editoriales</a></div>
						<div class="py-2 px-3 bg-light rounded shadow-sm mb-4"><a class="link-dark" href="pedidos.jsp">Pedidos</a></div>
						<div class="py-2 px-3 bg-light rounded shadow-sm mb-4"><a class="link-dark" href="login.jsp">Inicio</a></div>
					<%} else { %>
						<p class='text-danger'> No tienes permisos para entrar aquí.</p>
					<%} %>
				</div>
			</div>

		</div>
		
		
		<script>
			window.history.replaceState( null, null, window.location.href );
		</script>
	</body>
</html>