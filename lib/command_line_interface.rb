def welcome
  # puts out a welcome message here!
end

def get_character_from_user
  puts "Please enter a character: "
  character = gets.chomp
  character.downcase
  # use gets to capture the user's input. This method should return that input, downcased.
  chracter = gets.chomp.downcase!

end
