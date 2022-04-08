class HddsController < ApplicationController
  before_action :set_hdd, only: %i[ show edit update destroy ]

  # GET /hdds or /hdds.json
  def index
    @hdds = Hdd.all
  end

  # GET /hdds/1 or /hdds/1.json
  def show
  end

  # GET /hdds/new
  def new
    @hdd = Hdd.new
  end

  # GET /hdds/1/edit
  def edit
  end

  # POST /hdds or /hdds.json
  def create
    @hdd = Hdd.new(hdd_params)

    respond_to do |format|
      if @hdd.save
        format.html { redirect_to hdd_url(@hdd), notice: "Hdd was successfully created." }
        format.json { render :show, status: :created, location: @hdd }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @hdd.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hdds/1 or /hdds/1.json
  def update
    respond_to do |format|
      if @hdd.update(hdd_params)
        format.html { redirect_to hdd_url(@hdd), notice: "Hdd was successfully updated." }
        format.json { render :show, status: :ok, location: @hdd }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @hdd.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hdds/1 or /hdds/1.json
  def destroy
    @hdd.destroy

    respond_to do |format|
      format.html { redirect_to hdds_url, notice: "Hdd was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hdd
      @hdd = Hdd.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def hdd_params
      params.require(:hdd).permit(:hdd_type, :size)
    end
end
