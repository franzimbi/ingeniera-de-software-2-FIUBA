require 'spec_helper'

require_relative '../model/repositorio_envios_en_memoria'

describe 'RepositorioEnviosEnMemoria' do

  it 'Creo un Envio en el repositorio y tiene un id 1' do
    memoria = RepositorioEnviosEnMemoria.new
    envio_id = memoria.crear_envio

    expect(envio_id).to eq 1
  end

  it 'Creo tres Envios en el repositorio y tienen id 1, 2 y 3' do
    memoria = RepositorioEnviosEnMemoria.new
    envio_1_id = memoria.crear_envio
    envio_2_id = memoria.crear_envio
    envio_3_id = memoria.crear_envio

    expect(envio_1_id).to eq 1
    expect(envio_2_id).to eq 2
    expect(envio_3_id).to eq 3
  end

  it 'Creo dos Envio en el repositorio y puedo obtener el primer envio por id' do
    memoria = RepositorioEnviosEnMemoria.new
    envio_id = memoria.crear_envio
    memoria.crear_envio
    envio_buscado = memoria.obtener_envio_por_id(envio_id)

    expect(envio_buscado.id).to eq envio_id
  end

  it 'Creo dos Envio en el repositorio y puedo obtener el primer envio por id' do
    memoria = RepositorioEnviosEnMemoria.new
    envio_id = memoria.crear_envio
    memoria.crear_envio
    envio_buscado = memoria.obtener_envio_por_id(envio_id)

    expect(envio_buscado.id).to eq envio_id
  end

  it 'No puedo obtener un id de un envio inexistente' do
    memoria = RepositorioEnviosEnMemoria.new
    memoria.crear_envio
    memoria.crear_envio
    memoria.crear_envio

    envio_id_inexistente = 5

    expect {
      memoria.obtener_envio_por_id(envio_id_inexistente)
    }.to raise_error(EnvioNoEncontradoException)
  end

  it 'No puedo obtener un id de un envio con el repositorio vacío' do
    memoria = RepositorioEnviosEnMemoria.new

    envio_id_inexistente = 0

    expect {
      memoria.obtener_envio_por_id(envio_id_inexistente)
    }.to raise_error(EnvioNoEncontradoException)
  end
end
