require 'rails_helper'
require_relative './../data/orders_data_spec'

RSpec.describe OrdersController, type: :controller do
  describe 'GET #check' do
    it 'returns error with no login & balance' do
      get :check
      expect(JSON.parse(response.body)).to eq({ 'result' => false, 'error' => 'No user-name/balance' })
      expect(response.status).to eq(401)
    end

    it 'returns error with no balance' do
      get :check, session: { login: 123 }
      expect(JSON.parse(response.body)).to eq({ 'result' => false, 'error' => 'No user-name/balance' })
      expect(response.status).to eq(401)
    end

    it 'returns error with no login' do
      get :check, session: { balance: 10_000 }
      expect(JSON.parse(response.body)).to eq({ 'result' => false, 'error' => 'No user-name/balance' })
      expect(response.status).to eq(401)
    end

    it 'returns error with no vm specs' do
      get :check, session: { login: 123, balance: 10_000 }
      expect(JSON.parse(response.body)).to eq({ 'result' => false, 'error' => 'Wrong hdd type' })
      expect(response.status).to eq(406)
    end

    it 'returns error with service off' do
      allow(FetchService).to receive(:fetch).and_raise(SocketError)

      get :check, session: { login: 123, balance: 10_000 }, params: OrdersSpecData.test_specs
      expect(JSON.parse(response.body).keys).to contain_exactly('result', 'error')
      expect(response.status).to eq(503)
    end

    it 'returns insufficient funds error' do
      stub_request(:get, 'http://possible_orders.srv.w55.ru/')
        .to_return(status: 200, body: OrdersSpecData.available_specs.to_json)

      stub_request(:get, 'http://http_server:8080/get_price?cpu=4&ram=4&hdd_capacity=50&hdd_type=sata&os=linux&ram=4')
        .to_return(status: 200, body: OrdersSpecData.correct_price.to_s)

      get :check, session: { login: 123, balance: 10_000 }, params: OrdersSpecData.test_specs
      expect(JSON.parse(response.body)).to eq({ 'result' => false, 'error' => 'Insufficient funds' })
      expect(response.status).to eq(406)
    end

    it 'returns correct positive response' do
      balance = 100_000
      ret = {
        'result' => true,
        'balance' => balance,
        'balance_after_transaction' => balance - OrdersSpecData.correct_price,
        'total' => OrdersSpecData.correct_price
      }

      stub_request(:get, 'http://possible_orders.srv.w55.ru/')
        .to_return(status: 200, body: OrdersSpecData.available_specs.to_json)

      stub_request(:get, 'http://http_server:8080/get_price?cpu=4&ram=4&hdd_capacity=50&hdd_type=sata&os=linux&ram=4')
        .to_return(status: 200, body: OrdersSpecData.correct_price.to_s)

      get :check, session: { login: 123, balance: balance }, params: OrdersSpecData.test_specs
      expect(JSON.parse(response.body)).to eq(ret)
      expect(response.status).to eq(200)
    end
  end
end
