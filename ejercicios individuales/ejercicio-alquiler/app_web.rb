require_relative './model/rental'
require 'sinatra'

get '/' do
  'rental web app'
end

get '/alquiler' do
  tipo = params['tipo']
  return halt 400, 'type invalido' unless %w[h d k].include? tipo

  begin
    datos = Integer(params['datos'])
    cuit = Integer(params['cuit'])
  rescue ArgumentError
    return halt 400, 'datos o cuit no es un numero'
  end

  result = Rental.new.calculate(tipo, datos, cuit)
  { 'importe' => result[0], 'ganancia' => result[1] }.to_json
end
