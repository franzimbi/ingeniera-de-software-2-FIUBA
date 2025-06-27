require_relative './restricciones/verificador_restricciones'

class PaquetesLista
  COEFICIENTE_SIN_PENALIZACION = 1
  COEFICIENTE_PENALIZACION_RECARGO = 1.1
  VOLUMEN_MAXIMO_CON_RECARGO = 5
  CANTIDAD_DIGITOS_REDONDEO = 1

  def initialize
    @paquetes = []
    @verificador_restricciones = VerificadorRestricciones.new
  end

  def agregar_paquete(paquete)
    @paquetes.push(paquete)
  end

  def coeficiente_recargo
    volumen_total = calcular_volumen
    return COEFICIENTE_PENALIZACION_RECARGO if volumen_total < VOLUMEN_MAXIMO_CON_RECARGO

    COEFICIENTE_SIN_PENALIZACION
  end

  def cotizar
    @verificador_restricciones.verificar(self)

    total = 0
    @paquetes.each do |paquete|
      total += paquete.cotizar
    end

    (total * coeficiente_recargo).round(CANTIDAD_DIGITOS_REDONDEO)
  end

  def contar_paquetes_mismo_tipo(paquete_a_comparar)
    cantidad = 0
    @paquetes.each do |paquete|
      cantidad += 1 if paquete.es_mismo_tipo? paquete_a_comparar
    end

    cantidad
  end

  def calcular_volumen
    total = 0
    @paquetes.each do |paquete|
      total += paquete.calcular_volumen
    end

    total.round(CANTIDAD_DIGITOS_REDONDEO)
  end

  def cantidad_paquetes
    @paquetes.count
  end

  def empty?
    @paquetes.empty?
  end

  def to_s
    string = ''
    @paquetes.each do |paquete|
      string += paquete.to_s
    end

    string
  end

  private :coeficiente_recargo
end
