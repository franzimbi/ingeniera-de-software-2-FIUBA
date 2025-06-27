require_relative './envio'
require_relative './exceptions/envio_no_encontrado_exception'

class RepositorioEnviosEnMemoria
  PRIMER_ID = 1

  def initialize
    @ultimo_id = PRIMER_ID
    @envios = {}
  end

  def incrementar_id
    @ultimo_id += 1
  end

  def crear_envio
    envio_id = @ultimo_id
    envio = Envio.new envio_id
    @envios[envio_id] = envio

    incrementar_id

    envio_id
  end

  def obtener_envio_por_id(envio_id)
    raise EnvioNoEncontradoException unless @envios.key?(envio_id)

    @envios[envio_id]
  end

  private :incrementar_id
end
