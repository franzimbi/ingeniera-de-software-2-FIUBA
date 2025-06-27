require 'humanize'

class Chopper
  def chop(position, array)
    array.each_with_index do |num, i|
      return i if num == position
    end
    -1
  end

  def convert_to_string(number)
    words = []
    numbers_strings = {
      0 => 'cero',
      1 => 'uno',
      2 => 'dos',
      3 => 'tres',
      4 => 'cuatro',
      5 => 'cinco',
      6 => 'seis',
      7 => 'siete',
      8 => 'ocho',
      9 => 'nueve'
    }
    return numbers_strings[number] if number.zero?

    while number.positive?
      digit = number % 10
      words.unshift(numbers_strings[digit])
      number /= 10
    end
    words.join(',')
  end

  def sum(array)
    return 'vacio' if array.empty?

    total = 0
    array.each do |num|
      total += num
    end
    return 'demasiado grande' if total > 99

    convert_to_string(total)
  end
end
