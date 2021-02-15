require 'open-uri'
require 'json'
class GamesController < ApplicationController
  def new
  # To display a new random grid of letters on the web
  alphabet = ("A".."Z").to_a
  # grid_size = rand(7...10)
  @letters = Array.new(10) { alphabet.sample } 
  end

  def score
    # Will receive the input of the user on the web form
    if grid_validator(params["grid"], params["word"].upcase)
      if word_hash(params["word"])["found"]
        @result = "Congratulations! #{params["word"].upcase} is a valid english word."
      else
        @result = "Sorry but #{params["word"].upcase} does not seem to be an english word."
      end
    else
      @result = "Sorry but #{params["word"].upcase} can't be built out of #{params["grid"].chars.join(", ")}."
    end
  end

  private

  def grid_validator(grid, attempt)
    attempt.chars.all? do |char|
      attempt.count(char) <= grid.count(char)
    end
  end 
  def word_hash(attempt)
    word_url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    word_serialized = open(word_url).read
    JSON.parse(word_serialized)
  end
  # def score_generator(number)
  #   time_score = time < 60 ? (60 - time) : 0
  #   number + time_score
  # end
end
