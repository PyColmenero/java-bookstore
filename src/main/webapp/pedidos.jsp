<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" import="java.util.*, es.studium.LibreriaMVC.*"%>
   
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Pedidos</title>
	<link
		href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
		rel="stylesheet"
		integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
		crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<%
		String user = (String) session.getAttribute("usuario");
		int priv = 1;
		
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
			<a class="navbar-brand" href="./login.jsp">Librería Honson - Pedidos</a>
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
			<h1>Pedidos</h1>
			
			<p class=""> 
				<%
					String msg = (String) session.getAttribute("msg");
					if(msg != null){
						out.println(msg);
						session.removeAttribute("msg");
					}
				%> 
			</p>
			
			
			
			<%
			int userid = 0;
			String username = (String) session.getAttribute("usuario");
			if(username==null) {
				%>
					<script> window.location.replace("./login.jsp"); </script>
				<%
			} else {
	
				userid = (int) session.getAttribute("userid");
				
				ArrayList<Pedido> listapedidos = PedidosControlador.getPedidos(userid, priv);
				
				if(priv==0){
					out.println("<p>Todos los pedidos:</p>");
				} else {
					out.println("<p>Tus pedidos:</p>");
				}
				
				if (listapedidos != null && listapedidos.size() != 0) {
					
					int idPedido = 0;
					int idNextPedido = 0;
					double totalLibroPedido = 0;
					double totalPedido = 0;
					String librosPedidos = "";
					String botonEnviado = "";
					
					for (int x = 0; x < listapedidos.size(); x++) {
						
						Pedido currentPedido = listapedidos.get(x);
						idPedido = currentPedido.getId();	
						
						
						if(x+1!=listapedidos.size()){ // si no es el último
							idNextPedido = listapedidos.get(x+1).getId();							
						} else {// si es el último forzamos que el ID se distinto y así genere el pedido, porque no se puede comprarar con el Id siguiente, pq es el ultimo
							idNextPedido = 0;
						}
						
						
						
						
						totalLibroPedido = currentPedido.getPrecio() * currentPedido.getCantidad();
						totalLibroPedido = (double)Math.round(totalLibroPedido * 100) / 100;
						System.out.println(totalLibroPedido);
						
						totalPedido += totalLibroPedido; 
						librosPedidos+= "<tr>"
											+ "<td width='50%'>"+currentPedido.getNombre()+"</td>"
											+ "<td>"+currentPedido.getPrecio()+"€</td>"
											+ "<td>"+currentPedido.getCantidad()+"</td>"
											+ "<td>"+totalLibroPedido+"€</td>"
										+ "</tr>";
						
						
						// nuevo PEDIDO
						if(idPedido != idNextPedido){
							%>
							<table class='table mb-5 border bg-light shadow-sm'>
								<thead>
									<tr class='bg-dark text-light'>
										<td colspan='4'>
											<div class='d-flex justify-content-between'>  
												<p class='m-0'>PEDIDO #<%=currentPedido.getId() %></p>  
												<p class='m-0'><%=currentPedido.getFechaRealizado() %></p>   
											</div>
										</td>
									</tr>
									<tr>
										<th>NOMBRE</th>
										<th>PRECIO</th>
										<th>CANTIDAD</th>
										<th>TOTAL</th>
									</tr>
								</thead>
								<tbody>
									<%=librosPedidos %>
									
									<%
									if(priv==0){
										if(currentPedido.isEnviado()){
											botonEnviado = "<a class='btn btn-outline-success rounded-0 px-2 py-1'>ENVIADO EL "+currentPedido.getFechaEnviado()+"</a>";
										} else {
											botonEnviado = "<a href='PedidosControlador?todo=send&id="+currentPedido.getId()+"' class='btn btn-success rounded-0 px-2 py-1' >MARCAR COMO ENVIADO</a>";
										}	
									} else {
										if(currentPedido.isEnviado()){
											botonEnviado = "<span class='text-success'>Pedido enviado el "+currentPedido.getFechaEnviado()+".</span>";
										} else {
											botonEnviado = "<span class='text-danger'>Pedido no enviado aun.</span>";
										}	
									}
									
									%>
									
									<td colspan='3'> <%=botonEnviado %> </td><td><%=totalPedido %>€</td>
								</tbody>
							</table>
							<%
							librosPedidos = "";
							totalPedido = 0;
						}// end if
						
						
						
					} // end for
					
				} else {
					%><p>No tienes ningún pedido.</p><%
				}
			}
			
			%>
			</div>
		</div>
	</div>
	
	
	<script>
		window.history.replaceState( null, null, window.location.href );
	</script>

</body>
</html>