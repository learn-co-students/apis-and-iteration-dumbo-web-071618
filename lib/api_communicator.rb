require 'rest-client'
require 'json'
require 'pry'

def fetch_and_parse(url)
  JSON.parse(RestClient.get(url))

end

def get_character_movies_from_api(character)
  character_hash = fetch_and_parse("http://www.swapi.co/api/people/")

  # found_char = character_hash["results"].find do |hash|
  #   hash["name"] == character
  # end
  #
  # found_char['films']

  character_hash["results"].each do |hash|
    if hash["name"] == character
      return hash["films"]
    else
      puts "Please enter valid name."
    end
  end
end

# def get_character_movies_from_api(character)
#   #make the web request
#   all_characters = RestClient.get('http://www.swapi.co/api/people/')
#   character_hash = JSON.parse(all_characters)
#
#
#   # iterate over the character hash to find the collection of `films` for the given
#   #   `character`
#   # collect those film API urls, make a web request to each URL to get the info
#   #  for that film
#   # return value of this method should be collection of info about each film.
#   #  i.e. an array of hashes in which each hash reps a given film
#   # this collection will be the argument given to `parse_character_movies`
#   #  and that method will do some nice presentation stuff: puts out a list
#   #  of movies by title. play around with puts out other info about a given film.
#
#
#   character_hash["results"].each do |hash|
#
#
#     if hash["name"] == character
#       return hash["films"]
#     end
#   end
#
# end

# puts get_character_movies_from_api("Luke Skywalker")

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list

  films_hash.each do |address|
    puts JSON.parse(RestClient.get(address))["title"]
  end
end

# parse_character_movies(["https://www.swapi.co/api/films/2/",
#       "https://www.swapi.co/api/films/6/",
#       "https://www.swapi.co/api/films/3/",
#       "https://www.swapi.co/api/films/1/",
#       "https://www.swapi.co/api/films/7/"])

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)

  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
