require 'spec_helper'

describe 'Contador' do

  it 'obtener cantidad de 2 triangulos' do
    contador = Contador.new(['T', 'T'])
    expect(contador.obtener_cantidad_triangulos).to eq 2
  end

  it 'obtener cantidad de 3 triangulos' do
    contador = Contador.new(['T', 'T', 'T'])
    expect(contador.obtener_cantidad_triangulos).to eq 3
  end

  it 'obtener cantidad de 2 cuadrados' do
    contador = Contador.new(['C', 'C'])
    expect(contador.obtener_cantidad_cuadrados).to eq 2
  end

  it 'obtener cantidad de 1 rectangulo' do
    contador = Contador.new(['R'])
    expect(contador.obtener_cantidad_rectangulos).to eq 1
  end

  it 'devuelve excepcion si un paquete no es T,C o R' do
    expect{Contador.new(['T', 'C', 'R', 'W'])}.to raise_error(ArgumentError, /Paquete inválido/)

  end

  it 'devuelve cantidad total de paquetes' do
    contador = Contador.new(['T', 'T'])
    expect(contador.obtener_cantidad_total).to eq 2
  end
end
