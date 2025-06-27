require 'sinatra'
require 'rack/utils'

require_relative './model/paqueteria'
require_relative './model/repositorio_envios_en_memoria'

BAD_REQUEST_CODE = Rack::Utils.status_code(:bad_request)
OK_CODE = Rack::Utils.status_code(:ok)

ENVIO_INEXISTENTE_DESCRIPCION = 'ENVIO_INEXISTENTE'.freeze
ENVIO_VACIO_DESCRIPCION = 'ENVIO_VACIO'.freeze
ENVIO_DEMASIADO_GRANDE_DESCRIPCION = 'ENVIO_DEMASIADO_GRANDE'.freeze
ENVIO_INVALIDO_DESCRIPCION = 'ENVIO_NO_VALIDO'.freeze
TIPO_PAQUETE_NO_VALIDO_DESCRIPCION = 'TIPO_PAQUETE_NO_VALIDO'.freeze
PAQUETE_PARAM_KEY = 'paquete'.freeze

repositorio_en_memoria = RepositorioEnviosEnMemoria.new

get '/cotizacion' do
  paqueteria = Paqueteria.new(repositorio_en_memoria)
  envio_id = paqueteria.crear_envio

  content_type :json
  {id: envio_id}.to_json
end

post '/cotizacion/:id' do
  request.body.rewind
  envio_id = params[:id]
  envio_id = envio_id.to_i

  parsed_body = JSON.parse(request.body.read)
  tipo_paquete = parsed_body[PAQUETE_PARAM_KEY]
  tipo_paquete = tipo_paquete.to_s

  paqueteria = Paqueteria.new(repositorio_en_memoria)
  paqueteria.agregar_paquete(envio_id, tipo_paquete)
  halt OK_CODE
rescue EnvioNoEncontradoException
  return halt BAD_REQUEST_CODE, {descripcion: ENVIO_INEXISTENTE_DESCRIPCION }.to_json
rescue TipoDePaqueteInexistenteException
  return halt BAD_REQUEST_CODE, {descripcion: TIPO_PAQUETE_NO_VALIDO_DESCRIPCION }.to_json
end

get '/cotizacion/:id/checkout' do
  envio_id = params[:id]
  envio_id = envio_id.to_i

  paqueteria = Paqueteria.new(repositorio_en_memoria)
  volumen = paqueteria.obtener_volumen_envio(envio_id)
  costo = paqueteria.cotizar_envio(envio_id)
  string = paqueteria.to_s(envio_id)

  content_type :json
  {envio: string, 'volumen-total': volumen, costo: costo.to_f}.to_json
rescue EnvioNoEncontradoException
  return halt BAD_REQUEST_CODE, {descripcion: ENVIO_INEXISTENTE_DESCRIPCION }.to_json
rescue EnvioVacioException
  return halt BAD_REQUEST_CODE, {descripcion: ENVIO_VACIO_DESCRIPCION }.to_json
rescue EnvioDemasiadoGrandeException
  return halt BAD_REQUEST_CODE, {descripcion: ENVIO_DEMASIADO_GRANDE_DESCRIPCION }.to_json
rescue EnvioInvalidoException
  return halt BAD_REQUEST_CODE, {descripcion: ENVIO_INVALIDO_DESCRIPCION }.to_json
end
