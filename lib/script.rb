# initialize random_word
def select_random_word(dictionary)
  random_word = ''
  random_word_length = 1

  until random_word_length > 5 && random_word_length < 12
    random_word = dictionary.sample
    random_word_length = random_word.length
  end

  random_word
end

def replace_letters(word_array)

  guess_array = word_array.collect do |element|
    element = '_'
  end

  guess_array
end


# import words inot an array from a dictionary
dictionary_arr = IO.readlines('./dictionary.txt').map(&:chomp)

# random word selection
random_word = select_random_word(dictionary_arr)

# separate random word into letters
random_word_arr = random_word.chars
p random_word_arr

# random_word_arr length
random_word_length = random_word_arr.length

# create array which has the same size as the random_word_arr
guess_array = replace_letters(random_word_arr)
p guess_array

# turn counter
turns = 0

until guess_array == random_word_arr || turns == 15

  # get user input
  user_input = gets.chomp

  # check if user input matches a letter from the array
  if random_word_arr.include?(user_input)
    letter_index = random_word_arr.each_index.select {|index| random_word_arr[index] == user_input}
    # if letter matched, input it into position
    if letter_index.count == 1
      guess_array[letter_index[0]] = user_input
    elsif letter_index.count > 1
      letter_index.each {|index| guess_array[index] = user_input}
    end
    p guess_array
  else
    puts "Incorrect input! Please provide only 1 letter."
  end

  # add 1 more turn after input
  turns += 1
  # show current turn number
  puts "Turn number: #{turns}"
end