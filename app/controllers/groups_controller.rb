class GroupsController < ApplicationController
  before_action :set_group, only: %i[ show edit update destroy ]

  # GET /groups or /groups.json
  def index
    groups = Group.all
    groups = groups.where(name: params[:name]) if params[:name]
    render json: groups.select(:id, :name)
  end

  # GET /groups/1 or /groups/1.json
  def show
    return head :not_found unless @group 

    render json: @group
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups or /groups.json
  def create
    group = Group.create(group_params)
    render json: { id: group.id, name: group.name }
  end

  # PATCH/PUT /groups/1 or /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to group_url(@group), notice: "Group was successfully updated." }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1 or /groups/1.json
  def destroy
    @group.destroy

    return head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find_by_id(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def group_params
      params.require(:group).permit(:name)
    end
end
