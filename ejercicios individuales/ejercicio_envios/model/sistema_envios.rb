require_relative 'envio'

class SistemaEnvios
  def initialize
    @id_actual = 0
    @envios = {}
  end

  def crear_envio
    @id_actual += 1
    @envios[@id_actual] = Envio.new
    @id_actual
  end

  # util para saber si se guardan bien los envios nuevos
  def cantidad_envios
    @envios.length
  end

  def agregar_paquete(id, paquete)
    raise ArgumentError, "El id #{id} no es válido" unless @envios.key?(id)

    @envios[id].agregar_paquete(paquete)
  end

  def calcular_volumen(id)
    @envios[id].calcular_volumen
  end

  def detalles_envio(id)
    @envios[id].obtener_detalle
  end

  def calcular_costo(id)
    @envios[id].calcular_costo
  end

  def envio_vacio(id)
    @envios[id].esta_vacio
  end

  def obtener_estado(id)
    @envios[id].obtener_estado
  end
end
