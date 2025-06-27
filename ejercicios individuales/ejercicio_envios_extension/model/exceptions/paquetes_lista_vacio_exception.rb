class PaquetesListaVacioException < StandardError
  def initialize(msg = 'No se puede cotizar sin paquetes agregados')
    super
  end
end
