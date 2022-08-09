module BankAccounts
  class ValidateNewTransaction
    def initialize(amount:, transaction_type:, bank_account_id:, recipient_id:)
      @amount = amount.try(:to_f)
      @transaction_type = transaction_type
      @bank_account_id = bank_account_id
      @recipient_id = recipient_id
      @bank_account = BankAccount.where(id: @bank_account_id).first
      @recipient_account = BankAccount.where(account_number: @recipient_id).first
      @errors = []
    end

    def execute!
      validate_existence_of_account!
      #validate_transfer_tax!
      validate_transaction! if account_present && transaction_deduction
      @errors
    end

    private

      def validate_transaction!
        @errors << "Fundo insuficiente" if @bank_account.balance - @amount < 0.00
        @errors << "Valor não pode ser negativo" if @amount < 0.00  
      end

      #def validate_transfer_tax! (O método falhou! Era para estipular valor mínimo em conta para que fizesse sentido a taxa de 5 reais)
       # @errors << "Saldo insuficiente. Taxa de operação: 5 R$" if @bank_account.balance < 5.00
      #end
      #O problema é que ele taxava todas as operações, em vez de taxar apenas a de transferência
      def account_present
        @bank_account.present? && @recipient_account.present?
      end
      def transaction_deduction
        %w(Saque Transferencia).include?(@transaction_type)
      end
      
      def validate_existence_of_account!
        @errors << "Conta não encontrada" if @bank_account.blank?
        @errors << "Destinatário não encontrado" if @recipient_account.blank?
      end
  end
end