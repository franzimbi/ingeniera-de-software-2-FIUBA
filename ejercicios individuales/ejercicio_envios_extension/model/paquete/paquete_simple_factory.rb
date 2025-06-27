require_relative './paquete_redondo'
require_relative './paquete_triangular'
require_relative './paquete_cuadrado'
require_relative './paquete_rectangular'
require_relative './paquete_tipo'
require_relative '../exceptions/tipo_de_paquete_inexistente_exception'

class PaqueteSimpleFactory
  TIPO_REDONDO = 'R'.freeze
  TIPO_TRIANGULAR = 'T'.freeze
  TIPO_CUADRADO = 'C'.freeze
  TIPO_RECTANGULAR = 'E'.freeze

  def crear_paquete(tipo_caracter, paquetes_lista)
    case tipo_caracter
    when TIPO_REDONDO
      PaqueteRedondo.new(PaqueteTipo.new(TIPO_REDONDO), paquetes_lista)
    when TIPO_TRIANGULAR
      PaqueteTriangular.new(PaqueteTipo.new(TIPO_TRIANGULAR), paquetes_lista)
    when TIPO_CUADRADO
      PaqueteCuadrado.new(PaqueteTipo.new(TIPO_CUADRADO), paquetes_lista)
    when TIPO_RECTANGULAR
      PaqueteRectangular.new(PaqueteTipo.new(TIPO_RECTANGULAR), paquetes_lista)
    else
      raise TipoDePaqueteInexistenteException
    end
  end
end
