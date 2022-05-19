package es.studium.LibreriaMVC;
/**
 * 
 * @author Jorge
 * Libro
 * Representa un libro
 * Incluye identificador del libro, título, autor y precio
 *
 */
public class Libro {
	
	private int id;
	private String titulo;
	private int cantidad;
	private double precio;
	private int idAutor;
	private String autor;
	private int idEditorial;
	private String editorial;
	
	public Libro() {
		super();
		this.id = 0;
		this.titulo = "";
		this.cantidad = 0;
		this.precio = 0;
		this.idAutor = 0;
		this.idEditorial = 0;
	}
	public Libro(int id, String titulo, int cantidad, double precio, int idAutor, String autor, int idEditorial, String editorial) {
		super();
		this.id = id;
		this.titulo = titulo;
		this.cantidad = cantidad;
		this.precio = precio;
		this.idAutor = idAutor;
		this.autor = autor;
		this.idEditorial = idEditorial;
		this.editorial = editorial;
	}


	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTitulo() {
		return titulo;
	}
	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}
	public int getCantidad() {
		return cantidad;
	}
	public void setCantidad(int cantidad) {
		this.cantidad = cantidad;
	}
	public double getPrecio() {
		return precio;
	}
	public void setPrecio(double precio) {
		this.precio = precio;
	}
	public int getIdAutor() {
		return idAutor;
	}
	public void setIdAutor(int idAutor) {
		this.idAutor = idAutor;
	}
	public String getAutor() {
		return autor;
	}
	public void setAutorLibro(String autor) {
		this.autor = autor;
	}
	public int getIdEditorial() {
		return idEditorial;
	}
	public void setIdEditorial(String editorial) {
		this.idEditorial = idEditorial;
	}
	public String getEditorial() {
		return editorial;
	}
	public void setEditorial(String editorial) {
		this.idEditorial = idEditorial;
	}
	
	
	
}