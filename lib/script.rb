#require yaml so we can export and import saves
require 'yaml'

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

# replace letters in array to display empty spaces to the player
def replace_letters(word_array)

  guess_array = word_array.collect do |element|
    element = '_'
  end

  guess_array
end

# save file implementation
def savegame(guess, word, turn)

  #save guess array as index 0 and random word as index 1
  game_data = [guess, word, turn]
  File.open('saves/savegame.yml','w') {|file| file.write(game_data.to_yaml)}
  
end

# load save file by using the values for guess and random word
def loadgame
  game_data = YAML.load(File.read('saves/savegame.yml'))
  game_data
end

# ask player if he wants to load last save or play a new game
puts 'Do you want to start a new game (ng) or to load your last save (loadgame)?'
game_start = gets.chomp
if game_start == 'loadgame'

  #load data from the savefile
  game_data = loadgame

  # asign save's random word
  random_word_arr = game_data[1]

  # asign save's guess
  guess_array = game_data[0]

  # asign save's turn
  turns = game_data[2]

  #message the player about current turn
  puts "Welcome back! Current turn: #{turns}"

  #print out
  p guess_array

elsif game_start == 'ng'
  puts 'Guess the below word in 15 turns!'

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

end


# input letters until time runs out OR guessed letters match random word
until guess_array == random_word_arr || turns == 15

  # get user input
  user_input = gets.chomp.downcase

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
  #save the game before input
  elsif user_input == 'savegame'
    savegame(guess_array, random_word_arr, turns)
    puts "Game saved!"
    turns -= 1
  else
    puts "Incorrect letter!"
  end

  # add 1 more turn after input
  turns += 1
  # show current turn number
  puts "Turn number: #{turns}"

  # winning and losing messages
  if guess_array == random_word_arr
    puts 'Congrats! You have guessed correctly!'
  elsif turns == 15
    puts 'You lost! Turns ended.'
  end

end



