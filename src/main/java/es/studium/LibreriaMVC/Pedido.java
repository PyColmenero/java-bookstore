package es.studium.LibreriaMVC;

public class Pedido {

	int id;
	String nombre;
	int cantidad;
	double precio;
	String fechaRealizado;
	String fechaEnviado;
	boolean enviado;
	private static final int ENVIADO = 1;
	
	public Pedido(int id, String nombre, int cantidad, double precio, String fechaRealizado, int enviado, String fechaEnviado) {
		super();
		this.id = id;
		this.nombre = nombre;
		this.cantidad = cantidad;
		this.precio = precio;
		this.fechaRealizado = fechaRealizado;
		this.fechaEnviado = fechaEnviado;
		this.enviado = (enviado==ENVIADO);
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
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

	public String getFechaRealizado() {
		return fechaRealizado;
	}

	public void setFechaRealizado(String fecha) {
		this.fechaRealizado = fecha;
	}
	public String getFechaEnviado() {
		return fechaEnviado;
	}

	public void setFechaEnviado(String fecha) {
		this.fechaEnviado = fecha;
	}

	public boolean isEnviado() {
		return enviado;
	}

	public void setCompletado(boolean enviado) {
		this.enviado = enviado;
	}
	
	
	
}
