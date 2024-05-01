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

# import words inot an array from a dictionary
dictionary_arr = IO.readlines('./dictionary.txt').map(&:chomp)

# random word selection
random_word = select_random_word(dictionary_arr)

# separate random word into letters
random_word_arr = random_word.chars
p random_word_arr

# random_word_arr length
random_word_length = random_word_arr.length
p random_word_length

# create array which has the same size as the random_word_arr
# player will input letters into it to match the random_word_arr
