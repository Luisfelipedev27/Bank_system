class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @bank_account = BankAccount.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      user = User.last
      BankAccount.create!(user: user)
      log_in @user
      flash[:success] = "Bem vindo à NOBE Sistemas! Sua conta foi criada com sucesso!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
