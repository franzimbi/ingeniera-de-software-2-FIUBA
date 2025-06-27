class CombinacionInvalidaDeTriangulosException < StandardError
  def initialize(msg = 'La combinación de PaquetesTriangulo con otros tipos de paquete es inválida')
    super
  end
end
