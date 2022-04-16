# Service providing method for creating json responses
module ResponseService
  def self.call(result, status, error: nil, args: nil)
    res = { response: { result: result }, status: status }
    res[:response][:error] = error if error
    res[:response].merge!(args) if args
    res
  end
end
