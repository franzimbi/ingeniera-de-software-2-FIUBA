require_relative './restriccion_cantidad_paquetes_maxima'
require_relative './restriccion_combinacion_triangulos'
require_relative './restriccion_no_vacio'
require_relative './restriccion_volumen_maximo'
require_relative './restriccion_combinacion_rectangulos_redondos'

class VerificadorRestricciones
  def initialize
    @restricciones = [
      RestriccionCantidadPaquetesMaxima.new,
      RestriccionCombinacionTriangulos.new,
      RestriccionNoVacio.new,
      RestriccionVolumenMaximo.new,
      RestriccionCombinacionRectanguloYRedondo.new
    ]
  end

  def verificar(paquetes_lista)
    @restricciones.each do |restriccion|
      restriccion.verificar(paquetes_lista)
    end
  end
end
