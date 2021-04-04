class CharactersController < ApplicationController
  before_action :require_signin, only: %i[ new edit create update destroy]
  before_action :set_character, only: %i[ show edit update destroy ]

  # GET /characters or /characters.json
  def index
    if current_user_admin?
      @characters = Character.all
    elsif current_user
      @characters = Character.where(user_id: current_user.id)
    else
      @characters = []
    end
  end

  # GET /characters/1 or /characters/1.json
  def show
    not_found unless user_can_access_character
  end

  # GET /characters/new
  def new
    @character = Character.new
  end

  # GET /characters/1/edit
  def edit
    not_found unless user_can_access_character
  end

  # POST /characters or /characters.json
  def create
    @character = Character.new(character_params)
    @character.user = current_user

    respond_to do |format|
      if @character.save
        format.html { redirect_to @character, notice: "Character was successfully created." }
        format.json { render :show, status: :created, location: @character }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @character.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /characters/1 or /characters/1.json
  def update
    respond_to do |format|
      if @character.update(character_params)
        format.html { redirect_to @character, notice: "Character was successfully updated." }
        format.json { render :show, status: :ok, location: @character }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @character.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /characters/1 or /characters/1.json
  def destroy
    @character.destroy
    respond_to do |format|
      format.html { redirect_to characters_url, notice: "Character was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_character
    @character = Character.find(params[:id])
  end

  def user_can_access_character
    current_user_admin? || current_user&.id == @character.user_id
  end

  # Only allow a list of trusted parameters through.
  def character_params
    params.require(:character).permit(:name, :user_id)
  end
end
