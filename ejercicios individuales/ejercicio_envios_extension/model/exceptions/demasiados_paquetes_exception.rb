class DemasiadosPaquetesException < StandardError
  def initialize(msg = 'Hay demasiados paquetes agregados')
    super
  end
end
