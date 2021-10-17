class WordGuesserGame
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

  def initialize(word=WordGuesserGame.get_random_word, guesses = '',wrong_guesses='')
    @word = word
    @guesses = guesses
    @wrong_guesses = wrong_guesses
  end

  #getter for attribute: word
  def word
    @word
  end

  #setter for attribute: word 
  def word=(word)
    @word=word
  end

  #getter for attribute: guesses
  def guesses
    @guesses
  end
    
  #setter for attribute: guesses
  def guesses=(guesses)
    @guesses=guesses
  end
  
  #getter for attribute: wrong_guesses
  def wrong_guesses
	  @wrong_guesses
  end
  
  #setter for attribute: guesses
  def wrong_guesses=(wrong_guesses)
	  @wrong_guesses=wrong_guesses
  end

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end


  def guess(letter)
    
    letter = letter.downcase if(letter != nil)

    raise ArgumentError.new("Not a valid letter") if (letter.nil? or /[^A-Za-z]/.match(letter) != nil or letter == '')
    
    return false if (@guesses.include? letter or @wrong_guesses.include? letter)
    
    if @word.include? letter
      @guesses += letter
      return true
    else
      @wrong_guesses += letter
      return true
    end
  end
    
  def word_with_guesses
    t=@guesses
    return @word.gsub(/[^ #{t}]/, '-')
  end

  def check_win_or_lose
    return :lose if (@wrong_guesses.length >= 7)
  
    return :win if (word_with_guesses == @word)
    
    return :play
  end

end
