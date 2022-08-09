class BankAccountsController < ApplicationController
  def show
    @bank_account = BankAccount.find(params[:id])
  end
end
