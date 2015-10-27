#Accepts an array of threads and waits until they all finish
def wait_on_threads(threads)
  threads.each do |i|
  i.join
  end
end

#Exchanges and reverses the contents of two arrays
class Array
  def exchange_with!(other_array)
    temp = self.dup
    self.replace(other_array.reverse)
    other_array.replace(temp.reverse)
  end
end

#Returns true if divisible by four
def divisibleByFour(num)
  return true if num % 4 == 0
  false
end

#Your classmates asked you to copy some paperwork for them. You know that there are 'n' classmates and the paperwork has 'm' pages.
#
#Your task is to calculate how many blank pages do you need.
def paperwork(n, m)
  return 0 if n < 0 or m < 0
  n * m
end

# In this Kata you need to will need to write two methods.
#
# Method 1
#
# The first method takes in a valid int (positive or negative) and returns the following:
#
# for any multiple of 3 the string "THREE",
# for any multiple of 5 the string "FIVE",
# for any multiple of both the string "BOTH",
# for all other numbers the original int.
# Method 2
#
# The second method takes valid ints (positive or negative) and returns a list of the values that follow the above rules.
#
# The first value may be greater than or less than the second and the list should increment/decrement appropriately
#
# For example an input of 10,13 should generate a response of ['FIVE', 11, 'THREE', 13].
def getNumber(number)
    x = number.abs
    case
      when x % 15 == 0 || x == 0
        return "BOTH"
      when x % 5 == 0
        return "FIVE"
      when x % 3 == 0
        return "THREE"
      else return number
    end
end

def getNumberRange(first, last)
    answer = []
    if first < last
      (first..last).each do
        |i| answer << getNumber(i)
      end
    elsif first > last
      (last..first).each do
        |i| answer << getNumber(i)
      end
      answer.reverse!
    end
    return answer
end

# Create a function that takes an input String and returns a String, where all the uppercase words of the input String are in front and all the lowercase words at the end.
#
# If a word starts with a number or special character, skip the word and leave it out of the result.
#
# Input String will not be empty.
#
# For an input String: "hey You, Sort me Already!" the function should return: "You, Sort Already! hey me"

def capitals_first(string)
	caps = []
  lows = []
  string.split(' ').each do |word|
    if word.chr.match(/[a-zA-Z]/)
      if word.match(/[A-Z]/,0)
        caps << word
      else
        lows << word
      end
    else
    end
  end
  result = caps << lows
  result.join(" ")
end


# The word i18n is a common abbreviation of internationalization the developer community use instead of typing the whole word and trying to spell it correctly. Similarly, a11y is an abbreviation of accessibility.
#
# Write a function that takes a string and turns any and all words within that string of length 4 or greater into an abbreviation following the same rules.
#
# Notes:
#
# A "word" is a sequence of alphabetical characters. By this definition, any other character like a space or hyphen (eg. "elephant-ride") will split up a series of letters into two words (eg. "elephant" and "ride").
# The abbreviated version of the word should have the first letter, then the number of removed characters, then the last letter (eg. "e6t-r2e").

class Abbreviator

  def self.abbreviate(string)
    result = ''
    string.split(/(\W)/).each do |word|
      if word.length < 4
        result += word
      else
        result += word[0]
        result += (word.length-2).to_s
        result += word[-1]
      end
    end
    result
  end
end
