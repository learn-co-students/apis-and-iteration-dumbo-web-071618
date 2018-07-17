require 'rest-client'
require 'json'
require 'pry'

def next_page(url)
  all_characters = RestClient.get(url)
  hash = JSON.parse(all_characters)
  return hash
end

def get_character_movies_from_api(character)
  #make the web request

  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  new_page = next_page(character_hash["next"])

  while new_page["next"] != nil
  character_hash["results"] << new_page["results"]
  new_page = next_page(new_page["next"])
    if new_page["next"] == nil
      character_hash["results"] << new_page["results"]
    end
  end


  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.

  character_arr =  character_hash["results"].flatten
  found_character = character_arr.find{|character_info| character_info["name"] == character }
  return found_character["films"]
end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  films_hash.each do |movie|
    movie_info = RestClient.get(movie)
    movie_hash = JSON.parse(movie_info)
    puts "==================="
    puts movie_hash["title"]
    puts "==================="
  end

end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
