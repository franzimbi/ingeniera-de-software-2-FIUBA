class PaqueteTipo
  attr_reader :tipo

  def initialize(caracter_tipo)
    @tipo = caracter_tipo
  end

  def es_mismo_tipo?(otro_tipo)
    @tipo == otro_tipo.tipo
  end

  def to_s
    @tipo
  end
end
