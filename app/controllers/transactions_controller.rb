class TransactionsController < ApplicationController
  before_action :authenticate_user!,:set_transaction, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /transactions
  # GET /transactions.json
  def index
    @transactions = Transaction.all.order(created_at: :asc)
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions
  # POST /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.user_id = current_user.id
    respond_to do |format|
      if @transaction.save
        PaybackUpdateWorker.perform_async(@transaction.user_id)
        format.html { redirect_to @transaction, notice: 'Transaction was successfully created' }
      else
        format.html { render :new }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def transaction_params
    params.require(:transaction).permit(:transaction_description, :amount_spent, :transaction_type)
  end
end
