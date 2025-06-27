require 'spec_helper'

describe 'Sistema Envios' do

  it 'crea un envio con id valido' do
    resultado = SistemaEnvios.new.crear_envio
    expect(resultado).to eq 1
  end

  it 'crear dos envios y que tengan distinto id' do
    sistema = SistemaEnvios.new
    id_1 = sistema.crear_envio
    id_2 = sistema.crear_envio
    expect(id_1).to eq 1
    expect(id_2).to eq 2
  end

  it 'crear un envio y que cantidad de envios del sistema sea 2' do
    sistema = SistemaEnvios.new
    id_1 = sistema.crear_envio
    expect(sistema.cantidad_envios).to eq 1
  end

  it 'agrego un paquete a un envio existente' do
    sistema = SistemaEnvios.new
    id = sistema.crear_envio
    expect { sistema.agregar_paquete(id, 'C') }.not_to raise_error
  end

  it 'calculo volumen envio existente con un C' do
    sistema = SistemaEnvios.new
    id = sistema.crear_envio
    sistema.agregar_paquete(id, 'C')
    expect(sistema.calcular_volumen(id)).to eq 1
  end

  it 'calculo volumen envio existente con dos C' do
    sistema = SistemaEnvios.new
    id = sistema.crear_envio
    sistema.agregar_paquete(id, 'C')
    sistema.agregar_paquete(id, 'C')
    expect(sistema.calcular_volumen(id)).to eq 2
  end

  it 'obtengo el datalle del envio existente con un C' do
    sistema = SistemaEnvios.new
    id = sistema.crear_envio
    sistema.agregar_paquete(id, 'C')
    expect(sistema.detalles_envio(id)).to eq 'C'
  end

  it 'obtengo el datalle del envio existente con CC ' do
    sistema = SistemaEnvios.new
    id = sistema.crear_envio
    sistema.agregar_paquete(id, 'C')
    sistema.agregar_paquete(id, 'C')
    expect(sistema.detalles_envio(id)).to eq 'CC'
  end

  it 'obtengo costo de envio existente con un C' do
    sistema = SistemaEnvios.new
    id = sistema.crear_envio
    sistema.agregar_paquete(id, 'C')
    expect(sistema.calcular_costo(id)).to eq 2.2
  end

  it 'obtengo costo de envio existente con dos C' do
    sistema = SistemaEnvios.new
    id = sistema.crear_envio
    sistema.agregar_paquete(id, 'C')
    sistema.agregar_paquete(id, 'C')
    expect(sistema.calcular_costo(id)).to eq 4.4
  end

  it 'obtengo costo de envio correcto al tener mas de 3 cuadrados' do
    sistema = SistemaEnvios.new
    id = sistema.crear_envio
    for i in (0..5)
    sistema.agregar_paquete(id, 'C')
    end
    expect(sistema.calcular_costo(id)).to eq 9
  end

  it 'obtengo volumen en envio correcto con 1 redondo' do
    sistema = SistemaEnvios.new
    id = sistema.crear_envio
    sistema.agregar_paquete(id, 'R')
    expect(sistema.calcular_volumen(id)).to eq 2
  end

  it 'obtengo costo en envio correcto con 1 redondo' do
    sistema = SistemaEnvios.new
    id = sistema.crear_envio
    sistema.agregar_paquete(id, 'R')
    expect(sistema.calcular_costo(id)).to eq 4.4
  end

  it 'obtengo volumen en envio correcto con q triangulo' do
    sistema = SistemaEnvios.new
    id = sistema.crear_envio
    sistema.agregar_paquete(id, 'T')
    expect(sistema.calcular_volumen(id)).to eq 3
  end

  it 'obtengo costo en envio correcto con 1 redondo' do
    sistema = SistemaEnvios.new
    id = sistema.crear_envio
    sistema.agregar_paquete(id, 'T')
    expect(sistema.calcular_costo(id)).to eq 3.3
  end

  it 'verifico que un envio no vacio este realmente no vacio' do
    sistema = SistemaEnvios.new
    id = sistema.crear_envio
    sistema.agregar_paquete(id, 'T')
    estado = sistema.obtener_estado(id)
    expect(estado.esta_vacio).to eq false
  end

  it 'sistema devuelve excepcion si el id no existe' do
    sistema = SistemaEnvios.new
    expect{ sistema.agregar_paquete(-1, 'T') }.to raise_error(ArgumentError, /El id -1 no es válido/)
  end

end
