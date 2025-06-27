class EnvioDemasiadoGrandeException < StandardError
  def initialize(msg = 'El envío es demasiado grande por exceso de cantidad de paquetes o volumen')
    super
  end
end
