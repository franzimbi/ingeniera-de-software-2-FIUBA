require 'spec_helper'

describe 'App cli' do

  it 'sin entrada muestra error' do
    resultado = `ruby app_envios.rb`
    expect(resultado.strip).to eq 'error: entrada requerida'
  end

  it 'CRTC es valido y devuelve todo correctamente' do
    resultado = `ruby app_envios.rb CRTC`
    expect(resultado.strip).to eq 'el envio CRTC incluye 4 paquetes y tiene un costo de $ 11'
  end

  it 'C es valido y devuelve todo correctamente' do
    resultado = `ruby app_envios.rb C`
    expect(resultado.strip).to eq 'el envio C incluye 1 paquetes y tiene un costo de $ 2.2'
  end

  it 'CC es valido y devuelve todo correctamente' do
    resultado = `ruby app_envios.rb CC`
    expect(resultado.strip).to eq 'el envio CC incluye 2 paquetes y tiene un costo de $ 4.4'
  end

  it 'CCCCCC es valido y devuelve todo correctamente' do
    resultado = `ruby app_envios.rb CCCCCC`
    expect(resultado.strip).to eq 'el envio CCCCCC incluye 6 paquetes y tiene un costo de $ 9'
  end

  it 'R es valido y devuelve todo correctamente' do
    resultado = `ruby app_envios.rb R`
    expect(resultado.strip).to eq 'el envio R incluye 1 paquetes y tiene un costo de $ 4.4'
  end

  it 'TC es valido y devuelve todo correctamente' do
    resultado = `ruby app_envios.rb TC`
    expect(resultado.strip).to eq 'el envio TC incluye 2 paquetes y tiene un costo de $ 5.5'
  end

  it 'envio no valido se imprime por consola' do
    resultado = `ruby app_envios.rb TTC`
    expect(resultado.strip).to eq 'envio no valido'
  end

  it 'envio demasiado grande se imprime por consola' do
    resultado = `ruby app_envios.rb CCCCCCCCC`
    expect(resultado.strip).to eq 'envio demasiado grande'
  end

  it 'agregar paquete invalido devuelve error' do
    resultado = `ruby app_envios.rb CQ`
    expect(resultado.strip).to eq 'tipo paquete invalido'
  end
end
