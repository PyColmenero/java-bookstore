<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Inicio</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
	<style>
		.error {
			color: red;
		}
		.vw-50{width:50vw;}
	</style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
		<div class="container">
			<a class="navbar-brand" href="./login.jsp">Librería Honson - Inicio</a>
			<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"	aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav ms-auto mb-2 mb-lg-0">
					<li class="nav-item me-3"><a
						class="btn btn-outline-light rounded-0" href="./manager.jsp">Gestor</a>
					</li>
					<li class="nav-item"><a class="btn btn-light rounded-0"
						href="./shopping">Tienda</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<%
		String username = (String)session.getAttribute("usuario");
		if(username!=null){  
		%>
		<div class="position-relative vh-100 vw-100">
			<div class="position-absolute top-50 start-50 translate-middle bg-light rounded-3 border p-3">
				<div class="">
					<p class="mb-4">
						Bienvenido <b> <%out.println(username);%>
					<p>
					<div class="py-2 px-3 bg-light rounded shadow-sm mb-4 vw-50"><a class="link-dark" href="shopping">Tienda</a></div>
					<div class="py-2 px-3 bg-light rounded shadow-sm mb-4 vw-50"><a class="link-dark" href="Logout">Logout</a></div>
				</div>
			</div>
		</div>

	<%} else { %>
		<script> window.location.replace("./login.jsp"); </script>
	<%} %>

	<script>
		window.history.replaceState( null, null, window.location.href );
	</script>

</body>
</html>