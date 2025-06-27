require_relative './paquetes_lista'

class PaqueteCuadrado
  attr_reader :tipo

  COSTO_POCOS_PAQUETES_IGUALES = 2
  LIMITE_POCOS_PAQUETES_IGUALES = 3
  COSTO_MUCHOS_PAQUETES_IGUALES = 1
  VOLUMEN = 1

  def initialize(tipo, paquetes_lista)
    @tipo = tipo
    @volumen = VOLUMEN

    cantidad_paquetes_iguales = paquetes_lista.contar_paquetes_mismo_tipo(self)
    @costo = if cantidad_paquetes_iguales >= LIMITE_POCOS_PAQUETES_IGUALES
               COSTO_MUCHOS_PAQUETES_IGUALES
             else
               COSTO_POCOS_PAQUETES_IGUALES
             end
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
