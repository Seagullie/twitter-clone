class TweeetsController < ApplicationController # name is always plural and capitalized, but, if you need to reference it in root method
  # it will start with lowercase :shrug:
  before_action :set_tweeet, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /tweeets
  # GET /tweeets.json
  def index
    @tweeets = ((not user_signed_in?) ? Tweeet.all.order("created_at DESC") : current_user.tweeets.order("created_at DESC"))
    @tweet = Tweeet.new
    @user = current_user
  end

  # GET /tweeets/1
  # GET /tweeets/1.json
  def show
  end

  # GET /tweeets/new
  def new
    @tweeet = current_user.tweeets.build
  end

  # GET /tweeets/1/edit
  def edit
    @tweet = Tweeet.find(params[:id])
    @user = current_user
    # why is @user nill? Didn't i assign current user to it?
    # let's try assigning these value to self. gives 'undefined method `user' for #<TweeetsController'
    # What about making it a method then?
  end

  # POST /tweeets
  # POST /tweeets.json
  def create
    # @tweeet = Tweeet.new(tweeet_params)
    @tweeet = current_user.tweeets.build(tweeet_params)

    respond_to do |format| # what does this part do?
      if @tweeet.save
        format.html { redirect_to root_path, notice: ' ✔ Tweeet was successfully created.' } # what's this?
        format.json { render :show, status: :created, location: @tweeet } # and this?
      else
        format.html { render :new }
        format.json { render json: @tweeet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tweeets/1
  # PATCH/PUT /tweeets/1.json
  def update
    respond_to do |format|
      if @tweeet.update(tweeet_params)
        format.html { redirect_to @tweeet, notice: ' ✔ Tweeet was successfully updated.' }
        format.json { render :show, status: :ok, location: @tweeet }
      else
        format.html { render :edit }
        format.json { render json: @tweeet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweeets/1
  # DELETE /tweeets/1.json
  def destroy
    @tweeet.destroy
    respond_to do |format|
      format.html { redirect_to tweeets_url, notice: ' ✔ Tweeet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweeet
      @tweeet = Tweeet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tweeet_params
      params.require(:tweeet).permit(:tweeet)
    end

    def user
      return current_user
    end
end
