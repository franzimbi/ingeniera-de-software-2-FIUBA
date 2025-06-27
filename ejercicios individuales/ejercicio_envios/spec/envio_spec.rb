require 'spec_helper'

describe 'Envio' do

  it 'crea un envio' do
    expect{Envio.new}.not_to raise_error
  end

  it 'agregar paquete C a envio' do
    envio = Envio.new
    expect{envio.agregar_paquete("C")}.not_to raise_error
  end

  it 'calcular volumen con una C' do
    envio = Envio.new
    envio.agregar_paquete('C')
    volumen = envio.calcular_volumen
    expect(volumen).to eq 1
  end

  it 'obtener detalle con una C' do
    envio = Envio.new
    envio.agregar_paquete('C')
    detalle = envio.obtener_detalle
    expect(detalle).to eq 'C'
  end

  it 'obtener detalle con dos C' do
    envio = Envio.new
    envio.agregar_paquete('C')
    envio.agregar_paquete('C')
    detalle = envio.obtener_detalle
    expect(detalle).to eq 'CC'
  end

  it 'obtener costo con una C' do
    envio = Envio.new
    envio.agregar_paquete('C')
    expect(envio.calcular_costo).to eq 2.2
  end

  it 'obtener costo con dos C' do
    envio = Envio.new
    envio.agregar_paquete('C')
    envio.agregar_paquete('C')
    expect(envio.calcular_costo).to eq 4.4
  end

  it 'obtener costo con 6 C' do
    envio = Envio.new
    for _ in (0..5)
      envio.agregar_paquete('C')
    end
    expect(envio.calcular_costo).to eq 9
    end

  it 'obtener volumen con 1 R' do
    envio = Envio.new
    envio.agregar_paquete('R')
    expect(envio.calcular_volumen).to eq 2
  end

  it 'obtener costo con 1 R'do
    envio = Envio.new
    envio.agregar_paquete('R')
    expect(envio.calcular_costo).to eq 4.4
  end

  it 'obtener volumen con 1 T' do
    envio = Envio.new
    envio.agregar_paquete('T')
    expect(envio.calcular_volumen).to eq 3
  end

  it 'obtener costo con 1 T'do
    envio = Envio.new
    envio.agregar_paquete('T')
    expect(envio.calcular_costo).to eq 3.3
  end

  it "envio vacio devuelve un estado vacio" do
    estado = Envio.new.obtener_estado
    expect(estado.esta_vacio).to eq true
  end

end
