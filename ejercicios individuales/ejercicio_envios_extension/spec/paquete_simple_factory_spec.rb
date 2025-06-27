require 'spec_helper'

require_relative '../model/paquete/paquete_simple_factory'
require_relative '../model/paquete/paquete_redondo'
require_relative '../model/paquete/paquete_triangular'
require_relative '../model/paquete/paquete_cuadrado'
require_relative '../model/paquete/paquetes_lista'
require_relative '../model/exceptions/tipo_de_paquete_inexistente_exception'

describe 'PaqueteSimpleFactory' do

  it 'Creo un PaqueteRedondo con PaqueteSimpleFactory y cuesta 4 con sólo ese paquete en un PaquetesLista' do
    paquetes_lista = PaquetesLista.new
    paquete = PaqueteSimpleFactory.new.crear_paquete('R', paquetes_lista)

    expect(paquete.is_a? PaqueteRedondo).to be true
    expect(paquete.cotizar).to eq 4
  end

  it 'Creo un PaqueteTriangular con PaqueteSimpleFactory y cuesta 3 con sólo ese paquete en un PaquetesLista' do
    paquetes_lista = PaquetesLista.new
    paquete = PaqueteSimpleFactory.new.crear_paquete('T', paquetes_lista)

    expect(paquete.is_a? PaqueteTriangular).to be true
    expect(paquete.cotizar).to eq 3
  end

  it 'Creo un PaqueteCuadrado con PaqueteSimpleFactory y cuesta 2 con sólo ese paquete en un PaquetesLista' do
    paquetes_lista = PaquetesLista.new
    paquete = PaqueteSimpleFactory.new.crear_paquete('C', paquetes_lista)

    expect(paquete.is_a? PaqueteCuadrado).to be true
    expect(paquete.cotizar).to eq 2
  end

  it 'No puedo crear un tipo de paquete que no existe' do
    paquetes_lista = PaquetesLista.new

    expect {
      PaqueteSimpleFactory.new.crear_paquete('Q', paquetes_lista)
    }.to raise_error(TipoDePaqueteInexistenteException)
  end

  it 'Creo un PaqueteRectangular con PaqueteSimpleFactory y cuesta 2 con sólo ese paquete en un PaquetesLista' do
    paquetes_lista = PaquetesLista.new
    paquete = PaqueteSimpleFactory.new.crear_paquete('E', paquetes_lista)

    expect(paquete.is_a? PaqueteRectangular).to be true
    expect(paquete.cotizar).to eq 2
  end
end
