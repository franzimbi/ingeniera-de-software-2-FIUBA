ENV['APP_ENV'] = 'test'
require 'spec_helper'
require_relative '../app_web'
require 'rack/test'
require 'debug'

describe 'App web: propios' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def crear_envio
    get '/cotizacion'
    respuesta = JSON.parse(last_response.body)
    respuesta['id']
  end

  it "Puedo agregar 1 paquete T con POST /cotizacion" do
    envio_id = crear_envio
    post "/cotizacion/#{envio_id}", { paquete: 'T' }.to_json

    expect(last_response).to be_ok
  end

  it "Puedo agregar los paquetes [T,C,R] con POST /cotizacion" do
    envio_id = crear_envio
    post "/cotizacion/#{envio_id}", { paquete: 'T' }.to_json
    expect(last_response).to be_ok

    post "/cotizacion/#{envio_id}", { paquete: 'C' }.to_json
    expect(last_response).to be_ok

    post "/cotizacion/#{envio_id}", { paquete: 'R' }.to_json
    expect(last_response).to be_ok
  end

  it "No puedo agregar 1 paquete T a un envio con id no numerica. Termina con 400 Bad request" do
    envio_id_vacia = '-'
    post "/cotizacion/#{envio_id_vacia}", { paquete: 'T' }.to_json

    expect(last_response.status).to eq 400

    respuesta = JSON.parse(last_response.body)
    expect(respuesta['descripcion']).to eq 'ENVIO_INEXISTENTE'
  end

  it "No puedo agregar 1 paquete T a un envio con id inexistente. Termina con 400 Bad request" do
    envio_id_vacia = '999999999'
    post "/cotizacion/#{envio_id_vacia}", { paquete: 'T' }.to_json

    expect(last_response.status).to eq 400

    respuesta = JSON.parse(last_response.body)
    expect(respuesta['descripcion']).to eq 'ENVIO_INEXISTENTE'
  end

  it "Agregar los paquetes [T,C,R], el envio es correcto, tiene volumen 6 y cuesta 9" do
    envio_id = crear_envio
    post "/cotizacion/#{envio_id}", { paquete: 'T' }.to_json
    post "/cotizacion/#{envio_id}", { paquete: 'C' }.to_json
    post "/cotizacion/#{envio_id}", { paquete: 'R' }.to_json

    get "/cotizacion/#{envio_id}/checkout"
    expect(last_response).to be_ok

    respuesta = JSON.parse(last_response.body)
    expect(respuesta['envio']).to eq 'TCR'
    expect(respuesta['volumen-total']).to eq 6
    expect(respuesta['costo']).to eq 9
  end

  it "Hago checkout de los paquetes [T,C,R,C,C,C], el envio es correcto, tiene volumen 9 y cuesta 14" do
    envio_id = crear_envio
    post "/cotizacion/#{envio_id}", { paquete: 'T' }.to_json
    post "/cotizacion/#{envio_id}", { paquete: 'C' }.to_json
    post "/cotizacion/#{envio_id}", { paquete: 'R' }.to_json
    post "/cotizacion/#{envio_id}", { paquete: 'C' }.to_json
    post "/cotizacion/#{envio_id}", { paquete: 'C' }.to_json
    post "/cotizacion/#{envio_id}", { paquete: 'C' }.to_json

    get "/cotizacion/#{envio_id}/checkout"
    expect(last_response).to be_ok

    respuesta = JSON.parse(last_response.body)
    expect(respuesta['envio']).to eq 'TCRCCC'
    expect(respuesta['volumen-total']).to eq 9
    expect(respuesta['costo']).to eq 14
  end

  it "No puedo hacer checkout de un envio con id inexistente. Termina con 400 Bad requesty ENVIO_INEXISTENTE" do
    envio_id_vacia = '999999999'
    get "/cotizacion/#{envio_id_vacia}/checkout"

    expect(last_response.status).to eq 400

    respuesta = JSON.parse(last_response.body)
    expect(respuesta['descripcion']).to eq 'ENVIO_INEXISTENTE'
  end

  it "No puedo hacer checkout de un envio vacio. Termina con 400 Bad request y ENVIO_VACIO" do
    envio_id = crear_envio
    get "/cotizacion/#{envio_id}/checkout"

    expect(last_response.status).to eq 400

    respuesta = JSON.parse(last_response.body)
    expect(respuesta['descripcion']).to eq 'ENVIO_VACIO'
  end

  it "No puedo hacer checkout de un envio con volumen 12. Termina con 400 Bad request y ENVIO_DEMASIADO_GRANDE" do
    envio_id = crear_envio

    post "/cotizacion/#{envio_id}", { paquete: 'R' }.to_json
    post "/cotizacion/#{envio_id}", { paquete: 'R' }.to_json
    post "/cotizacion/#{envio_id}", { paquete: 'R' }.to_json
    post "/cotizacion/#{envio_id}", { paquete: 'R' }.to_json
    post "/cotizacion/#{envio_id}", { paquete: 'R' }.to_json
    post "/cotizacion/#{envio_id}", { paquete: 'C' }.to_json
    post "/cotizacion/#{envio_id}", { paquete: 'C' }.to_json

    get "/cotizacion/#{envio_id}/checkout"

    expect(last_response.status).to eq 400

    respuesta = JSON.parse(last_response.body)
    expect(respuesta['descripcion']).to eq 'ENVIO_DEMASIADO_GRANDE'
  end

  it "No puedo hacer checkout de un envio 9 paquetes. Termina con 400 Bad request y ENVIO_DEMASIADO_GRANDE" do
    envio_id = crear_envio

    post "/cotizacion/#{envio_id}", { paquete: 'C' }.to_json
    post "/cotizacion/#{envio_id}", { paquete: 'C' }.to_json
    post "/cotizacion/#{envio_id}", { paquete: 'C' }.to_json
    post "/cotizacion/#{envio_id}", { paquete: 'C' }.to_json
    post "/cotizacion/#{envio_id}", { paquete: 'C' }.to_json
    post "/cotizacion/#{envio_id}", { paquete: 'C' }.to_json
    post "/cotizacion/#{envio_id}", { paquete: 'C' }.to_json
    post "/cotizacion/#{envio_id}", { paquete: 'C' }.to_json
    post "/cotizacion/#{envio_id}", { paquete: 'C' }.to_json

    get "/cotizacion/#{envio_id}/checkout"

    expect(last_response.status).to eq 400

    respuesta = JSON.parse(last_response.body)
    expect(respuesta['descripcion']).to eq 'ENVIO_DEMASIADO_GRANDE'
  end

  it "No puedo hacer checkout de un envio con 2 T y un R. Termina con 400 Bad request y ENVIO_NO_VALIDO" do
    envio_id = crear_envio

    post "/cotizacion/#{envio_id}", { paquete: 'T' }.to_json
    post "/cotizacion/#{envio_id}", { paquete: 'T' }.to_json
    post "/cotizacion/#{envio_id}", { paquete: 'R' }.to_json

    get "/cotizacion/#{envio_id}/checkout"

    expect(last_response.status).to eq 400

    respuesta = JSON.parse(last_response.body)
    expect(respuesta['descripcion']).to eq 'ENVIO_NO_VALIDO'
  end

  it "No agregar un paquete de un tipo no valido. Termina con 400 Bad request y TIPO_PAQUETE_NO_VALIDO" do
    envio_id = crear_envio
    post "/cotizacion/#{envio_id}", { paquete: 'G' }.to_json

    expect(last_response.status).to eq 400

    respuesta = JSON.parse(last_response.body)
    expect(respuesta['descripcion']).to eq 'TIPO_PAQUETE_NO_VALIDO'
  end
end

class Respuesta
  attr_accessor :id, :costo, :status, :descripcion
end
