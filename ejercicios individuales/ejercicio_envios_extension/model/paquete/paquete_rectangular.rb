require_relative './paquetes_lista'

class PaqueteRectangular
  attr_reader :tipo

  COSTO = 2
  VOLUMEN = 4

  def initialize(tipo, _)
    @tipo = tipo
    @costo = COSTO
    @volumen = VOLUMEN
  end

  def cotizar
    @costo
  end

  def es_mismo_tipo?(otro_paquete)
    @tipo.es_mismo_tipo? otro_paquete.tipo
  end

  def calcular_volumen
    @volumen
  end

  def to_s
    @tipo.to_s
  end
end
