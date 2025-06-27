require_relative './model/sistema_envios'

entrada = ARGV[0]

if entrada.nil?
  puts 'error: entrada requerida'
  exit 1
end
unless entrada.chars.all? { |paquete| %w[R C T].include?(paquete) }
  puts 'tipo paquete invalido'
  return
end

sistema = SistemaEnvios.new
id = sistema.crear_envio
entrada.chars.each { |paquete| sistema.agregar_paquete(id, paquete) }

estado = sistema.obtener_estado(id)
if estado.es_valido
  if estado.es_grande
    puts 'envio demasiado grande'
  else
    puts "el envio #{entrada} incluye #{entrada.length} paquetes y tiene un costo de $ #{estado.obtener_costo}"
  end
else
  puts 'envio no valido'
end
