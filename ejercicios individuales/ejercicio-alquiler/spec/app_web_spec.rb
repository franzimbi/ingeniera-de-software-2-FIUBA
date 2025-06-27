ENV['APP_ENV'] = 'test'
require 'spec_helper'
require_relative '../app_web'
require 'rack/test'

describe 'App web' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'prueba por horas con cuit normal' do
    get '/alquiler?tipo=h&datos=3&cuit=20112223336'
    expect(last_response.status).to eq 200
    expected_response = { 'importe' => 297.0, 'ganancia' => 133.6 }.to_json
    expect(last_response.body).to eq(expected_response)
  end

  it 'prueba por horas con cuit de empresa' do
    get '/alquiler?tipo=h&datos=3&cuit=26112223336'
    expect(last_response.status).to eq 200
    expected_response = { 'importe' => 282.1, 'ganancia' => 126.9 }.to_json
    expect(last_response.body).to eq(expected_response)
  end

  it 'prueba por dia con cuit normal' do
    get '/alquiler?tipo=d&datos=1&cuit=2041836401'
    expect(last_response.status).to eq 200
    expected_response = { 'importe' => 2001.0, 'ganancia' => 900.4 }.to_json
    expect(last_response.body).to eq(expected_response)
  end

  it 'prueba por dia con cuit empresarial' do
    get '/alquiler?tipo=d&datos=1&cuit=2641836401'
    expect(last_response.status).to eq 200
    expected_response = { 'importe' => 1900.9, 'ganancia' => 855.4 }.to_json
    expect(last_response.body).to eq(expected_response)
  end

  it 'prueba por km con cuit normal' do
    get '/alquiler?tipo=k&datos=12&cuit=201111111'
    expect(last_response.status).to eq 200
    expected_response = { 'importe' => 220.0, 'ganancia' => 99.0 }.to_json
    expect(last_response.body).to eq(expected_response)
  end

  it 'prueba por dia con cuit empresarial' do
    get '/alquiler?tipo=k&datos=12&cuit=2641836401'
    expect(last_response.status).to eq 200
    expected_response = { 'importe' => 209.0, 'ganancia' => 94.0 }.to_json
    expect(last_response.body).to eq(expected_response)
  end

  it 'prueba para un tipo de alquiler invalido' do
    get '/alquiler?tipo=w&datos=12&cuit=2641836401'
    expect(last_response.status).to eq 400
  end

  it 'prueba con un cuit invalido' do
    get '/alquiler?tipo=h&datos=12&cuit=23gf43'
    expect(last_response.status).to eq 400
  end

  it 'prueba con datos invalido' do
    get '/alquiler?tipo=h&datos=1q0&cuit=2043434'
    expect(last_response.status).to eq 400
  end

end
