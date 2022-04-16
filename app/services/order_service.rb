require 'json'

# Service providing full logic for 'orders/check'
class OrderService
  attr_reader :params, :session

  def initialize(params, session)
    @session = session
    @params = params
  end

  def call
    # Parse needed params
    @params = VmParamsService.parse_params(@params)

    # Store available specs in session (fetch if needed)
    unless session[:specs]
      data = FetchService.fetch('http://possible_orders.srv.w55.ru')
      session[:specs] = JSON.parse(data)['specs']
    end

    # Check if params fir specs
    unless VmParamsService.check_specs(session[:specs], @params)
      return ResponseService.call(false, :not_acceptable, error: 'Configuration is not available')
    end

    # Fetch price of given VM
    total = Integer FetchService.fetch('http://http_server:8080/get_price', @params)

    # Check if VM affordable
    return ResponseService.call(false, :not_acceptable, error: 'Insufficient funds') if total > session[:balance]

    # Return needed data
    args = {
      total: total,
      balance: session[:balance],
      balance_after_transaction: session[:balance] - total
    }
    ResponseService.call(true, :ok, args: args)
  rescue ArgumentError => e
    ResponseService.call(false, :not_acceptable, error: e)
  rescue SocketError, OpenURI::HTTPError, Errno::ECONNREFUSED => e
    ResponseService.call(false, :service_unavailable, error: e)
  end
end