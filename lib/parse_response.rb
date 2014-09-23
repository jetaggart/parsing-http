class HTTPResponseParser

  def initialize(http_response)
    @http_response = http_response.split("\n")
  end

  def response_code
    status_line.
      match(/^HTTP\/\d\.\d (\d+)/).
      captures.
      first.
      to_i
  end

  private

  attr_reader :http_response

  def status_line
    http_response.first
  end

end