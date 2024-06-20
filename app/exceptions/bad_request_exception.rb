# Generic resource bad request exception
class BadRequestException < StandardError
  def initialize(message = 'The request is invalid')
    super(message)
  end
end
