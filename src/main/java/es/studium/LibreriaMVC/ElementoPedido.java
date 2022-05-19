package es.studium.LibreriaMVC;

/**
 * 
 * @author Alejandro Colmenero Moreno
 * ElementoPedido
 * Representa un elemento del pedido
 * Incluye identificador del libro y cantidad
 *
 */
public class ElementoPedido
{
	private int idLibro;
	private int indice;
	private int cantidad;
	public ElementoPedido(int idLibro, int cantidad, int indice)
	{
		this.idLibro = idLibro;
		this.cantidad = cantidad;
		this.indice = indice;
	}
	public int getIdLibro()
	{
		return idLibro;
	}
	public void setIdLibro(int idLibro)
	{
		this.idLibro = idLibro;
	}
	public int getCantidad()
	{
		return cantidad;
	}
	public void setCantidad(int cantidad)
	{
		this.cantidad = cantidad;
	}
	public String getAutor()
	{
		return LibrosControlador.getListaLibros().get(indice).getAutor();
	}
	public String getTitulo()
	{
		return LibrosControlador.getListaLibros().get(indice).getTitulo();
	}
	public double getPrecio()
	{
		return LibrosControlador.getListaLibros().get(indice).getPrecio();
	}
}
