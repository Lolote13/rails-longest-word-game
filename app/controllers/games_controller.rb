require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = (0...10).map { ("A".."Z").to_a[rand(26)] }
  end

  def score
    @grid = params[:grid]
    @word = params[:word]
    if in_grid?
      if word_exist?
        @response = "Great"
      else
        @response = "Not English word..."
      end
    else
      @response = "Letters not in grid"
    end
  end

  private

  def in_grid?
    @result_grid = true
    @word_array = @word.chars
    @grid_array = @grid.chars
    @word_array.each do |letter|
      @result_grid = false if !@grid_array.include? letter
    end
    return @result_grid
  end

  def word_exist?
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    serialized_word = open(url).read
    result = JSON.parse(serialized_word)
    @result_dico = result["found"]
  end

end
