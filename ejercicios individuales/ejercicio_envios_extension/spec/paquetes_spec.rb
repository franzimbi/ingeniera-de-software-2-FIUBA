require 'spec_helper'

require_relative '../model/paquete/paquete_tipo'
require_relative '../model/paquete/paquete_triangular'
require_relative '../model/paquete/paquete_redondo'
require_relative '../model/paquete/paquete_cuadrado'
require_relative '../model/paquete/paquetes_lista'

describe 'Paquetes' do

  it 'Creo un PaqueteRedondo con él sólo en un PaquetesLista y cuesta 4' do
    paquetes_lista = PaquetesLista.new
    paquete = PaqueteRedondo.new(PaqueteTipo.new('R'), paquetes_lista)
    paquetes_lista.agregar_paquete(paquete)

    expect(paquete.cotizar).to eq 4
  end

  it 'Creo un PaqueteRedondo, luego agrego 10 PaqueteRedondos en un PaquetesLista y cuesta 4' do
    paquetes_lista = PaquetesLista.new
    paquete = PaqueteRedondo.new(PaqueteTipo.new('R'), paquetes_lista)
    paquetes_lista.agregar_paquete(paquete)

    (1..9).to_a.each do ||
      nuevo_paquete = PaqueteRedondo.new(PaqueteTipo.new('R'), paquetes_lista)
      paquetes_lista.agregar_paquete(nuevo_paquete)
    end

    expect(paquete.cotizar).to eq 4
  end

  it 'Creo un PaqueteTriangular con él sólo en un PaquetesLista y cuesta 3' do
    paquetes_lista = PaquetesLista.new
    paquete = PaqueteTriangular.new(PaqueteTipo.new('T'), paquetes_lista)
    paquetes_lista.agregar_paquete(paquete)

    expect(paquete.cotizar).to eq 3
  end

  it 'Creo un PaqueteTriangular, luego agrego 10 PaqueteTriangulares en un PaquetesLista y cuesta 3' do
    paquetes_lista = PaquetesLista.new
    paquete = PaqueteTriangular.new(PaqueteTipo.new('T'), paquetes_lista)
    paquetes_lista.agregar_paquete(paquete)

    (1..9).to_a.each do ||
      nuevo_paquete = PaqueteTriangular.new(PaqueteTipo.new('T'), paquetes_lista)
      paquetes_lista.agregar_paquete(nuevo_paquete)
    end

    expect(paquete.cotizar).to eq 3
  end

  it 'Creo un PaqueteCuadrado con él sólo en un PaquetesLista y cuesta 2' do
    paquetes_lista = PaquetesLista.new
    paquete = PaqueteCuadrado.new(PaqueteTipo.new('C'), paquetes_lista)
    paquetes_lista.agregar_paquete(paquete)

    expect(paquete.cotizar).to eq 2
  end

  it 'Creo un PaqueteCuadrado, luego agrego 1 PaqueteCuadrados en un PaquetesLista y cuesta 2' do
    paquetes_lista = PaquetesLista.new
    paquete = PaqueteCuadrado.new(PaqueteTipo.new('C'), paquetes_lista)
    paquetes_lista.agregar_paquete(paquete)

    nuevo_paquete = PaqueteCuadrado.new(PaqueteTipo.new('C'), paquetes_lista)
    paquetes_lista.agregar_paquete(nuevo_paquete)

    expect(paquete.cotizar).to eq 2
  end

  it 'Creo un PaqueteCuadrado con 1 PaqueteCuadrados en un PaquetesLista y cuesta 2' do
    paquetes_lista = PaquetesLista.new
    paquete = PaqueteCuadrado.new(PaqueteTipo.new('C'), paquetes_lista)
    paquetes_lista.agregar_paquete(paquete)

    nuevo_paquete = PaqueteCuadrado.new(PaqueteTipo.new('C'), paquetes_lista)
    paquetes_lista.agregar_paquete(nuevo_paquete)

    expect(paquete.cotizar).to eq 2
  end

  it 'Creo un PaqueteCuadrado, luego agrego 3 PaqueteCuadrados en un PaquetesLista y cuesta 2' do
    paquetes_lista = PaquetesLista.new
    paquete = PaqueteCuadrado.new(PaqueteTipo.new('C'), paquetes_lista)
    paquetes_lista.agregar_paquete(paquete)

    (1..3).to_a.each do ||
      nuevo_paquete = PaqueteCuadrado.new(PaqueteTipo.new('C'), paquetes_lista)
      paquetes_lista.agregar_paquete(nuevo_paquete)
    end

    expect(paquete.cotizar).to eq 2
  end

  it 'Creo un PaqueteCuadrado con 3 PaqueteCuadrados en un PaquetesLista y cuesta 1' do
    paquetes_lista = PaquetesLista.new

    (1..3).to_a.each do ||
      nuevo_paquete = PaqueteCuadrado.new(PaqueteTipo.new('C'), paquetes_lista)
      paquetes_lista.agregar_paquete(nuevo_paquete)
    end

    paquete = PaqueteCuadrado.new(PaqueteTipo.new('C'), paquetes_lista)
    paquetes_lista.agregar_paquete(paquete)

    expect(paquete.cotizar).to eq 1
  end

  it 'Creo un PaqueteCuadrado, luego agrego 4 PaqueteCuadrados en un PaquetesLista y cuesta 2' do
    paquetes_lista = PaquetesLista.new
    paquete = PaqueteCuadrado.new(PaqueteTipo.new('C'), paquetes_lista)
    paquetes_lista.agregar_paquete(paquete)

    (1..4).to_a.each do ||
      nuevo_paquete = PaqueteCuadrado.new(PaqueteTipo.new('C'), paquetes_lista)
      paquetes_lista.agregar_paquete(nuevo_paquete)
    end

    expect(paquete.cotizar).to eq 2
  end

  it 'Creo un PaqueteCuadrado con 4 PaqueteCuadrados en un PaquetesLista y cuesta 1' do
    paquetes_lista = PaquetesLista.new

    (1..4).to_a.each do ||
      nuevo_paquete = PaqueteCuadrado.new(PaqueteTipo.new('C'), paquetes_lista)
      paquetes_lista.agregar_paquete(nuevo_paquete)
    end

    paquete = PaqueteCuadrado.new(PaqueteTipo.new('C'), paquetes_lista)
    paquetes_lista.agregar_paquete(paquete)

    expect(paquete.cotizar).to eq 1
  end

  it 'Un PaqueteRedondo es del mismo tipo que otro PaqueteRedondo' do
    paquetes_lista = PaquetesLista.new
    un_paquete_redondo = PaqueteRedondo.new(PaqueteTipo.new('R'), paquetes_lista)
    otro_paquete_redondo = PaqueteRedondo.new(PaqueteTipo.new('R'), paquetes_lista)

    expect(un_paquete_redondo.es_mismo_tipo? otro_paquete_redondo).to be true
  end

  it 'Un PaqueteRedondo es de distinto tipo que un PaqueteTriangular' do
    paquetes_lista = PaquetesLista.new
    un_paquete_redondo = PaqueteRedondo.new(PaqueteTipo.new('R'), paquetes_lista)
    un_paquete_triangular = PaqueteTriangular.new(PaqueteTipo.new('T'), paquetes_lista)

    expect(un_paquete_redondo.es_mismo_tipo? un_paquete_triangular).to be false
  end

  it 'Un PaqueteRedondo es de distinto tipo que un PaqueteCuadrado' do
    paquetes_lista = PaquetesLista.new
    un_paquete_redondo = PaqueteRedondo.new(PaqueteTipo.new('R'), paquetes_lista)
    un_paquete_cuadrado = PaqueteCuadrado.new(PaqueteTipo.new('C'), paquetes_lista)

    expect(un_paquete_redondo.es_mismo_tipo? un_paquete_cuadrado).to be false
  end

  it 'Un PaqueteTriangular es del mismo tipo que otro PaqueteTriangular' do
    paquetes_lista = PaquetesLista.new
    un_paquete_triangular = PaqueteTriangular.new(PaqueteTipo.new('T'), paquetes_lista)
    otro_paquete_triangular = PaqueteTriangular.new(PaqueteTipo.new('T'), paquetes_lista)

    expect(un_paquete_triangular.es_mismo_tipo? otro_paquete_triangular).to be true
  end

  it 'Un PaqueteTriangular es de distinto tipo que un PaqueteCuadrado' do
    paquetes_lista = PaquetesLista.new
    un_paquete_triangular = PaqueteTriangular.new(PaqueteTipo.new('T'), paquetes_lista)
    un_paquete_cuadrado = PaqueteCuadrado.new(PaqueteTipo.new('C'), paquetes_lista)

    expect(un_paquete_triangular.es_mismo_tipo? un_paquete_cuadrado).to be false
  end

  it 'Un PaqueteCuadrado es del mismo tipo que otro PaqueteCuadrado' do
    paquetes_lista = PaquetesLista.new
    un_paquete_cuadrado = PaqueteCuadrado.new(PaqueteTipo.new('C'), paquetes_lista)
    otro_paquete_cuadrado = PaqueteCuadrado.new(PaqueteTipo.new('C'), paquetes_lista)

    expect(un_paquete_cuadrado.es_mismo_tipo? otro_paquete_cuadrado).to be true
  end

  it 'Creo un PaqueteRedondo y tiene volumen 2' do
    paquetes_lista = PaquetesLista.new
    paquete = PaqueteRedondo.new(PaqueteTipo.new('R'), paquetes_lista)

    expect(paquete.calcular_volumen).to eq 2
  end

  it 'Creo un PaqueteTriangular y tiene volumen 3' do
    paquetes_lista = PaquetesLista.new
    paquete = PaqueteTriangular.new(PaqueteTipo.new('T'), paquetes_lista)

    expect(paquete.calcular_volumen).to eq 3
  end

  it 'Creo un PaqueteCuadrado y tiene volumen 1' do
    paquetes_lista = PaquetesLista.new
    paquete = PaqueteCuadrado.new(PaqueteTipo.new('C'), paquetes_lista)

    expect(paquete.calcular_volumen).to eq 1
  end

  it 'Creo un PaqueteRedondo y convertido a string es R' do
    paquetes_lista = PaquetesLista.new
    paquete = PaqueteRedondo.new(PaqueteTipo.new('R'), paquetes_lista)

    expect(paquete.to_s).to eq 'R'
  end

  it 'Creo un PaqueteTriangular y convertido a string es T' do
    paquetes_lista = PaquetesLista.new
    paquete = PaqueteTriangular.new(PaqueteTipo.new('T'), paquetes_lista)

    expect(paquete.to_s).to eq 'T'
  end

  it 'Creo un PaqueteCuadrado y convertido a string es C' do
    paquetes_lista = PaquetesLista.new
    paquete = PaqueteCuadrado.new(PaqueteTipo.new('C'), paquetes_lista)

    expect(paquete.to_s).to eq 'C'
  end
end
