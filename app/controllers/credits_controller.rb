class CreditsController < ApplicationController
  before_action :set_credit, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_user, only: [:index, :new, :show, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  # GET /credits
  # GET /credits.json
  def index
     if !params[:user_id].nil?
     user = User.find(params[:user_id])
	 end
     if user.nil?
	 user_email = current_user.email.to_s
	 @credits = Credit.where("email = ?", user_email)
	 else
    @credits = Credit.where("email = ?", user.email)
	end
  end

  # GET /credits/1
  # GET /credits/1.json
  def show
  end

  # GET /credits/new
  def new
    @credit = Credit.new
	@credit.add_percent(current_user.percent)
  end

  # GET /credits/1/edit
  def edit
  end

  # POST /credits
  # POST /credits.json
  def create
    @credit = Credit.new(credit_params)
    @credit.email = current_user.email
	@credit.create_amount(@credit.amount, current_user.percent, @credit.term)
    respond_to do |format|
      if @credit.save
        format.html { redirect_to '/credits', notice: 'Credit was successfully created.' }
        format.json { render :show, status: :created, location: @credit }
      else
        format.html { render :new }
        format.json { render json: @credit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /credits/1
  # PATCH/PUT /credits/1.json
  def update
    respond_to do |format|
      if @credit.update(credit_params)
        format.html { redirect_to '/credits', notice: 'Credit was successfully updated.' }
        format.json { render :show, status: :ok, location: @credit }
      else
        format.html { render :edit }
        format.json { render json: @credit.errors, status: :unprocessable_entity }
      end
    end
  end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_credit
      @credit = Credit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def credit_params
      params.require(:credit).permit(:email, :amount, :term, :payment, :status)
    end
	
    def signed_in_user
      redirect_to signin_url, notice: "Please sign in." unless signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
