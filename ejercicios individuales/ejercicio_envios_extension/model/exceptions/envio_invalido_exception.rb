class EnvioInvalidoException < StandardError
  def initialize(msg = 'El envío no es válido')
    super
  end
end
