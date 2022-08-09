module Api
  module V1
    class BankAccountsController < ApplicationController
      def new_transaction     
        errors = ::BankAccounts::ValidateNewTransaction.new(
          amount: params[:amount],
          transaction_type: params[:transaction_type],
          bank_account_id: params[:bank_account_id],
          recipient_id: params[:recipient_id]).execute!
        bank_account = ::BankAccounts::PerformTransaction.new(
          amount: params[:amount],
          transaction_type: params[:transaction_type],
          bank_account_id: params[:bank_account_id],
          recipient_id: params[:recipient_id]).execute! unless errors.size > 0
        render json: { errors: errors }, status: 402 if errors.size > 0
        render json: { balance: bank_account.balance }  unless errors.size > 0        
      end
    end
  end
end