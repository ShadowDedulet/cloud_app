# docker-compose run --rm -it -p 3000:3000 app bash
# docker run --rm -it -p 8080:3000 hw4

require 'uri'
require 'open-uri'
require 'json'

class OrderService
  attr_reader :params, :session

  def initialize(params, session)
    @session = session

    parse_params(params)
  end
  
  def call
    fetch_specs

    return {
      response: { result: false, error: "Configuration is not available" },
      status: :not_acceptable
    } unless check_params

    total = Integer(get_cost)

    return {
      response: { result: false, error: "Insufficient funds" },
      status: :not_acceptable
    } unless total <= session[:balance]

    return { 
      response: {
        result: true,
        total: total,
        balance: session[:balance],
        balance_after_transaction: session[:balance] - total,
      },
      status: :ok
    }

  rescue SocketError, OpenURI::HTTPError
    return {
      response: { result: false, error: "Could not connect to services" },
      status: :service_unavailable
    }
  end

  private

  def parse_params(params)
    raise ArgumentError, "Wrong hdd type" unless %w[sata sas ssd].include?(params[:hdd_type]) 
    raise ArgumentError, "Wrong os" unless %w[windows linux].include?(params[:os])

    @params = {
      'os' => params[:os],
      'cpu' => Integer(params[:cpu]),
      'ram' => Integer(params[:ram]),
      'hdd_type' => params[:hdd_type],
      'hdd_capacity' => Integer(params[:hdd_capacity])
    }
  end


  def fetch_specs
    return if session[:specs]

    url = 'http://possible_orders.srv.w55.ru'
    puts("fetching specs from #{url}...")
    session[:specs] = JSON.parse(open(url, &:read))['specs']
  end


  def compare(spec)
    spec.each do |k, v|
      if k == 'hdd_capacity'
        type = @params['hdd_type']
        rng = v[type]['from']..v[type]['to']
        return false unless rng.include?(@params[k])
      else
        return false unless v.include?(@params[k])
      end
    end
    true
  end


  def check_params
    session[:specs].any? { |spec| compare(spec) }
  end


  def get_cost
    url = 'http://server:8080/get_price'
    puts("fetching price from #{url}...")

    uri = URI.parse(url)
    uri.query = URI.encode_www_form(@params)

    open(uri, &:read)
  end
end
