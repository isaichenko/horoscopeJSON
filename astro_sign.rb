# encoding: utf-8
# XXX/ Этот код необходим только при использовании русских букв на Windows
if (Gem.win_platform?)
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end
# /XXX

require 'json'
require 'date'

file = File.read('signs.json', encoding: "utf-8")
signs = JSON.parse(file)

puts "Когда вы родились? (укажите дату в формате дд.мм, например, 15.03)"
input_date = STDIN.gets.chomp

user_birth_date = Date.parse(input_date + '.2000')

user_sign = nil

signs.each do |key, sign|

  dates = sign['dates'].split('..')

  if (Date.parse(dates[0] + '.2000') <= user_birth_date) &&
     (user_birth_date <= Date.parse(dates[1] + '.2000'))

    user_sign = sign
  end

end

puts user_sign['dates']
puts user_sign['text']
