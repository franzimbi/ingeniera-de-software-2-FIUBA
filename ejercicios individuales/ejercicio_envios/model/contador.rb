TRIANGULO = 'T'.freeze # esta falopa es de rubocop
CUADRADO = 'C'.freeze
RECTANGULO = 'R'.freeze

class Contador
  def initialize(paquetes)
    @diccionario = {CUADRADO => 0, RECTANGULO => 0, TRIANGULO => 0}
    paquetes.each do |paquete|
      raise ArgumentError, "Paquete inválido: #{paquete}" unless @diccionario.key?(paquete)

      @diccionario[paquete] += 1
    end
  end

  def obtener_cantidad_triangulos
    @diccionario[TRIANGULO]
  end

  def obtener_cantidad_cuadrados
    @diccionario[CUADRADO]
  end

  def obtener_cantidad_rectangulos
    @diccionario[RECTANGULO]
  end

  def obtener_cantidad_total
    @diccionario.values.sum
  end
end
