class OrdersController < ApplicationController
  before_action :set_order, only: %i[show edit update destroy]

  # GET /orders or /orders.json
  def index
    @orders = Order.eager_load(:networks, :tags).map do |order|
      next unless (order.networks || orders.tags)
      {
        name: order.name,
        created_at: order.created_at,
        network_count: order.networks.length,
        tags: order.tags.map { |t| [t.id, t.name] }
      }
    end

    # @orders = Order.all.map do |o|
    #   {
    #     name: o.name,
    #     created_at: o.created_at,
    #     network_count: o.networks.length,
    #     tags: o.tags.select(:id, :name)
    #   }
    # end

    render json: { orders: @orders }
  end

  # GET /orders/1 or /orders/1.json
  def show; end

  # GET /orders/new
  def new
    @order = Order.new
    puts("\nparams: #{params.inspect}\n")
  end

  # GET /orders/1/edit
  def edit; end

  # POST /orders or /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to order_url(@order), notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to order_url(@order), notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def approve
    render json: params
  end

  def calc
    render plain: rand(100).floor
  end

  def first
    @order = Order.first
    return render plain: 'empty' unless @order

    render :show
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def order_params
    params.require(:order).permit(:name, :status, :cost)
  end
end
