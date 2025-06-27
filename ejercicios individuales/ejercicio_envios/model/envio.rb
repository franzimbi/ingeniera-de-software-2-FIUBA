require_relative 'contador'
require_relative 'estado_envio'

VOLUMEN_SIN_RECARGO = 5
LIMITE_COSTO_MINORITARIO_CUADRADOS = 3
RECARGO = 1.1

class Envio
  module Cuadrado
    VOLUMEN = 1
    COSTO_BASICO = 2
    COSTO_MAYORITARIO = 1
  end

  module Triangulo
    VOLUMEN = 3
    COSTO = 3
  end

  module Redondo
    VOLUMEN = 2
    COSTO = 4
  end

  def initialize
    @paquetes = []
  end

  def agregar_paquete(paquete)
    @paquetes << paquete
  end

  def calcular_volumen
    contador = Contador.new(@paquetes)
    total = Cuadrado::VOLUMEN * contador.obtener_cantidad_cuadrados
    total += Redondo::VOLUMEN * contador.obtener_cantidad_rectangulos
    total + Triangulo::VOLUMEN * contador.obtener_cantidad_triangulos
  end

  def obtener_detalle
    @paquetes.join('')
  end

  def calcular_costo
    total = calcular_costo_base
    return (total * RECARGO).truncate(1) if calcular_volumen < VOLUMEN_SIN_RECARGO

    total
  end

  def obtener_estado
    EstadoEnvio.new(Contador.new(@paquetes), calcular_volumen, calcular_costo)
  end

  private

  def calcular_costo_base
    contador = Contador.new(@paquetes)

    total = contador.obtener_cantidad_rectangulos * Redondo::COSTO
    total += calcular_costo_cuadrados(contador.obtener_cantidad_cuadrados)
    total + contador.obtener_cantidad_triangulos * Triangulo::COSTO
  end

  def calcular_costo_cuadrados(cantidad_cuadrados)
    if cantidad_cuadrados > LIMITE_COSTO_MINORITARIO_CUADRADOS
      return (cantidad_cuadrados - 1) * Cuadrado::COSTO_MAYORITARIO + Cuadrado::COSTO_BASICO * 2
    end

    cantidad_cuadrados * Cuadrado::COSTO_BASICO
  end
end
