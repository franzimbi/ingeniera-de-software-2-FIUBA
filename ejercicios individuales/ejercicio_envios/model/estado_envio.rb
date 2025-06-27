VOLUMEN_LIMITE_POR_ENVIO = 10
CANTIDAD_PAQUETES_LIMITE_POR_ENVIO = 8

class EstadoEnvio
  def initialize(contador, volumen, costo)
    @contenido = contador
    @volumen = volumen
    @costo = costo
  end

  def esta_vacio
    total = (@contenido.obtener_cantidad_triangulos + @contenido.obtener_cantidad_cuadrados)
    (total + @contenido.obtener_cantidad_rectangulos).zero?
  end

  def es_valido
    @contenido.obtener_cantidad_triangulos <= 1 ||
      (@contenido.obtener_cantidad_cuadrados.zero? && @contenido.obtener_cantidad_rectangulos.zero?)
  end

  def es_grande
    es_grande_paquetes = @contenido.obtener_cantidad_total > CANTIDAD_PAQUETES_LIMITE_POR_ENVIO
    es_grande_paquetes || @volumen > VOLUMEN_LIMITE_POR_ENVIO
  end

  def obtener_volumen
    @volumen
  end

  def obtener_costo
    @costo
  end
end
