puts 'Enter the number of lines to read'
timesToRead = gets.chomp.to_i
list = []
timesToRead.times do |i|
  puts 'Enter a string containing the working keys on your keyboard'
  list[i] = gets.split
end

#puts list
words = File.readlines('/usr/share/dict/words')
puts words
