require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  # iterate over the character hash to find the collection of `films` for the given
  #   `character`

  if list_characters.find {|char_data| character == char_data["name"].downcase } != nil
    found_char = list_characters.find {|char_data| character == char_data["name"].downcase }
  else
    puts "Invalid inquiry. Try again"
    char = get_character_from_user
    return show_character_movies(char)
  end


  film_array = found_char["films"]

  # collect those film API urls, make a web request to each URL to get the info
  #  for that film

  film_data = []
  film_array.each do |film_url|
    film = JSON.parse(RestClient.get(film_url))
    film_data << film
  end

  film_data

  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
end

def initial_request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
end

def list_characters
  #get the first page of characters
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters) #=> first page
  character_data_list = []

  character_data_list << character_hash["results"]
  next_page = get_next_page(character_hash)

  until next_page["next"] == nil
    character_data_list << next_page["results"]
    next_page = get_next_page(next_page)
  end

  character_data_list << next_page["results"]
  character_data_list.flatten
  #from the first page, navigate to subsequent pages and extract data about those characters

end

def get_next_page(current_page)
  JSON.parse(RestClient.get(current_page["next"]))
end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  arr = []
  films_hash.each do |title|
    arr << title["title"]
  end
  arr.uniq!
  arr.each do |film|
    puts film
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
# parse_character_movies(get_character_movies_from_api "Luke Skywalker")
#get_character_movies_from_api "Luke Skywalker"
