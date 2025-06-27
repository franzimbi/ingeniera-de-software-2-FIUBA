class EnvioVacioException < StandardError
  def initialize(msg = 'No se puede cotizar un envío vacío')
    super
  end
end
