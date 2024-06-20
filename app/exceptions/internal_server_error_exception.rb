# Generic resource bad request exception
class InternalServerErrorException < StandardError
  def initialize(message = 'Internal Server Error')
    super(message)
  end
end
