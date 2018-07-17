require 'rest-client'
require 'json'
require 'pry'

def get_character_info(character)
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
<<<<<<< HEAD


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
=======
  character_hash
end

def get_character_movies_from_api(character)
  #make the web request

  films_array = []

  character_data = get_character_info(character)["results"].find do |char|
    char["name"].downcase == character
  end

  if character_data == nil
    abort "I don't recognize that character's name. Are you thinking of Star Trek?"
  else
      character_data["films"]
  end
end
>>>>>>> 3b4690d42e520e2813ab81c0ac53f53f763a3d6f
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
<<<<<<< HEAD


  parse_character_movies(films_array)

  films_array
end
=======
>>>>>>> 3b4690d42e520e2813ab81c0ac53f53f763a3d6f

def parse_character_movies(films_hash)
  # films_hash = array of urls
  film_data_list = []

  films_hash.each do |film_url|
    film_data = RestClient.get(film_url)
    film_data_list << JSON.parse(film_data.body)['title']
  end

  film_data_list
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  film_titles = parse_character_movies(films_hash)
  puts " "
  puts "#{character} is in the following films:"
  puts " "
  puts film_titles
end
## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?

puts get_character_movies_from_api("Luke Skywalker")
