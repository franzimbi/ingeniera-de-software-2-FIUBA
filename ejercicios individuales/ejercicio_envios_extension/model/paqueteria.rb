require_relative './envio'
require_relative './paquete/paquete_simple_factory'

class Paqueteria
  def initialize(repositorio_envios)
    @repositorio_envios = repositorio_envios
    @paquete_factory = PaqueteSimpleFactory.new
  end

  def crear_envio
    @repositorio_envios.crear_envio
  end

  def agregar_paquete(envio_id, tipo)
    envio = @repositorio_envios.obtener_envio_por_id(envio_id)
    paquete = @paquete_factory.crear_paquete(tipo, envio.paquetes_lista)
    envio.agregar_paquete(paquete)
  end

  def cotizar_envio(envio_id)
    envio = @repositorio_envios.obtener_envio_por_id(envio_id)
    envio.cotizar
  end

  def obtener_volumen_envio(envio_id)
    envio = @repositorio_envios.obtener_envio_por_id(envio_id)
    envio.calcular_volumen
  end

  def to_s(envio_id)
    envio = @repositorio_envios.obtener_envio_por_id(envio_id)
    envio.to_s
  end
end
