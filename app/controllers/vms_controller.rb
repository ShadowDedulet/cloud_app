class VmsController < ApplicationController
  before_action :set_vm, only: %i[show edit update destroy]

  # GET /vms or /vms.json
  def index
    @vms = Vm.all.map do |vm|
      {
        name: vm.name,
        cpu: vm.cpu,
        ram: vm.ram,
        hdds: vm.hdds.map { |h| [h.id, h.hdd_type, h.size] },
        projects: vm.projects.map { |p| [p.id, p.name, p.state] }
      }
    end
    render json: @vms
  end

  # GET /vms/1 or /vms/1.json
  def show; end

  # GET /vms/new
  def new
    @vm = Vm.new
  end

  # GET /vms/1/edit
  def edit; end

  # POST /vms or /vms.json
  def create
    @vm = Vm.new(vm_params)

    respond_to do |format|
      if @vm.save
        format.html { redirect_to vm_url(@vm), notice: 'Vm was successfully created.' }
        format.json { render :show, status: :created, location: @vm }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @vm.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vms/1 or /vms/1.json
  def update
    respond_to do |format|
      if @vm.update(vm_params)
        format.html { redirect_to vm_url(@vm), notice: 'Vm was successfully updated.' }
        format.json { render :show, status: :ok, location: @vm }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @vm.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vms/1 or /vms/1.json
  def destroy
    @vm.destroy

    respond_to do |format|
      format.html { redirect_to vms_url, notice: 'Vm was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_vm
    @vm = Vm.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def vm_params
    params.require(:vm).permit(:name, :cpu, :ram)
  end
end
