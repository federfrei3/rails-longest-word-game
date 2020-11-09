require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    # Idee -> random number 4 - 10 letters
    grid = Array.new(10) { ('A'..'Z').to_a.sample }
    @letters = grid.join
  end

  def score
    
    @word = params[:input].upcase
    @grid = params[:letter].upcase

    # test = included?(@word, @grid)
    # english_word = english_word?(@word)
    # raise
    
    if included?(@word, @grid)
      if english_word?(@word)
        @answer = "Congratulations! #{@word} is a valid English word!"
      else
        @answer = "Sorry, but #{@word} does not seem to be a valid English word!"
      end
    else
      @answer = "Sorry but #{@word} cannot be build of #{@grid} "
    end
  end

  private

  def included?(word, grid)
    word.chars.all? { |letter| word.count(letter) <= grid.count(letter) }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end

end

