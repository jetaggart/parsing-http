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

  def version
    status_line.
      match(/^(HTTP\/\d\.\d)/).
      captures.
      first
  end

  def body
    http_response[line_break_index + 1..-1].join
  end

  def header
    http_response[1...line_break_index].each_with_object({}) do |header_string, headers|
      split_header = header_string.split(":", 2)
      headers[split_header.first] = split_header.last.strip
    end
  end

  def content_type
    header["Content-Type"]
  end

  def server
    header["Server"]
  end

  def location
    header["Location"]
  end

  private

  attr_reader :http_response

  def line_break_index
    http_response.find_index("")
  end

  def status_line
    http_response.first
  end

end