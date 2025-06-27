require_relative './model/sistema_envios'
require 'sinatra'

get '/' do
  'inversor web app'
end

sistema = SistemaEnvios.new

get '/cotizacion' do
  # return halt 400, 'entrada invalida' if texto.nil? || texto.empty?
  id = sistema.crear_envio
  status 200
  return {'id' => id}.to_json
end

post '/cotizacion/:id' do
  id = params['id'].to_i
  request_payload = begin
    JSON.parse(request.body.read)
  rescue StandardError
    {}
  end
  paquete = request_payload['paquete']
  unless %w[R C T].include?(paquete)
    status 400
    return { 'descripcion' => 'TIPO_PAQUETE_NO_VALIDO' }.to_json
  end
  begin
    sistema.agregar_paquete(id, paquete)
  rescue ArgumentError => _e
    status 400
    return { 'descripcion' => 'ENVIO_INEXISTENTE' }.to_json
  end
  status 200
end

get '/cotizacion/:id/checkout' do
  id = params['id'].to_i
  estado = sistema.obtener_estado(id)
  if estado.esta_vacio
    status 400
    return { 'descripcion' => 'ENVIO_VACIO' }.to_json
  elsif estado.es_grande
    status 400
    return { 'descripcion' => 'ENVIO_DEMASIADO_GRANDE' }.to_json
  elsif !estado.es_valido
    status 400
    return { 'descripcion' => 'ENVIO_NO_VALIDO' }.to_json
  end
  detalles = sistema.detalles_envio(id)
  {'envio' => detalles, 'volumen-total' => estado.obtener_volumen,
   'costo' => estado.obtener_costo}.to_json
end
