require_relative '../../exceptions/combinacion_invalida_de_triangulos_exception'
require_relative '../paquete_simple_factory'

class RestriccionCombinacionTriangulos
  CANTIDAD_MAXIMA_TRIANGULOS_SUELTOS = 1
  TIPO_TRIANGULAR = 'T'.freeze

  def verificar(paquetes_lista)
    paquete_triangular = PaqueteSimpleFactory.new.crear_paquete(TIPO_TRIANGULAR, PaquetesLista.new)
    cantidad_triangulos = paquetes_lista.contar_paquetes_mismo_tipo(paquete_triangular)

    if (cantidad_triangulos <= CANTIDAD_MAXIMA_TRIANGULOS_SUELTOS) ||
       (cantidad_triangulos == paquetes_lista.cantidad_paquetes)
      return
    end

    raise CombinacionInvalidaDeTriangulosException
  end
end
