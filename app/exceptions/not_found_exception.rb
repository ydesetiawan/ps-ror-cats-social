# Generic resource bad request exception
class NotFoundException < StandardError
  def initialize(message = 'The request is not found')
    super(message)
  end
end
