require 'rest-client'
require 'json'
require 'pry'

def character_hashes(link) 
  response = JSON.parse(RestClient.get(link))
  i = 2
  arr = response["results"]
  while true
  
    response = JSON.parse(RestClient.get(response["next"]))

    response["results"].each {|char| arr << char}
    
    break if response["next"] == nil
    i += 1
  end
  arr
end

def get_character_movies_from_api(character)
  #make the web request
  # if character_hash["results"]["name"]
  # endß
  link = "https://www.swapi.co/api/people/"
  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
  film_links = character_hashes(link).find do|el|
    el["name"] == character
  end

  film_links["films"].map do |film_link|
    JSON.parse(RestClient.get(film_link))
  end
end




def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  films_hash.collect {|ele| ele["title"]}

end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?

# puts get_character_movies_from_api("Luke Skywalker")



