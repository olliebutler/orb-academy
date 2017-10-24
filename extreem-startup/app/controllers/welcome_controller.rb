class WelcomeController < ApplicationController

  def index
    result = question
    render plain: result.to_s
  end

  private

  def question

    q = params[:q].split(' ',2).last
    words = q.gsub(/[^a-zA-Z ]/,'').gsub(/ +/,' ').split(/\W+/)
    numbers = q.split(' ').map { |i| i.delete('^0-9')  }.reject(&:empty?).map{|i| i.to_i}

    if words.include? 'largest'
      return numbers.max
    elsif (words.include? 'plus')  && !(words.include? 'multiplied')
      return numbers.sum
    elsif words.include? 'square'
      return find_square_cube(numbers).join(", ")
    elsif words.include? 'multiplied' && !(words.include? 'plus')
      return multiply(numbers)
    elsif words.include? 'banana' && !(words.include? 'scrabble')
      return "yellow"
    elsif (words.include? 'Prime') && (words.include? 'Minister')
      return 'Theresa May'
    elsif words.include? 'Spain'
      return "peseta"
    elsif words.include? 'Bond'
      return "Sean Connery"
    elsif (words.include? 'Eiffel') && (words.include? 'tower')
      return "Paris"
    elsif words.include? 'primes'
      return return_primes(numbers).join(", ")
    elsif words.include? 'Fibonacci'
      return fibonacci(numbers[0])
    elsif words.include? 'minus'
      return minus(numbers)
    elsif words.include? 'power'
      return power(numbers)
    elsif (words.include? 'plus') && (words.include? 'multiplied')
      return replace_symbols(q).to_s
    elsif words.include? 'banana' && (words.include? 'scrabble')
      return "8"
    elsif words.include? 'scrabble'
      return extract_word(q)
    elsif words.include? 'anagram'
      return anagram(q)
    end

  end

  @@scores = {"a" => 1, "e"=> 1, "i"=> 1, "l"=> 1, "n"=> 1, "o"=> 1, "r"=> 1, "s"=> 1, "t"=> 1, "u"=> 1,
  "d" => 2, "g" => 2, "b" => 3, "c"  => 3, "m" => 3, "p" => 3, "f" => 4, "h" => 4, "v" => 4, "w" => 4, "y" => 4,
  "k" => 5, "j" => 8, "x" => 8, "q" => 10, "z" => 10
  }

  def anagram(q)
    word = q.scan(/"([^"]*)"/).flatten[0]
    words = q.gsub(/[^a-zA-Z ]/,'').gsub(/ +/,' ').split(/\W+/)
    words.delete(word)

    return words.select { |w| w.chars.sort == word.chars.sort }.flatten[0]
  end

  def extract_word(q)
    res = 0
    q.split.last.chars.each { |chr| res += @@scores[chr]  }
    return res.to_s
  end

  def replace_symbols(q)
    return eval(q.gsub("plus", "+").gsub("multiplied by", "*").gsub(/[a-zA-Z ]/,''))
  end

  def power(numbers)
    numbers[0]**numbers[1]
  end

  def minus(numbers)

    res = numbers[0]

    1.upto(numbers.size-1).each do |i|
      res -= numbers[i]
    end

    return res
  end

  def find_square_cube(numbers)
    res = numbers.select do |number|
      Math.sqrt(number) % 1 == 0 && Math.cbrt(number) % 1 == 0
    end
  end

  def return_primes(numbers)

    numbers.select do |n|
      # factorial(n-1) % n == (n-1)
      prime(n)
    end
  end

  def factorial(n)
    (1..n).inject(:*) || 1
  end

  def prime(n)
    if n == 0
      return false
    end
    (2..n/2).none?{|i| n % i == 0}
  end

  def multiply(numbers)

    numbers.inject(1) do |product, n|
      product * n
    end
  end

  def fibonacci( n )
    return  n  if ( 0..1 ).include? n
    ( fibonacci( n - 1 ) + fibonacci( n - 2 ) )
  end
end
