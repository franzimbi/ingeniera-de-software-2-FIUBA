require 'spec_helper'

describe 'Rental' do

  it 'alquiler por 3hs de un cuit empezado en 20' do
    resultado = Rental.new.calculate 'h', 3, 20112223336
    expect(resultado).to eq [297.0, 133.6]
  end

  it 'alquiler por 3hs de un cuit empresarial' do
    resultado = Rental.new.calculate 'h', 3, 26112223336
    expect(resultado).to eq [282.1, 126.9]
  end

  it 'alquiler por 1 dia de un cuit empezado en 20' do
    resultado = Rental.new.calculate 'd', 1, 20418365791
    expect(resultado).to eq [2001.0, 900.4 ]
  end

  it 'alquiler por 1 dia de un cuit empresarial' do
    resultado = Rental.new.calculate 'd', 1, 26418365791
    expect(resultado).to eq [1900.9, 855.4]
  end

  it 'alquiler por 12 km de un cuit empezado en 20' do
    resultado = Rental.new.calculate 'k', 12, 2011111111
    expect(resultado).to eq [220.0, 99.0]
  end

  it 'alquiler por 12 km de un cuit empresarial' do
    resultado = Rental.new.calculate 'k', 12, 2611111111
    expect(resultado).to eq [209.0, 94.0]
  end

end
