require_relative './model/rental'

entrada = ARGV[0]

if entrada.size != 3
  puts 'error: entrada requerida'
  exit 1
end

resultado = Rental.new.calculate(entrada[0], entrada[1], entrada[2])

puts resultado
