class Password
  MIN_LENGTH = 6

  attr_reader :password

  def initialize(password)
    @password = password.to_s
  end

  def valid?
    chunked = password.chars.chunk{ |x| x }
    chunked.each_cons(2).all? { |a, b| a[0] < b[0] } &&
      chunked.any? { |x| x[1].length == 2 }
  end
end
