class TipoDePaqueteInexistenteException < StandardError
  def initialize(msg = 'El tipo de paquete suministrado no existe')
    super
  end
end
