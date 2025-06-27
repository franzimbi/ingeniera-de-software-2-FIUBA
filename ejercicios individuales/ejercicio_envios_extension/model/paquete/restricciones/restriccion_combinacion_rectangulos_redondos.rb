require_relative '../../exceptions/combinacion_invalida_de_rectangulo_y_redondo_exception'
require_relative '../paquete_simple_factory'

class RestriccionCombinacionRectanguloYRedondo
  CANTIDAD_CERO = 0
  TIPO_RECTANGULAR = 'E'.freeze
  TIPO_REDONDO = 'R'.freeze
  def verificar(paquetes_lista)
    paquete_rectangular = PaqueteSimpleFactory.new.crear_paquete(TIPO_RECTANGULAR,
                                                                 PaquetesLista.new)
    cantidad_rectangulares = paquetes_lista.contar_paquetes_mismo_tipo(paquete_rectangular)
    paquete_redondo = PaqueteSimpleFactory.new.crear_paquete(TIPO_REDONDO, PaquetesLista.new)
    cantidad_redondos = paquetes_lista.contar_paquetes_mismo_tipo(paquete_redondo)

    return unless cantidad_rectangulares > CANTIDAD_CERO && cantidad_redondos > CANTIDAD_CERO

    raise CombinacionInvalidaDeRectanguloYRedondoException
  end
end
