class CaregoriesController < ApplicationController
  before_action :set_caregory, only: [:show, :edit, :update, :destroy]

  # GET /caregories
  # GET /caregories.json
  def index
    @caregories = Caregory.all
  end

  # GET /caregories/1
  # GET /caregories/1.json
  def show
  end

  # GET /caregories/new
  def new
    @caregory = Caregory.new
  end

  # GET /caregories/1/edit
  def edit
  end

  # POST /caregories
  # POST /caregories.json
  def create
    @caregory = Caregory.new(caregory_params)

    respond_to do |format|
      if @caregory.save
        format.html { redirect_to @caregory, notice: 'Caregory was successfully created.' }
        format.json { render :show, status: :created, location: @caregory }
      else
        format.html { render :new }
        format.json { render json: @caregory.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /caregories/1
  # PATCH/PUT /caregories/1.json
  def update
    respond_to do |format|
      if @caregory.update(caregory_params)
        format.html { redirect_to @caregory, notice: 'Caregory was successfully updated.' }
        format.json { render :show, status: :ok, location: @caregory }
      else
        format.html { render :edit }
        format.json { render json: @caregory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /caregories/1
  # DELETE /caregories/1.json
  def destroy
    @caregory.destroy
    respond_to do |format|
      format.html { redirect_to caregories_url, notice: 'Caregory was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_caregory
      @caregory = Caregory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def caregory_params
      params.require(:caregory).permit(:name, :node, :tree)
    end
end
