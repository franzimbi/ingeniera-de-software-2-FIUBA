require_relative '../../exceptions/exceso_volumen_exception'

class RestriccionVolumenMaximo
  VOLUMEN_MAXIMO = 11

  def verificar(paquetes_lista)
    raise ExcesoVolumenException if paquetes_lista.calcular_volumen > VOLUMEN_MAXIMO
  end
end
