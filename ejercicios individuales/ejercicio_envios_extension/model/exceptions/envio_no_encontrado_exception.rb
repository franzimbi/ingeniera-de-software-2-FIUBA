class EnvioNoEncontradoException < StandardError
  def initialize(msg = 'No se encontró un envió con el ID proveído')
    super
  end
end
