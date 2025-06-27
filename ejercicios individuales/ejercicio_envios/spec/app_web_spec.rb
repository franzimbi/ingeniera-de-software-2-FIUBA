ENV['APP_ENV'] = 'test'
require 'spec_helper'
require_relative '../app_web'
require 'rack/test'

describe 'App web' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'crear un envio devuelve 200 y un id 1' do
    get '/cotizacion'
    expect(last_response.status).to eq 200
    expected_response = { 'id' => 1}.to_json
    expect(last_response.body).to eq(expected_response)
  end

  it 'agregar un paquete cuadrado a un envio creado' do
    get '/cotizacion'
    expect(last_response.status).to eq 200
    response_body = JSON.parse(last_response.body)
    id = response_body['id']
    post "/cotizacion/#{id}", { paquete: "C" }.to_json, { "CONTENT_TYPE" => "application/json" }
    expect(last_response.status).to eq 200
  end

  it 'cotizar un envio de un cuadrado' do
    get '/cotizacion'
    expect(last_response.status).to eq 200
    response_body = JSON.parse(last_response.body)
    id = response_body['id']
    post "/cotizacion/#{id}", { paquete: "C" }.to_json, { "CONTENT_TYPE" => "application/json" }
    expect(last_response.status).to eq 200
    get "/cotizacion/#{id}/checkout"
    expected_response = { "envio" => "C", "volumen-total" => 1, "costo" => 2.2 }.to_json
    expect(last_response.body).to eq(expected_response)
  end

  it 'cotizar un envio de dos cuadrados' do
    get '/cotizacion'
    expect(last_response.status).to eq 200
    response_body = JSON.parse(last_response.body)
    id = response_body['id']
    post "/cotizacion/#{id}", { paquete: "C" }.to_json, { "CONTENT_TYPE" => "application/json" }
    expect(last_response.status).to eq 200
    post "/cotizacion/#{id}", { paquete: "C" }.to_json, { "CONTENT_TYPE" => "application/json" }
    expect(last_response.status).to eq 200
    get "/cotizacion/#{id}/checkout"
    expected_response = { "envio" => "CC", "volumen-total" => 2, "costo" => 4.4 }.to_json
    expect(last_response.body).to eq(expected_response)
  end

  it 'cotizar un envio de 6 cuadrados' do
    get '/cotizacion'
    expect(last_response.status).to eq 200
    response_body = JSON.parse(last_response.body)
    id = response_body['id']
    (0..5).each { |_|
      post "/cotizacion/#{id}", { paquete: "C" }.to_json, { "CONTENT_TYPE" => "application/json" }
      expect(last_response.status).to eq 200
    }
    get "/cotizacion/#{id}/checkout"
    expected_response = { "envio" => "CCCCCC", "volumen-total" => 6, "costo" => 9 }.to_json
    expect(last_response.body).to eq(expected_response)
  end

  it 'cotizar un envio de un paquete redondo' do
    get '/cotizacion'
    expect(last_response.status).to eq 200
    response_body = JSON.parse(last_response.body)
    id = response_body['id']
    post "/cotizacion/#{id}", { paquete: "R" }.to_json, { "CONTENT_TYPE" => "application/json" }
    expect(last_response.status).to eq 200
    get "/cotizacion/#{id}/checkout"
    expected_response = { "envio" => "R", "volumen-total" => 2, "costo" => 4.4 }.to_json
    expect(last_response.body).to eq(expected_response)
  end

  it 'cotizar un envio de un paquete triangular' do
    get '/cotizacion'
    expect(last_response.status).to eq 200
    response_body = JSON.parse(last_response.body)
    id = response_body['id']
    post "/cotizacion/#{id}", { paquete: "T" }.to_json, { "CONTENT_TYPE" => "application/json" }
    expect(last_response.status).to eq 200
    get "/cotizacion/#{id}/checkout"
    expected_response = { "envio" => "T", "volumen-total" => 3, "costo" => 3.3 }.to_json
    expect(last_response.body).to eq(expected_response)
  end

  it 'cotizar un envio con un paquete triangular y un cuadrado' do
    get '/cotizacion'
    expect(last_response.status).to eq 200
    response_body = JSON.parse(last_response.body)
    id = response_body['id']
    #
    post "/cotizacion/#{id}", { paquete: "T" }.to_json, { "CONTENT_TYPE" => "application/json" }
    expect(last_response.status).to eq 200
    #
    post "/cotizacion/#{id}", { paquete: "C" }.to_json, { "CONTENT_TYPE" => "application/json" }
    expect(last_response.status).to eq 200
    #
    get "/cotizacion/#{id}/checkout"
    expect(last_response.status).to eq 200
    expected_response = { "envio" => "TC", "volumen-total" => 4, "costo" => 5.5 }.to_json
    expect(last_response.body).to eq(expected_response)
  end

  it 'cotizar un envio vacio da error' do
    get '/cotizacion'
    expect(last_response.status).to eq 200
    response_body = JSON.parse(last_response.body)
    id = response_body['id']
    get "/cotizacion/#{id}/checkout"
    expect(last_response.status).to eq 400
    expected_response = { "descripcion" => "ENVIO_VACIO" }.to_json
    expect(last_response.body).to eq(expected_response)
  end

  it 'cotizar un envio con dos triangulos y un cuadrado da error' do
    get '/cotizacion'
    expect(last_response.status).to eq 200
    response_body = JSON.parse(last_response.body)
    id = response_body['id']
    #
    post "/cotizacion/#{id}", { paquete: "T" }.to_json, { "CONTENT_TYPE" => "application/json" }
    expect(last_response.status).to eq 200
    post "/cotizacion/#{id}", { paquete: "T" }.to_json, { "CONTENT_TYPE" => "application/json" }
    expect(last_response.status).to eq 200
    #
    post "/cotizacion/#{id}", { paquete: "C" }.to_json, { "CONTENT_TYPE" => "application/json" }
    expect(last_response.status).to eq 200
    #
    get "/cotizacion/#{id}/checkout"
    expect(last_response.status).to eq 400
    expected_response = { "descripcion" => "ENVIO_NO_VALIDO" }.to_json
    expect(last_response.body).to eq(expected_response)
  end

  it 'envio con mas de 8 paquetes es demasiados grande' do
    get '/cotizacion'
    expect(last_response.status).to eq 200
    response_body = JSON.parse(last_response.body)
    id = response_body['id']
    #
    (0..8).each { |_|
      post "/cotizacion/#{id}", { paquete: "C" }.to_json, { "CONTENT_TYPE" => "application/json" }
      expect(last_response.status).to eq 200
    }
    get "/cotizacion/#{id}/checkout"
    expect(last_response.status).to eq 400
    expected_response = { "descripcion" => "ENVIO_DEMASIADO_GRANDE" }.to_json
    expect(last_response.body).to eq(expected_response)
  end

  it 'envio con menos de 5 litros tiene recargo' do
    get '/cotizacion'
    expect(last_response.status).to eq 200
    response_body = JSON.parse(last_response.body)
    id = response_body['id']
    post "/cotizacion/#{id}", { paquete: "C" }.to_json, { "CONTENT_TYPE" => "application/json" }
    expect(last_response.status).to eq 200
    get "/cotizacion/#{id}/checkout"
    expected_response = { "envio" => "C", "volumen-total" => 1, "costo" => 2.2 }.to_json
    expect(last_response.body).to eq(expected_response)
  end

  it 'envio con mas de 10 litros es demasiado grande' do
    get '/cotizacion'
    expect(last_response.status).to eq 200
    response_body = JSON.parse(last_response.body)
    id = response_body['id']
    #
    (0..3).each { |_|
      post "/cotizacion/#{id}", { paquete: "T" }.to_json, { "CONTENT_TYPE" => "application/json" }
      expect(last_response.status).to eq 200
    }
    get "/cotizacion/#{id}/checkout"
    expect(last_response.status).to eq 400
    expected_response = { "descripcion" => "ENVIO_DEMASIADO_GRANDE" }.to_json
    expect(last_response.body).to eq(expected_response)
  end

  it 'envio con un paquete invalido devuelve estado 400' do
    get '/cotizacion'
    expect(last_response.status).to eq 200
    response_body = JSON.parse(last_response.body)
    id = response_body['id']
    post "/cotizacion/#{id}", { paquete: "Q" }.to_json, { "CONTENT_TYPE" => "application/json" }
    expect(last_response.status).to eq 400
  end

  it 'agregar a un envio invalido negativo devuelve estado 400' do
    post "/cotizacion/-1", { paquete: "C" }.to_json, { "CONTENT_TYPE" => "application/json" }
    expect(last_response.status).to eq 400
  end

  # pruebas de la catedra:
  def enviar(paquetes)
    # crear envio
    get '/cotizacion'
    respuesta_json = JSON.parse(last_response.body)
    expect(last_response.status).to eq 200
    respuesta = Respuesta.new
    respuesta.id = respuesta_json['id']
    paquetes.each do |paquete|
      # agregar paquete al envio
      post "/cotizacion/#{respuesta.id}", { paquete: paquete }.to_json, { "CONTENT_TYPE" => "application/json" }
      expect(last_response.status).to eq 200
    end
    # cotizar envio
    get "/cotizacion/#{respuesta.id}/checkout"
    respuesta_json = JSON.parse(last_response.body)
    if last_response.status == 200
      expect(last_response.status).to eq 200
      respuesta.costo = respuesta_json['costo'].to_f
    else
      respuesta.descripcion = respuesta_json['descripcion']
    end
    respuesta.status = last_response.status
    respuesta
  end

  it 'c1: envio con un paquete cuadrado' do
    resultado = enviar(['C'])
    expect(resultado.status).to eq 200
    expect(resultado.costo).to eq 2.2
  end

  it 'c2: envio con un 6 paquetes cuadrados' do
    resultado = enviar(['C','C','C','C','C','C'])
    expect(resultado.status).to eq 200
    expect(resultado.costo).to eq 9
  end

  it 'r1: envio con un paquete redondo' do
    resultado = enviar(['R'])
    expect(resultado.status).to eq 200
    expect(resultado.costo).to eq 4.4
  end

  it 't1: envio con un paquete triangular cuesta' do
    resultado = enviar(['T'])
    expect(resultado.status).to eq 200
    expect(resultado.costo).to eq 3.3
  end

  it 't2: envio con un paquete triangular y uno redondo cuesta' do
    resultado = enviar(['T','R'])
    expect(resultado.status).to eq 200
    expect(resultado.costo).to eq 7
  end

  it 'e1: envio vacio no es valido' do
    resultado = enviar([])
    expect(resultado.status).to eq 400
    expect(resultado.descripcion).to eq 'ENVIO_VACIO'
  end

  it 'e2: envio con dos paquetes triangulares y un paquete cuadradro ErrorEnvioNoValido' do
    resultado = enviar(['T','T','C'])
    expect(resultado.status).to eq 400
    expect(resultado.descripcion).to eq 'ENVIO_NO_VALIDO'
  end

  it 'e3: envio con mas de 8 paquetes no es valido' do
    resultado = enviar(['C','C','C','C','C','C','C','C','C'])
    expect(resultado.status).to eq 400
    expect(resultado.descripcion).to eq 'ENVIO_DEMASIADO_GRANDE'
  end

  it 'e4: envio inexistente' do
    post '/cotizacion/id-inexistente', { paquete: 'C' }.to_json, { "CONTENT_TYPE" => "application/json" }
    response_json = JSON.parse(last_response.body)
    expect(last_response.status).to eq 400
    expect(response_json['descripcion']).to eq 'ENVIO_INEXISTENTE'
  end

  it 'e5: tipo de paquete no valido' do
    get '/cotizacion'
    respuesta_json = JSON.parse(last_response.body)
    expect(last_response.status).to eq 200
    id_envio = respuesta_json['id']
    post "/cotizacion/#{id_envio}", { paquete: 'B' }.to_json, { "CONTENT_TYPE" => "application/json" }
    response_json = JSON.parse(last_response.body)
    expect(last_response.status).to eq 400
    expect(response_json['descripcion']).to eq 'TIPO_PAQUETE_NO_VALIDO'
  end

  it 'e6: envio con volumen mayor a 10 es demasiado grande' do
    resultado = enviar(['T','T','T','T'])
    expect(resultado.status).to eq 400
    expect(resultado.descripcion).to eq 'ENVIO_DEMASIADO_GRANDE'
  end

end

class Respuesta
  attr_accessor :id, :costo, :status, :descripcion
end

