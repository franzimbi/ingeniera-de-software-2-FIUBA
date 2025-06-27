require 'spec_helper'

require_relative '../model/envio'
require_relative '../model/paquete/paquete_simple_factory'
require_relative '../model/exceptions/envio_demasiado_grande_exception'
require_relative '../model/exceptions/envio_invalido_exception'

describe 'Envio' do

  it 'Creo un Envio con id 0 y tiene id 0' do
    envio = Envio.new(0)

    expect(envio.id).to eq 0
  end

  it 'Creo un Envio con id 1 y tiene id 1' do
    envio = Envio.new(1)

    expect(envio.id).to eq 1
  end

  it 'A un Envio con id 1 le agrego 1 PaqueteRedondo y cuesta 4.4' do
    envio = Envio.new(1)
    paquete_redondo = PaqueteSimpleFactory.new.crear_paquete('R', envio.paquetes_lista)
    envio.agregar_paquete(paquete_redondo)

    expect(envio.cotizar).to eq 4.4
  end

  it 'A un Envio con id 1 le agrego 2 PaqueteRedondo y cuesta 8.8' do
    envio = Envio.new(1)

    (1..2).to_a.each do ||
      paquete_redondo = PaqueteSimpleFactory.new.crear_paquete('R', envio.paquetes_lista)
      envio.agregar_paquete(paquete_redondo)
    end

    expect(envio.cotizar).to eq 8.8
  end

  it 'A un Envio con id 1 le agrego 2 PaqueteRedondo y 1 PaqueteTriangular y cuesta 11' do
    envio = Envio.new(1)
    paquete_triangular = PaqueteSimpleFactory.new.crear_paquete('T', envio.paquetes_lista)
    envio.agregar_paquete(paquete_triangular)

    (1..2).to_a.each do ||
      paquete_redondo = PaqueteSimpleFactory.new.crear_paquete('R', envio.paquetes_lista)
      envio.agregar_paquete(paquete_redondo)
    end

    expect(envio.cotizar).to eq 11
  end

  it 'A un Envio con id 1 le agrego 2 PaqueteCuadrados y cuesta 4.4' do
    envio = Envio.new(1)

    (1..2).to_a.each do ||
      paquete_cuadrado = PaqueteSimpleFactory.new.crear_paquete('C', envio.paquetes_lista)
      envio.agregar_paquete(paquete_cuadrado)
    end

    expect(envio.cotizar).to eq 4.4
  end

  it 'A un Envio con id 1 le agrego 3 PaqueteCuadrados y cuesta 6.6' do
    envio = Envio.new(1)

    (1..3).to_a.each do ||
      paquete_cuadrado = PaqueteSimpleFactory.new.crear_paquete('C', envio.paquetes_lista)
      envio.agregar_paquete(paquete_cuadrado)
    end

    expect(envio.cotizar).to eq 6.6
  end

  it 'A un Envio con id 1 le agrego 4 PaqueteCuadrados y cuesta 7.7' do
    envio = Envio.new(1)

    (1..4).to_a.each do ||
      paquete_cuadrado = PaqueteSimpleFactory.new.crear_paquete('C', envio.paquetes_lista)
      envio.agregar_paquete(paquete_cuadrado)
    end

    expect(envio.cotizar).to eq 7.7
  end

  it 'A un Envio con id 1 le agrego 4 PaqueteCuadrados, 1 PaqueteTriangular y 1 PaqueteRedondos y cuesta 14' do
    envio = Envio.new(1)

    paquete_triangular = PaqueteSimpleFactory.new.crear_paquete('T', envio.paquetes_lista)
    envio.agregar_paquete(paquete_triangular)

    paquete_redondo = PaqueteSimpleFactory.new.crear_paquete('R', envio.paquetes_lista)
    envio.agregar_paquete(paquete_redondo)

    (1..4).to_a.each do ||
      paquete_cuadrado = PaqueteSimpleFactory.new.crear_paquete('C', envio.paquetes_lista)
      envio.agregar_paquete(paquete_cuadrado)
    end

    expect(envio.cotizar).to eq 14
  end

  it 'Agrego un PaqueteRedondo y 5 PaqueteCuadrados a un Envio y tiene volumen 7' do
    envio = Envio.new(1)
    paquete_redondo = PaqueteSimpleFactory.new.crear_paquete('R', envio.paquetes_lista)
    envio.agregar_paquete(paquete_redondo)

    (1..5).to_a.each do ||
      paquete_cuadrado = PaqueteSimpleFactory.new.crear_paquete('C', envio.paquetes_lista)
      envio.agregar_paquete(paquete_cuadrado)
    end

    expect(envio.calcular_volumen).to eq 7
  end

  it 'Agrego un PaqueteRedondo y un PaqueteTriangular a un Envio y tiene volumen 5' do
    envio = Envio.new(1)
    paquete_redondo = PaqueteSimpleFactory.new.crear_paquete('R', envio.paquetes_lista)
    paquete_triangular = PaqueteSimpleFactory.new.crear_paquete('T', envio.paquetes_lista)

    envio.agregar_paquete(paquete_redondo)
    envio.agregar_paquete(paquete_triangular)

    expect(envio.calcular_volumen).to eq 5
  end

  it 'No puedo cotizar un Envío vacío' do
    envio = Envio.new(1)

    expect {
      envio.cotizar
    }.to raise_error(EnvioVacioException)
  end

  it 'No puedo cotizar un Envío que tiene 9 paquetes' do
    envio = Envio.new(1)

    (1..9).to_a.each do ||
      paquete_redondo = PaqueteSimpleFactory.new.crear_paquete('R', envio.paquetes_lista)
      envio.agregar_paquete(paquete_redondo)
    end

    expect {
      envio.cotizar
    }.to raise_error(EnvioDemasiadoGrandeException)
  end

  it 'No puedo cotizar un Envío que tiene volumen 12' do
    envio = Envio.new(1)
    paquete_redondo = PaqueteSimpleFactory.new.crear_paquete('R', envio.paquetes_lista)
    paquete_cuadrado = PaqueteSimpleFactory.new.crear_paquete('C', envio.paquetes_lista)
    paquete_cuadrado2 = PaqueteSimpleFactory.new.crear_paquete('C', envio.paquetes_lista)

    (1..5).to_a.each do ||
      paquete_redondo = PaqueteSimpleFactory.new.crear_paquete('R', envio.paquetes_lista)
      envio.agregar_paquete(paquete_redondo)
    end

    envio.agregar_paquete(paquete_cuadrado)
    envio.agregar_paquete(paquete_cuadrado2)

    expect {
      envio.cotizar
    }.to raise_error(EnvioDemasiadoGrandeException)
  end

  it 'Puedo cotizar un Envío que tiene 8 PaquetesCuadrados (cumplen volumen <= 10)' do
    envio = Envio.new(1)

    (1..8).to_a.each do ||
      paquete_cuadrado = PaqueteSimpleFactory.new.crear_paquete('C', envio.paquetes_lista)
      envio.agregar_paquete(paquete_cuadrado)
    end

    expect(envio.cotizar).to eq 11
  end

  it 'No puedo cotizar un Envío de 2 PaqueteTriangulares con 1 PaqueteRedondo' do
    envio = Envio.new(1)

    paquete_redondo = PaqueteSimpleFactory.new.crear_paquete('R', envio.paquetes_lista)
    envio.agregar_paquete(paquete_redondo)

    (1..2).to_a.each do ||
      paquete_triangular = PaqueteSimpleFactory.new.crear_paquete('T', envio.paquetes_lista)
      envio.agregar_paquete(paquete_triangular)
    end

    expect {
      envio.cotizar
    }.to raise_error(EnvioInvalidoException)
  end

  it 'Un Envío de 1 PaqueteRedondo convertido a string es R' do
    envio = Envio.new(1)

    paquete_redondo = PaqueteSimpleFactory.new.crear_paquete('R', envio.paquetes_lista)
    envio.agregar_paquete(paquete_redondo)

    expect(envio.to_s).to eq 'R'
  end

  it 'Un Envio con 2 PaquetesRedondos y 3 PaquetesCuadrados insertados en orden [C,C,R,R,C] convertido a string es CCRRC' do
    envio = Envio.new(1)

    (1..2).to_a.each do ||
      paquete_cuadrado = PaqueteSimpleFactory.new.crear_paquete('C', envio.paquetes_lista)
      envio.agregar_paquete(paquete_cuadrado)
    end

    (1..2).to_a.each do ||
      paquete_redondo = PaqueteSimpleFactory.new.crear_paquete('R', envio.paquetes_lista)
      envio.agregar_paquete(paquete_redondo)
    end

    paquete_cuadrado = PaqueteSimpleFactory.new.crear_paquete('C', envio.paquetes_lista)
    envio.agregar_paquete(paquete_cuadrado)

    expect(envio.to_s).to eq 'CCRRC'
  end

  it 'Un Envío de 1 PaqueteRectangular convertido a string es E' do
    envio = Envio.new(1)

    paquete_redondo = PaqueteSimpleFactory.new.crear_paquete('E', envio.paquetes_lista)
    envio.agregar_paquete(paquete_redondo)

    expect(envio.to_s).to eq 'E'
  end

  it 'No puedo cotizar un Envío de 1 PaqueteRectangular con 1 PaqueteRedondo' do
    envio = Envio.new(1)

    paquete_redondo = PaqueteSimpleFactory.new.crear_paquete('E', envio.paquetes_lista)
    envio.agregar_paquete(paquete_redondo)

    paquete_triangular = PaqueteSimpleFactory.new.crear_paquete('R', envio.paquetes_lista)
    envio.agregar_paquete(paquete_triangular)

    expect {
      envio.cotizar
    }.to raise_error(EnvioInvalidoException)
  end

  it 'un Envio con 11 litros se cotiza correctamente' do
    envio = Envio.new(1)
    paquete_redondo = PaqueteSimpleFactory.new.crear_paquete('E', envio.paquetes_lista)
    envio.agregar_paquete(paquete_redondo)
    paquete_redondo = PaqueteSimpleFactory.new.crear_paquete('E', envio.paquetes_lista)
    envio.agregar_paquete(paquete_redondo)
    #
    paquete_cuadrado = PaqueteSimpleFactory.new.crear_paquete('C', envio.paquetes_lista)
    envio.agregar_paquete(paquete_cuadrado)
    paquete_cuadrado = PaqueteSimpleFactory.new.crear_paquete('C', envio.paquetes_lista)
    envio.agregar_paquete(paquete_cuadrado)
    paquete_cuadrado = PaqueteSimpleFactory.new.crear_paquete('C', envio.paquetes_lista)
    envio.agregar_paquete(paquete_cuadrado)


    expect(envio.cotizar).to eq 10
  end
end
