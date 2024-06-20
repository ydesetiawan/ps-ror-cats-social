# Generic resource bad request exception
class ConflictException < StandardError
  def initialize(message = 'The request is conflict')
    super(message)
  end
end
