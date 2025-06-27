require 'spec_helper'

require_relative '../model/repositorio_envios_en_memoria'
require_relative '../model/paqueteria'
require_relative '../model/envio'
require_relative '../model/exceptions/envio_no_encontrado_exception'
require_relative '../model/exceptions/envio_vacio_exception'
require_relative '../model/exceptions/envio_demasiado_grande_exception'
require_relative '../model/exceptions/envio_invalido_exception'
require_relative '../model/exceptions/tipo_de_paquete_inexistente_exception'

describe 'Paqueteria' do

  it 'Un Envío de 1 PaqueteRedondo con la Paqueteria usando repositorio en memoria cuesta 4.4' do
    repositorio_en_memoria = RepositorioEnviosEnMemoria.new
    paqueteria = Paqueteria.new repositorio_en_memoria
    envio_id = paqueteria.crear_envio

    paqueteria.agregar_paquete(envio_id, 'R')

    costo = paqueteria.cotizar_envio(envio_id)

    expect(costo).to eq 4.4
  end

  it 'Un Envío de 2 PaqueteRedondo con la Paqueteria usando repositorio en memoria cuesta 8.8' do
    repositorio_en_memoria = RepositorioEnviosEnMemoria.new
    paqueteria = Paqueteria.new repositorio_en_memoria
    envio_id = paqueteria.crear_envio

    paqueteria.agregar_paquete(envio_id, 'R')
    paqueteria.agregar_paquete(envio_id, 'R')

    costo = paqueteria.cotizar_envio(envio_id)

    expect(costo).to eq 8.8
  end

  it 'Un Envío de 1 PaqueteTriangular con la Paqueteria usando repositorio en memoria cuesta 3.3' do
    repositorio_en_memoria = RepositorioEnviosEnMemoria.new
    paqueteria = Paqueteria.new repositorio_en_memoria
    envio_id = paqueteria.crear_envio

    paqueteria.agregar_paquete(envio_id, 'T')

    costo = paqueteria.cotizar_envio(envio_id)

    expect(costo).to eq 3.3
  end

  it 'Un Envío de 1 PaqueteTriangular y 1 PaqueteRedondo con la Paqueteria usando repositorio en memoria cuesta 7' do
    repositorio_en_memoria = RepositorioEnviosEnMemoria.new
    paqueteria = Paqueteria.new repositorio_en_memoria
    envio_id = paqueteria.crear_envio

    paqueteria.agregar_paquete(envio_id, 'T')
    paqueteria.agregar_paquete(envio_id, 'R')

    costo = paqueteria.cotizar_envio(envio_id)

    expect(costo).to eq 7
  end

  it 'Un Envío de 1 PaqueteCuadrado con la Paqueteria usando repositorio en memoria cuesta 2.2' do
    repositorio_en_memoria = RepositorioEnviosEnMemoria.new
    paqueteria = Paqueteria.new repositorio_en_memoria
    envio_id = paqueteria.crear_envio

    paqueteria.agregar_paquete(envio_id, 'C')

    costo = paqueteria.cotizar_envio(envio_id)

    expect(costo).to eq 2.2
  end

  it 'Un Envío de 2 PaqueteCuadrado con la Paqueteria usando repositorio en memoria cuesta 4.4' do
    repositorio_en_memoria = RepositorioEnviosEnMemoria.new
    paqueteria = Paqueteria.new repositorio_en_memoria
    envio_id = paqueteria.crear_envio

    paqueteria.agregar_paquete(envio_id, 'C')
    paqueteria.agregar_paquete(envio_id, 'C')

    costo = paqueteria.cotizar_envio(envio_id)

    expect(costo).to eq 4.4
  end

  it 'Un Envío de 3 PaqueteCuadrado con la Paqueteria usando repositorio en memoria cuesta 6.6' do
    repositorio_en_memoria = RepositorioEnviosEnMemoria.new
    paqueteria = Paqueteria.new repositorio_en_memoria
    envio_id = paqueteria.crear_envio

    paqueteria.agregar_paquete(envio_id, 'C')
    paqueteria.agregar_paquete(envio_id, 'C')
    paqueteria.agregar_paquete(envio_id, 'C')

    costo = paqueteria.cotizar_envio(envio_id)

    expect(costo).to eq 6.6
  end

  it 'Un Envío de 4 PaqueteCuadrado con la Paqueteria usando repositorio en memoria cuesta 7.7' do
    repositorio_en_memoria = RepositorioEnviosEnMemoria.new
    paqueteria = Paqueteria.new repositorio_en_memoria
    envio_id = paqueteria.crear_envio

    paqueteria.agregar_paquete(envio_id, 'C')
    paqueteria.agregar_paquete(envio_id, 'C')
    paqueteria.agregar_paquete(envio_id, 'C')
    paqueteria.agregar_paquete(envio_id, 'C')

    costo = paqueteria.cotizar_envio(envio_id)

    expect(costo).to eq 7.7
  end

  it 'Un Envío de 4 PaqueteCuadrado, 1 PaqueteTriangular con la Paqueteria usando repositorio en memoria cuesta 14' do
    repositorio_en_memoria = RepositorioEnviosEnMemoria.new
    paqueteria = Paqueteria.new repositorio_en_memoria
    envio_id = paqueteria.crear_envio

    (1..4).to_a.each do ||
      paqueteria.agregar_paquete(envio_id, 'C')
    end

    paqueteria.agregar_paquete(envio_id, 'T')
    paqueteria.agregar_paquete(envio_id, 'R')
    
    costo = paqueteria.cotizar_envio(envio_id)

    expect(costo).to eq 14
  end

  it 'No puedo agregar un paquete a un envio de id inexistente en una Paqueteria usando repositorio en memoria' do
    repositorio_en_memoria = RepositorioEnviosEnMemoria.new
    paqueteria = Paqueteria.new repositorio_en_memoria

    paqueteria.crear_envio
    paqueteria.crear_envio
    paqueteria.crear_envio

    envio_id_inexistente = 5

    expect {
      paqueteria.agregar_paquete(envio_id_inexistente, 'C')
    }.to raise_error(EnvioNoEncontradoException)
  end

  it 'No puedo agregar un paquete a un envio de id inexistente en una Paqueteria vacía usando repositorio en memoria' do
    repositorio_en_memoria = RepositorioEnviosEnMemoria.new
    paqueteria = Paqueteria.new repositorio_en_memoria

    envio_id_inexistente = 0

    expect {
      paqueteria.agregar_paquete(envio_id_inexistente, 'C')
    }.to raise_error(EnvioNoEncontradoException)
  end


  it 'El volumen de un Envío de un PaqueteRedondo con la Paqueteria usando repositorio en memoria es 2' do
    repositorio_en_memoria = RepositorioEnviosEnMemoria.new
    paqueteria = Paqueteria.new repositorio_en_memoria
    envio_id = paqueteria.crear_envio

    paqueteria.agregar_paquete(envio_id, 'R')

    volumen = paqueteria.obtener_volumen_envio(envio_id)

    expect(volumen).to eq 2
  end

  it 'No puedo calcular el volumen de un envio de id inexistente en una Paqueteria usando repositorio en memoria' do
    repositorio_en_memoria = RepositorioEnviosEnMemoria.new
    paqueteria = Paqueteria.new repositorio_en_memoria
    envio_id_inexistente = 5

    expect {
      paqueteria.obtener_volumen_envio(envio_id_inexistente)
    }.to raise_error(EnvioNoEncontradoException)
  end

  it 'No puedo cotizar un Envío vacío con la Paqueteria usando repositorio en memoria' do
    repositorio_en_memoria = RepositorioEnviosEnMemoria.new
    paqueteria = Paqueteria.new repositorio_en_memoria
    envio_id = paqueteria.crear_envio

    expect {
      paqueteria.cotizar_envio(envio_id)
    }.to raise_error(EnvioVacioException)
  end

  it 'No puedo cotizar un Envío que tiene 9 paquetes de un tipo con la Paqueteria usando repositorio en memoria' do
    repositorio_en_memoria = RepositorioEnviosEnMemoria.new
    paqueteria = Paqueteria.new repositorio_en_memoria
    envio_id = paqueteria.crear_envio

    (1..9).to_a.each do ||
      paqueteria.agregar_paquete(envio_id, 'C')
    end

    expect {
      paqueteria.cotizar_envio(envio_id)
    }.to raise_error(EnvioDemasiadoGrandeException)
  end

  it 'No puedo cotizar un Envío que tiene 9 paquetes de distinto tipo con la Paqueteria usando repositorio en memoria' do
    repositorio_en_memoria = RepositorioEnviosEnMemoria.new
    paqueteria = Paqueteria.new repositorio_en_memoria
    envio_id = paqueteria.crear_envio

    (1..8).to_a.each do ||
      paqueteria.agregar_paquete(envio_id, 'C')
    end

    paqueteria.agregar_paquete(envio_id, 'R')

    expect {
      paqueteria.cotizar_envio(envio_id)
    }.to raise_error(EnvioDemasiadoGrandeException)
  end

  it 'No puedo cotizar un Envío que tiene volumen 12 la Paqueteria usando repositorio en memoria' do
    repositorio_en_memoria = RepositorioEnviosEnMemoria.new
    paqueteria = Paqueteria.new repositorio_en_memoria
    envio_id = paqueteria.crear_envio

    paqueteria.agregar_paquete(envio_id, 'R')
    paqueteria.agregar_paquete(envio_id, 'R')
    paqueteria.agregar_paquete(envio_id, 'R')
    paqueteria.agregar_paquete(envio_id, 'R')
    paqueteria.agregar_paquete(envio_id, 'R')

    paqueteria.agregar_paquete(envio_id, 'C')
    paqueteria.agregar_paquete(envio_id, 'C')

    expect {
      paqueteria.cotizar_envio(envio_id)
    }.to raise_error(EnvioDemasiadoGrandeException)
  end

  it 'Puedo cotizar un Envío que tiene 8 PaquetesCuadrados (cumplen volumen <= 10)' do
    repositorio_en_memoria = RepositorioEnviosEnMemoria.new
    paqueteria = Paqueteria.new repositorio_en_memoria
    envio_id = paqueteria.crear_envio

    (1..8).to_a.each do ||
      paqueteria.agregar_paquete(envio_id, 'C')
    end

    expect(paqueteria.cotizar_envio(envio_id)).to eq 11
  end

  it 'Un Envío de 2 PaqueteTriangulares con la Paqueteria usando repositorio en memoria cuesta 6' do
    repositorio_en_memoria = RepositorioEnviosEnMemoria.new
    paqueteria = Paqueteria.new repositorio_en_memoria
    envio_id = paqueteria.crear_envio

    paqueteria.agregar_paquete(envio_id, 'T')
    paqueteria.agregar_paquete(envio_id, 'T')

    costo = paqueteria.cotizar_envio(envio_id)

    expect(costo).to eq 6
  end

  it 'Un Envío de 3 PaqueteTriangulares con la Paqueteria usando repositorio en memoria cuesta 6' do
    repositorio_en_memoria = RepositorioEnviosEnMemoria.new
    paqueteria = Paqueteria.new repositorio_en_memoria
    envio_id = paqueteria.crear_envio

    (1..3).each do ||
      paqueteria.agregar_paquete(envio_id, 'T')
    end

    costo = paqueteria.cotizar_envio(envio_id)

    expect(costo).to eq 9
  end

  it 'No puedo cotizar un Envío de 2 PaqueteTriangulares con 1 PaqueteRedondo con la Paqueteria usando repositorio en memoria' do
    repositorio_en_memoria = RepositorioEnviosEnMemoria.new
    paqueteria = Paqueteria.new repositorio_en_memoria
    envio_id = paqueteria.crear_envio

    paqueteria.agregar_paquete(envio_id, 'T')
    paqueteria.agregar_paquete(envio_id, 'T')
    paqueteria.agregar_paquete(envio_id, 'R')

    expect {
      paqueteria.cotizar_envio(envio_id)
    }.to raise_error(EnvioInvalidoException)
  end

  it 'No puedo agregar un tipo de paquete que no existe con la Paqueteria usando repositorio en memoria' do
    repositorio_en_memoria = RepositorioEnviosEnMemoria.new
    paqueteria = Paqueteria.new repositorio_en_memoria
    envio_id = paqueteria.crear_envio

    expect {
      paqueteria.agregar_paquete(envio_id, 'Q')
    }.to raise_error(TipoDePaqueteInexistenteException)
  end

  it 'Un Envío de 1 PaqueteRedondo y 1 PaqueteTriangular con la Paqueteria usando repositorio en memoria cuesta 7 (volumen 5, no hay recargo)' do
    repositorio_en_memoria = RepositorioEnviosEnMemoria.new
    paqueteria = Paqueteria.new repositorio_en_memoria
    envio_id = paqueteria.crear_envio

    paqueteria.agregar_paquete(envio_id, 'T')
    paqueteria.agregar_paquete(envio_id, 'R')

    costo = paqueteria.cotizar_envio(envio_id)

    expect(costo).to eq 7
  end

  it 'Un Envío de 1 PaqueteCuadrado con la Paqueteria usando repositorio en memoria cuesta 2 (volumen 1, hay recargo)' do
    repositorio_en_memoria = RepositorioEnviosEnMemoria.new
    paqueteria = Paqueteria.new repositorio_en_memoria
    envio_id = paqueteria.crear_envio

    paqueteria.agregar_paquete(envio_id, 'C')

    costo = paqueteria.cotizar_envio(envio_id)

    expect(costo).to eq 2.2
  end

  it 'Un Envío de 1 PaqueteRedondo con la Paqueteria usando repositorio en memoria convertido a string es R' do
    repositorio_en_memoria = RepositorioEnviosEnMemoria.new
    paqueteria = Paqueteria.new repositorio_en_memoria
    envio_id = paqueteria.crear_envio

    paqueteria.agregar_paquete(envio_id, 'R')

    string = paqueteria.to_s(envio_id)
    expect(string).to eq 'R'
  end

  it 'Un Envio insertado en orden [T,C,R,R,C] con la Paqueteria usando repositorio en memoria convertido a string es TCRRC' do
    repositorio_en_memoria = RepositorioEnviosEnMemoria.new
    paqueteria = Paqueteria.new repositorio_en_memoria
    envio_id = paqueteria.crear_envio

    paqueteria.agregar_paquete(envio_id, 'T')
    paqueteria.agregar_paquete(envio_id, 'C')
    paqueteria.agregar_paquete(envio_id, 'R')
    paqueteria.agregar_paquete(envio_id, 'R')
    paqueteria.agregar_paquete(envio_id, 'C')

    string = paqueteria.to_s(envio_id)
    expect(string).to eq 'TCRRC'
  end

  it 'Un Envío de 1 PaqueteRectangular con la Paqueteria usando repositorio en memoria cuesta 2.2' do
    repositorio_en_memoria = RepositorioEnviosEnMemoria.new
    paqueteria = Paqueteria.new repositorio_en_memoria
    envio_id = paqueteria.crear_envio

    paqueteria.agregar_paquete(envio_id, 'E')

    costo = paqueteria.cotizar_envio(envio_id)

    expect(costo).to eq 2.2
  end

  it 'Un Envío de 1 PaqueteRectangular con la Paqueteria usando repositorio en memoria convertido a string es E' do
    repositorio_en_memoria = RepositorioEnviosEnMemoria.new
    paqueteria = Paqueteria.new repositorio_en_memoria
    envio_id = paqueteria.crear_envio

    paqueteria.agregar_paquete(envio_id, 'E')

    string = paqueteria.to_s(envio_id)
    expect(string).to eq 'E'
  end

  it 'calculo volumen de un Envío con 11 de volumen' do
    repositorio_en_memoria = RepositorioEnviosEnMemoria.new
    paqueteria = Paqueteria.new repositorio_en_memoria
    envio_id = paqueteria.crear_envio

    paqueteria.agregar_paquete(envio_id, 'E')
    paqueteria.agregar_paquete(envio_id, 'E')
    #
    paqueteria.agregar_paquete(envio_id, 'C')
    paqueteria.agregar_paquete(envio_id, 'C')
    paqueteria.agregar_paquete(envio_id, 'C')


    volumen = paqueteria.obtener_volumen_envio(envio_id)

    expect(volumen).to eq 11
  end

  it 'cotizo de un Envío con 11 de volumen' do
    repositorio_en_memoria = RepositorioEnviosEnMemoria.new
    paqueteria = Paqueteria.new repositorio_en_memoria
    envio_id = paqueteria.crear_envio

    paqueteria.agregar_paquete(envio_id, 'E')
    paqueteria.agregar_paquete(envio_id, 'E')
    #
    paqueteria.agregar_paquete(envio_id, 'C')
    paqueteria.agregar_paquete(envio_id, 'C')
    paqueteria.agregar_paquete(envio_id, 'C')


    costo = paqueteria.cotizar_envio(envio_id)

    expect(costo).to eq 10
  end

end
