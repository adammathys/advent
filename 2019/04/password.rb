class Password
  MIN_LENGTH = 6

  attr_reader :password

  def initialize(password)
    @password = password.to_s
  end

  def valid?
    password.squeeze.length != MIN_LENGTH &&
      password.split('').each_cons(2).all? { |a, b| a <= b }
  end

  def super_valid?
    valid? && password.split('').chunk{ |x| x }.any?{ |x| x[1].length == 2 }
  end
end
