require 'spec_helper'

require_relative '../model/paquete/paquete_tipo'

describe 'PaqueteTipo' do

  it 'Creo un PaqueteTipo con contenido R y tiene contenido R' do
    paquete_tipo = PaqueteTipo.new('R')
    expect(paquete_tipo.tipo).to eq('R')
  end

  it 'Creo un PaqueteTipo con contenido T y tiene contenido T' do
    paquete_tipo = PaqueteTipo.new('T')
    expect(paquete_tipo.tipo).to eq('T')
  end

  it 'Creo un PaqueteTipo con contenido C y tiene contenido C' do
    paquete_tipo = PaqueteTipo.new('C')
    expect(paquete_tipo.tipo).to eq('C')
  end

  it 'Un PaqueteTipo con contenido C es del mismo tipo que otro PaqueteTipo con contenido C' do
    un_paquete_tipo = PaqueteTipo.new('C')
    otro_paquete_tipo = PaqueteTipo.new('C')

    expect(un_paquete_tipo.es_mismo_tipo? otro_paquete_tipo).to be true
  end

  it 'Un PaqueteTipo con contenido C es de distinto tipo que un PaqueteTipo con contenido T' do
    un_paquete_tipo = PaqueteTipo.new('C')
    otro_paquete_tipo = PaqueteTipo.new('T')

    expect(un_paquete_tipo.es_mismo_tipo? otro_paquete_tipo).to be false
  end

  it 'Creo un PaqueteTipo con contenido R y convertido a string es R' do
    paquete_tipo = PaqueteTipo.new('R')
    expect(paquete_tipo.to_s).to eq('R')
  end

  it 'Creo un PaqueteTipo con contenido T y convertido a string es T' do
    paquete_tipo = PaqueteTipo.new('T')
    expect(paquete_tipo.to_s).to eq('T')
  end

  it 'Creo un PaqueteTipo con contenido E y convertido a string es E' do
    paquete_tipo = PaqueteTipo.new('E')
    expect(paquete_tipo.to_s).to eq('E')
  end
end
