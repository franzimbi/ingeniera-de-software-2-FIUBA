require 'spec_helper'

require_relative '../model/paquete/paquetes_lista'
require_relative '../model/paquete/paquete_simple_factory'
require_relative '../model/exceptions/paquetes_lista_vacio_exception'
require_relative '../model/exceptions/demasiados_paquetes_exception'
require_relative '../model/exceptions/combinacion_invalida_de_triangulos_exception'

describe 'PaquetesLista' do

  it 'Agrego un PaqueteRedondo a un PaquetesLista y cuesta 4.4' do
    paquetes_lista = PaquetesLista.new
    paquete_redondo = PaqueteSimpleFactory.new.crear_paquete('R', paquetes_lista)
    paquetes_lista.agregar_paquete(paquete_redondo)

    expect(paquetes_lista.cotizar).to eq 4.4
  end

  it 'Agrego dos PaqueteRedondos a un PaquetesLista y cuesta 8.8' do
    paquetes_lista = PaquetesLista.new
    paquete_redondo = PaqueteSimpleFactory.new.crear_paquete('R', paquetes_lista)
    paquetes_lista.agregar_paquete(paquete_redondo)

    nuevo_paquete = PaqueteSimpleFactory.new.crear_paquete('R', paquetes_lista)
    paquetes_lista.agregar_paquete(nuevo_paquete)

    expect(paquetes_lista.cotizar).to eq 8.8
  end

  it 'Agrego dos PaqueteRedondos y un PaqueteTriangular a un PaquetesLista y cuesta 11' do
    paquetes_lista = PaquetesLista.new
    paquete_redondo = PaqueteSimpleFactory.new.crear_paquete('R', paquetes_lista)
    otro_paquete_redondo = PaqueteSimpleFactory.new.crear_paquete('R', paquetes_lista)
    paquete_triangular = PaqueteSimpleFactory.new.crear_paquete('T', paquetes_lista)

    paquetes_lista.agregar_paquete(paquete_redondo)
    paquetes_lista.agregar_paquete(otro_paquete_redondo)
    paquetes_lista.agregar_paquete(paquete_triangular)

    expect(paquetes_lista.cotizar).to eq 11
  end

  it 'Agrego dos PaqueteCuadrados a un PaquetesLista y cuesta 4.4' do
    paquetes_lista = PaquetesLista.new
    paquete_cuadrado = PaqueteSimpleFactory.new.crear_paquete('C', paquetes_lista)
    otro_paquete_cuadrado = PaqueteSimpleFactory.new.crear_paquete('C', paquetes_lista)

    paquetes_lista.agregar_paquete(paquete_cuadrado)
    paquetes_lista.agregar_paquete(otro_paquete_cuadrado)

    expect(paquetes_lista.cotizar).to eq 4.4
  end

  it 'Agrego tres PaqueteCuadrados a un PaquetesLista y cuesta 6.6' do
    paquetes_lista = PaquetesLista.new

    (1..3).to_a.each do ||
      paquete_cuadrado = PaqueteSimpleFactory.new.crear_paquete('C', paquetes_lista)
      paquetes_lista.agregar_paquete(paquete_cuadrado)
    end

    expect(paquetes_lista.cotizar).to eq 6.6
  end

  it 'Agrego cuatro PaqueteCuadrados a un PaquetesLista y cuesta 7.7' do
    paquetes_lista = PaquetesLista.new

    (1..4).to_a.each do ||
      paquete_cuadrado = PaqueteSimpleFactory.new.crear_paquete('C', paquetes_lista)
      paquetes_lista.agregar_paquete(paquete_cuadrado)
    end

    expect(paquetes_lista.cotizar).to eq 7.7
  end

  it 'Un PaquetesLista con 2 PaquetesRedondos tiene 2 PaquetesRedondos, 0 PaquetesTriangulares y 0 PaquetesCuadrados' do
    paquetes_lista = PaquetesLista.new
    paquete_redondo = PaqueteSimpleFactory.new.crear_paquete('R', paquetes_lista)
    paquete_triangular = PaqueteSimpleFactory.new.crear_paquete('T', paquetes_lista)
    paquete_cuadrado = PaqueteSimpleFactory.new.crear_paquete('C', paquetes_lista)

    (1..2).to_a.each do ||
      paquete_redondo = PaqueteSimpleFactory.new.crear_paquete('R', paquetes_lista)
      paquetes_lista.agregar_paquete(paquete_redondo)
    end

    expect(paquetes_lista.contar_paquetes_mismo_tipo paquete_redondo).to eq 2
    expect(paquetes_lista.contar_paquetes_mismo_tipo paquete_triangular).to eq 0
    expect(paquetes_lista.contar_paquetes_mismo_tipo paquete_cuadrado).to eq 0
  end

  it 'Un PaquetesLista con 2 PaquetesRedondos y 3 PaquetesCuadrados tiene 2 PaquetesRedondos, 0 PaquetesTriangulares y 3 PaquetesCuadrados' do
    paquetes_lista = PaquetesLista.new
    paquete_redondo = PaqueteSimpleFactory.new.crear_paquete('R', paquetes_lista)
    paquete_triangular = PaqueteSimpleFactory.new.crear_paquete('T', paquetes_lista)
    paquete_cuadrado = PaqueteSimpleFactory.new.crear_paquete('C', paquetes_lista)

    (1..2).to_a.each do ||
      paquete_redondo = PaqueteSimpleFactory.new.crear_paquete('R', paquetes_lista)
      paquetes_lista.agregar_paquete(paquete_redondo)
    end

    (1..3).to_a.each do ||
      paquete_cuadrado = PaqueteSimpleFactory.new.crear_paquete('C', paquetes_lista)
      paquetes_lista.agregar_paquete(paquete_cuadrado)
    end

    expect(paquetes_lista.contar_paquetes_mismo_tipo paquete_redondo).to eq 2
    expect(paquetes_lista.contar_paquetes_mismo_tipo paquete_triangular).to eq 0
    expect(paquetes_lista.contar_paquetes_mismo_tipo paquete_cuadrado).to eq 3
  end

  it 'Un PaquetesLista con 2 PaquetesRedondos y 3 PaquetesCuadrados cuesta 12' do
    paquetes_lista = PaquetesLista.new

    (1..2).to_a.each do ||
      paquete_redondo = PaqueteSimpleFactory.new.crear_paquete('R', paquetes_lista)
      paquetes_lista.agregar_paquete(paquete_redondo)
    end

    (1..3).to_a.each do ||
      paquete_cuadrado = PaqueteSimpleFactory.new.crear_paquete('C', paquetes_lista)
      paquetes_lista.agregar_paquete(paquete_cuadrado)
    end

    expect(paquetes_lista.cotizar).to eq 14
  end

  it 'Agrego un PaqueteRedondo a un PaquetesLista y tiene volumen 2' do
    paquetes_lista = PaquetesLista.new
    paquete_redondo = PaqueteSimpleFactory.new.crear_paquete('R', paquetes_lista)
    paquetes_lista.agregar_paquete(paquete_redondo)

    expect(paquetes_lista.calcular_volumen).to eq 2
  end

  it 'Agrego un PaqueteTriangular a un PaquetesLista y tiene volumen 3' do
    paquetes_lista = PaquetesLista.new
    paquete_triangular = PaqueteSimpleFactory.new.crear_paquete('T', paquetes_lista)
    paquetes_lista.agregar_paquete(paquete_triangular)

    expect(paquetes_lista.calcular_volumen).to eq 3
  end

  it 'Agrego un PaqueteCuadrado a un PaquetesLista y tiene volumen 1' do
    paquetes_lista = PaquetesLista.new
    paquete_cuadrado = PaqueteSimpleFactory.new.crear_paquete('C', paquetes_lista)
    paquetes_lista.agregar_paquete(paquete_cuadrado)

    expect(paquetes_lista.calcular_volumen).to eq 1
  end

  it 'Agrego un PaqueteRedondo y un PaqueteTriangular a un PaquetesLista y tiene volumen 5' do
    paquetes_lista = PaquetesLista.new
    paquete_redondo = PaqueteSimpleFactory.new.crear_paquete('R', paquetes_lista)
    paquete_triangular = PaqueteSimpleFactory.new.crear_paquete('T', paquetes_lista)

    paquetes_lista.agregar_paquete(paquete_redondo)
    paquetes_lista.agregar_paquete(paquete_triangular)

    expect(paquetes_lista.calcular_volumen).to eq 5
  end

  it 'Agrego un PaqueteRedondo y 5 PaqueteCuadrados a un PaquetesLista y tiene volumen 7' do
    paquetes_lista = PaquetesLista.new
    paquete_redondo = PaqueteSimpleFactory.new.crear_paquete('R', paquetes_lista)
    paquetes_lista.agregar_paquete(paquete_redondo)

    (1..5).to_a.each do ||
      paquete_cuadrado = PaqueteSimpleFactory.new.crear_paquete('C', paquetes_lista)
      paquetes_lista.agregar_paquete(paquete_cuadrado)
    end

    expect(paquetes_lista.calcular_volumen).to eq 7
  end

  it 'No puedo cotizar un PaquetesLista vacío' do
    paquetes_lista = PaquetesLista.new

    expect {
      paquetes_lista.cotizar
    }.to raise_error(PaquetesListaVacioException)
  end

  it 'No puedo cotizar un PaquetesLista con más de 8 paquetes' do
    paquetes_lista = PaquetesLista.new

    (1..9).to_a.each do ||
      paquete_redondo = PaqueteSimpleFactory.new.crear_paquete('R', paquetes_lista)
      paquetes_lista.agregar_paquete(paquete_redondo)
    end

    expect {
      paquetes_lista.cotizar
    }.to raise_error(DemasiadosPaquetesException)
  end

  it 'No puedo cotizar un PaquetesLista que tiene volumen 12' do
    paquetes_lista = PaquetesLista.new

    paquete_cuadrado = PaqueteSimpleFactory.new.crear_paquete('C', paquetes_lista)
    paquetes_lista.agregar_paquete(paquete_cuadrado)
    paquete_cuadrado = PaqueteSimpleFactory.new.crear_paquete('C', paquetes_lista)
    paquetes_lista.agregar_paquete(paquete_cuadrado)

    (1..5).to_a.each do ||
      paquete_redondo = PaqueteSimpleFactory.new.crear_paquete('R', paquetes_lista)
      paquetes_lista.agregar_paquete(paquete_redondo)
    end

    expect {
      paquetes_lista.cotizar
    }.to raise_error(ExcesoVolumenException)
  end

  it 'Puedo cotizar un PaquetesLista que tiene 8 PaquetesCuadrados (cumplen volumen <= 10)' do
    paquetes_lista = PaquetesLista.new

    (1..8).to_a.each do ||
      paquete_cuadrado = PaqueteSimpleFactory.new.crear_paquete('C', paquetes_lista)
      paquetes_lista.agregar_paquete(paquete_cuadrado)
    end

    expect(paquetes_lista.cotizar).to eq 11
  end

  it 'No puedo cotizar un PaquetesLista de 2 PaqueteTriangulares con 1 PaqueteRedondo' do
    paquetes_lista = PaquetesLista.new
    paquete_redondo = PaqueteSimpleFactory.new.crear_paquete('R', paquetes_lista)
    paquetes_lista.agregar_paquete(paquete_redondo)

    (1..2).to_a.each do ||
      paquete_triangular = PaqueteSimpleFactory.new.crear_paquete('T', paquetes_lista)
      paquetes_lista.agregar_paquete(paquete_triangular)
    end

    expect {
      paquetes_lista.cotizar
    }.to raise_error(CombinacionInvalidaDeTriangulosException)
  end

  it 'Agrego un PaqueteRedondo a un PaquetesLista y convertido a string es R' do
    paquetes_lista = PaquetesLista.new
    paquete_redondo = PaqueteSimpleFactory.new.crear_paquete('R', paquetes_lista)
    paquetes_lista.agregar_paquete(paquete_redondo)

    expect(paquetes_lista.to_s).to eq 'R'
  end

  it 'Un PaquetesLista con 2 PaquetesRedondos y 3 PaquetesCuadrados insertados en orden [R,C,C,R,C] convertido a string es RCCRC' do
    paquetes_lista = PaquetesLista.new

    paquete_redondo = PaqueteSimpleFactory.new.crear_paquete('R', paquetes_lista)
    paquetes_lista.agregar_paquete(paquete_redondo)

    (1..2).to_a.each do ||
      paquete_cuadrado = PaqueteSimpleFactory.new.crear_paquete('C', paquetes_lista)
      paquetes_lista.agregar_paquete(paquete_cuadrado)
    end

    paquete_redondo = PaqueteSimpleFactory.new.crear_paquete('R', paquetes_lista)
    paquetes_lista.agregar_paquete(paquete_redondo)

    paquete_cuadrado = PaqueteSimpleFactory.new.crear_paquete('C', paquetes_lista)
    paquetes_lista.agregar_paquete(paquete_cuadrado)

    expect(paquetes_lista.to_s).to eq 'RCCRC'
  end

  it 'Agrego un PaqueteRectangular a un PaquetesLista y convertido a string es E' do
    paquetes_lista = PaquetesLista.new
    paquete_redondo = PaqueteSimpleFactory.new.crear_paquete('E', paquetes_lista)
    paquetes_lista.agregar_paquete(paquete_redondo)

    expect(paquetes_lista.to_s).to eq 'E'
  end

  it 'No puedo cotizar un PaquetesLista de un Rectangulo y un Redondo' do
    paquetes_lista = PaquetesLista.new
    paquete_redondo = PaqueteSimpleFactory.new.crear_paquete('R', paquetes_lista)
    paquetes_lista.agregar_paquete(paquete_redondo)

    paquete_rectangular = PaqueteSimpleFactory.new.crear_paquete('E', paquetes_lista)
    paquetes_lista.agregar_paquete(paquete_rectangular)

    expect {
      paquetes_lista.cotizar
    }.to raise_error(CombinacionInvalidaDeRectanguloYRedondoException)
  end

  it 'Puedo cotizar un PaquetesLista que tiene 11 litros' do
    paquetes_lista = PaquetesLista.new

    paquete_rectangular = PaqueteSimpleFactory.new.crear_paquete('E', paquetes_lista)
    paquetes_lista.agregar_paquete(paquete_rectangular)
    paquete_rectangular = PaqueteSimpleFactory.new.crear_paquete('E', paquetes_lista)
    paquetes_lista.agregar_paquete(paquete_rectangular)
    #
    paquete_cuadrado = PaqueteSimpleFactory.new.crear_paquete('C', paquetes_lista)
    paquetes_lista.agregar_paquete(paquete_cuadrado)
    paquete_cuadrado = PaqueteSimpleFactory.new.crear_paquete('C', paquetes_lista)
    paquetes_lista.agregar_paquete(paquete_cuadrado)
    paquete_cuadrado = PaqueteSimpleFactory.new.crear_paquete('C', paquetes_lista)
    paquetes_lista.agregar_paquete(paquete_cuadrado)


    expect(paquetes_lista.cotizar).to eq 10
  end
end
