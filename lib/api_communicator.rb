require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)


  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  #films_array = []

  character_hash["results"].each do |character_attr|
    if character_attr["name"] == character
      character_films = character_attr["films"]
      #puts character_films

      character_films.each do |film|
        specific_film_info = RestClient.get(film)
        films_hash_info = JSON.parse(specific_film_info)
        films_array << films_hash_info
      end
    end
  end
  #binding.pry
  #puts

  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.


  parse_character_movies(films_array)

  films_array
end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?

puts get_character_movies_from_api("Luke Skywalker")
