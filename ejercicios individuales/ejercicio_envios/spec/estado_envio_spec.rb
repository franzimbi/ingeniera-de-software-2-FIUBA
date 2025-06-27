require 'spec_helper'

describe 'EstadoEnvio' do

  it 'crear un estado de envio valido' do
    expect{EstadoEnvio.new(Contador.new(['C']), 1, 0)}.not_to raise_error
  end

  it 'estado de envio vacio' do
    # contador = {'C' => 0, 'R' => 0, 'T' => 0}
    estado = EstadoEnvio.new(Contador.new([]), 1, 0)
    expect(estado.esta_vacio).to eq true
  end

  it 'estado de envio no valido con 2 triangulos y un cuadrado'  do
    # contador = {'C' => 1, 'R' => 0, 'T' => 2}
    estado = EstadoEnvio.new(Contador.new(['C', 'T', 'T']), 1, 0)
    expect(estado.es_valido).to eq false
  end

  it 'estado de envio no valido con 2 triangulos y un rectangulo'  do
    # contador = {'C' => 0, 'R' => 1, 'T' => 2}
    estado = EstadoEnvio.new(Contador.new(['R', 'T', 'T']), 0, 0)
    expect(estado.es_valido).to eq false
  end

  it 'estado de envio no valido con 2 triangulos, un rectangulo y un cuadrado'  do
    # contador = {'C' => 1, 'R' => 1, 'T' => 2}
    estado = EstadoEnvio.new(Contador.new(['C', 'R', 'T', 'T']), 0, 0)
    expect(estado.es_valido).to eq false
  end

  it 'estado de envio valido con muchos tirangulos solos' do
    # contador = {'C' => 0, 'R' => 0, 'T' => 4}
    estado = EstadoEnvio.new(Contador.new(['T', 'T', 'T', 'T']),0,0)
    expect(estado.es_valido).to eq true
  end

  it 'estado de envio valido con un triangulo y un cuadrado' do
    # contador = {'C' => 1, 'R' => 0, 'T' => 1}
    estado = EstadoEnvio.new(Contador.new(['C', 'T']),0,0)
    expect(estado.es_valido).to eq true
  end

  it 'estado demasiado grande con mas de 8 paquetes' do
    # contador = {'C' => 8, 'R' => 1, 'T' => 0}
    estado = EstadoEnvio.new(Contador.new(['C', 'C', 'C', 'C', 'C', 'C', 'C', 'C', 'R']),6,0)
    expect(estado.es_grande).to eq true
  end

  it 'estado no es demasiado grande con 8 paquetes' do
    # contador = {'C' => 8, 'R' => 0, 'T' => 0}
    estado = EstadoEnvio.new(Contador.new(['C', 'C', 'C', 'C', 'C', 'C', 'C', 'C']),6,0)
    expect(estado.es_grande).to eq false
  end

  it 'estado es demasiado grande con mas de 8 paquetes de distinto tipo' do
    # contador = {'C' => 6, 'R' => 2, 'T' => 1}
    estado = EstadoEnvio.new(Contador.new(['C', 'C', 'C', 'C', 'C', 'C', 'R', 'R', 'T']),6,0)
    expect(estado.es_grande).to eq true
  end

  it 'estado no es demasiado grande con  8 paquetes de distinto tipo' do
    # contador = {'C' => 5, 'R' => 2, 'T' => 1}
    estado = EstadoEnvio.new(Contador.new(['C', 'C', 'C', 'C', 'C', 'R', 'R', 'T']),6,0)
    expect(estado.es_grande).to eq false
  end

  it ' estado es demasiado grande cuando hay mas de 10 litros' do
    # contador = {'C' => 0, 'R' => 0, 'T' => 4}
    estado = EstadoEnvio.new(Contador.new(['T', 'T', 'T', 'T']),11,0)
    expect(estado.es_grande).to eq true
  end

  it 'obtener volumen de un estado' do
    # contador = {'C' => 0, 'R' => 0, 'T' => 4}
    estado = EstadoEnvio.new(Contador.new(['T', 'T', 'T', 'T']),2,0)
    expect(estado.obtener_volumen).to eq 2
  end

  it 'obtener costo de un estado' do
    # contador = {'C' => 0, 'R' => 0, 'T' => 4}
    estado = EstadoEnvio.new(Contador.new(['T', 'T', 'T', 'T']),0,10)
    expect(estado.obtener_costo).to eq 10
  end

end
