class CreditCardChargesController < ApplicationController
  before_action :set_credit_card_charge, only: [:show, :edit, :update, :destroy]

  # GET /credit_card_charges
  # GET /credit_card_charges.json
  def index
    @failed_charges = CreditCardCharge.where(paid: false)
    @disputed_charges = CreditCardCharge.where(paid: true, refunded: true)
    @successful_charges = CreditCardCharge.where(paid: true, refunded: false)
    @credit_card_charges = CreditCardCharge.all
  end

  # GET /credit_card_charges/1
  # GET /credit_card_charges/1.json
  def show
  end

  # GET /credit_card_charges/new
  def new
    users = User.all
    @users = users.map{ |user| user.first_name + " " + user.last_name }
    companies = Company.all
    @companies = companies.map{ |company| company.name }
    @credit_card_charge = CreditCardCharge.new
  end

  # GET /credit_card_charges/1/edit
  def edit
  end

  # POST /credit_card_charges
  # POST /credit_card_charges.json
  def create
    @credit_card_charge = CreditCardCharge.new(credit_card_charge_params)

    user = params["credit_card_charge"]["user_id"]
    user_names = user.scan(/\w+/) 
    company = params["credit_card_charge"]["company_id"]

    unless user.empty?
      user_id = User.where(first_name: user_names[0], last_name: user_names[1]).first.id
      @credit_card_charge.update(user_id: user_id,unique_code: Faker::Code.isbn, paid: true, refunded: false)
    end
    
    unless company.empty?
      company_id = Company.where(name: company).first.id
      @credit_card_charge.update(company_id: company_id,unique_code: Faker::Code.isbn, paid: true, refunded: false)
    end 


    respond_to do |format|
      if @credit_card_charge.save
        format.html { redirect_to @credit_card_charge, notice: 'Credit card charge was successfully created.' }
        format.json { render :show, status: :created, location: @credit_card_charge }
      else
        format.html { render :new }
        format.json { render json: @credit_card_charge.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /credit_card_charges/1
  # PATCH/PUT /credit_card_charges/1.json
  def update
    respond_to do |format|
      if @credit_card_charge.update(credit_card_charge_params)
        format.html { redirect_to @credit_card_charge, notice: 'Credit card charge was successfully updated.' }
        format.json { render :show, status: :ok, location: @credit_card_charge }
      else
        format.html { render :edit }
        format.json { render json: @credit_card_charge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /credit_card_charges/1
  # DELETE /credit_card_charges/1.json
  def destroy
    @credit_card_charge.destroy
    respond_to do |format|
      format.html { redirect_to credit_card_charges_url, notice: 'Credit card charge was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_credit_card_charge
      @credit_card_charge = CreditCardCharge.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def credit_card_charge_params
      params.require(:credit_card_charge).permit(:amount, :unique_code, :paid, :refunded, :user_id, :company_id)
    end
end
