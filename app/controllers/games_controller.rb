require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @letters = 10.times.map { ('a'..'z').to_a.sample }
  end

  def score
    @letters = params[:longest_word_rand]
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    word_read = open(url).read
    word_dic = JSON.parse(word_read)
    if word_dic["found"] == false
      @score = "Sorry but #{params[:word]} doesn't seem to be an English word..."
    elsif
      word_array = params[:word].upcase.split('')
      word_array.all? { |letter| word_array.count(letter) <= @letters.count(letter) }
      @score = "Congratulations! #{params[:word]} is a valid English word!"
     else
     @score = "Sorry but #{params[:word]} can't be made from #{@letters}"
    end
  end
end
