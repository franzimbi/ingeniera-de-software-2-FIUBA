require_relative '../../exceptions/paquetes_lista_vacio_exception'

class RestriccionNoVacio
  def verificar(paquetes_lista)
    raise PaquetesListaVacioException if paquetes_lista.empty?
  end
end
