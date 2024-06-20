# Generic resource bad request exception
class UnauthorizedException < StandardError
  def initialize(message = 'The request is unauthorized')
    super(message)
  end
end
