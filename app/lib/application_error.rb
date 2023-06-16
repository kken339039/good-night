class ApplicationError < StandardError
  def initialize(message = nil)
    super(message)
  end

  def status
    :bad_request
  end

  def as_json(*)
    { error_message: message }
  end
end

