consonants = %w(B C D F G H J K L M N P Q R S T V W X Z)
vowels = %w(A E I O U)
puts 'Enter a string containing only a combination of the letters \'c\' and \'v\' in either upper or lowercase'
input = gets.strip

new_string = ''

input.each_char do |c|
  case c
    when 'C'
      new_string += consonants.sample
    when 'c'
      new_string += consonants.sample.downcase
    when 'V'
      new_string += vowels.sample
    when 'v'
      new_string += vowels.sample.downcase
    else raise ArgumentError.new("Input must be either a \'c\' or \'v\'")
  end
end

puts new_string
