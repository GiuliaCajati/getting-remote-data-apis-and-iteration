require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)

  char_name_formatting = character_name.split(" ")
  char_name_formatting = char_name_formatting.map { |w| w.capitalize}
  character_name = char_name_formatting.join(" ")
  
  #make the web request
  response_string = RestClient.get('http://swapi.dev/api/people')
  response_hash = JSON.parse(response_string)

  character_info = response_hash["results"].detect do |character|
    character["name"] == character_name
  end

  film_hash = character_info["films"].map do |film|
    JSON.parse(RestClient.get(film))
  end

  movie_info = film_hash.map do |film|
    {film["title"] => film["release_date"]}
  end


  return movie_info
  # binding.pry 
  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
end


def print_movies(films)
  films.each do |film|
    if film == films[0]
      film.each { |k, v| puts "\nTitle: #{k}\nRelease Date: #{v}\n**************"}
    elsif film == films[-1]
      film.each { |k, v| puts "Title: #{k}\nRelease Date: #{v}"}
    else
      film.each { |k, v| puts "Title: #{k}\nRelease Date: #{v}\n**************"}
    end
  end
  # some iteration magic and puts out the movies in a nice list
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
