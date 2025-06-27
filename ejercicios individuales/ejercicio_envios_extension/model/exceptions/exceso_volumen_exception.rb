class ExcesoVolumenException < StandardError
  def initialize(msg = 'Los paquetes agregados exceden el volumen máximo')
    super
  end
end
