<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page session="true" import="java.util.*, es.studium.LibreriaMVC.*"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>LOG IN</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
	
	<%
	String usuario = (String)session.getAttribute("usuario");
	// de primeras todo bien, hasta que se demuestre lo contrario
	int error = Login.LOGIN_NOERROR;
	Object msgObj = session.getAttribute("login-msg");
	if(msgObj != null){
		error = Integer.parseInt(msgObj.toString());
		System.out.println(error);
		session.removeAttribute("login-msg");
	}
	
	
	%>
	
	<style>
		.error {
			color: red;
		}
		.vw-50{width:50vw;}
	</style>

</head>

<body class="overflow-hidden vh-100">
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
			<div class="container">
				<a class="navbar-brand" href="./login.jsp">Librería Honson - Login</a>
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
		<div class="position-absolute top-50 start-50 translate-middle bg-light rounded-3 border p-3">

			<h1 class="text-center mb-4">Iniciar sesión</h1>
			<%
				String username = (String)session.getAttribute("usuario");
				if(username!=null){
					out.println("<p>Ya estás loggeado como '" + username + "'. <a class='link-dark' href='Logout'>Log Out</a>.</p>");				
				}
				String msg = "";
				if(error != Login.LOGIN_NOERROR){
					
					switch(error) {
					  case Login.LOGIN_ERROR_NULLUSER:
					    msg = "<p class='error'>Debes introducir tu usuario.</p>";
					    break;
					  case Login.LOGIN_ERROR_EMPTYUSER:
						  msg = "<p class='error'>Debes introducir tu usuario.</p>";
					    break;
					  case Login.LOGIN_ERROR_NULLPSWD:
						  msg = "<p class='error'>Debes introducir tu contraseña.</p>";
						  break;
					  case Login.LOGIN_ERROR_EMPTYPSWD:
						  msg = "<p class='error'>Debes introducir tu contraseña.</p>";
						 break;
					  case Login.LOGIN_ERROR_WRONG_LOG:
						  msg = "<p class='error'>Contraseña o usuario incorrectos.</p>";
						 break;
					  case Login.CONNECTION_ERROR:
						  msg = "<p class='error'>Error de conexión. Enciende el MySQL cago en la leche yá.</p>";
						 break;
					  default:
					    // code block
					}
				}
				out.println(msg);
			%>
			<form action="LoginServlet" method="POST" class="form">
				<div class="input-group mb-3">
					<span class="input-group-text" id="basic-addon1">@</span> <input
						type="text" class="form-control" name="username"
						placeholder="Username" aria-label="Username"
						aria-describedby="basic-addon1">
				</div>
				<div class="input-group mb-3">
					<span class="input-group-text px-3" id="basic-addon2">*</span> <input
						type="password" class="form-control" name="password"
						placeholder="Password" aria-label="Password"
						aria-describedby="basic-addon2">
				</div>
				<button class="btn btn-success w-100">Acceder</button>
			</form>

			
		 </div>
	</div>

	<script>
		window.history.replaceState( null, null, window.location.href );
	</script>

</body>

</html>