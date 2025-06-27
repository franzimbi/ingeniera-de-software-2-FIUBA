require_relative '../../exceptions/demasiados_paquetes_exception'

class RestriccionCantidadPaquetesMaxima
  CANTIDAD_MAXIMA_PAQUETES = 8

  def verificar(paquetes_lista)
    raise DemasiadosPaquetesException if paquetes_lista.cantidad_paquetes > CANTIDAD_MAXIMA_PAQUETES
  end
end
