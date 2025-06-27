require_relative './paquete/paquetes_lista'
require_relative './exceptions/paquetes_lista_vacio_exception'
require_relative './exceptions/envio_vacio_exception'
require_relative './exceptions/demasiados_paquetes_exception'
require_relative './exceptions/envio_demasiado_grande_exception'
require_relative './exceptions/exceso_volumen_exception'
require_relative './exceptions/envio_invalido_exception'
require_relative './exceptions/combinacion_invalida_de_rectangulo_y_redondo_exception'
require_relative './exceptions/combinacion_invalida_de_triangulos_exception'

class Envio
  attr_reader :paquetes_lista, :id

  def initialize(id)
    @id = id
    @paquetes_lista = PaquetesLista.new
  end

  def agregar_paquete(paquete)
    @paquetes_lista.agregar_paquete(paquete)
  end

  def cotizar
    @paquetes_lista.cotizar
  rescue PaquetesListaVacioException
    raise EnvioVacioException
  rescue DemasiadosPaquetesException
    raise EnvioDemasiadoGrandeException
  rescue ExcesoVolumenException
    raise EnvioDemasiadoGrandeException
  rescue CombinacionInvalidaDeTriangulosException
    raise EnvioInvalidoException
  rescue CombinacionInvalidaDeRectanguloYRedondoException
    raise EnvioInvalidoException
  end

  def calcular_volumen
    @paquetes_lista.calcular_volumen
  end

  def to_s
    @paquetes_lista.to_s
  end
end
