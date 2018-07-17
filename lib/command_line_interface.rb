def welcome
  puts "Welcome to the most amazing app in a galaxy far, far away!"
  puts " "
end

def get_character_from_user
  puts "Please enter a character:"
  character = gets.chomp
  character.downcase
  # use gets to capture the user's input. This method should return that input, downcased.
end
