class ReportsController < ApplicationController
  def balance

    UserMailer.balance_report(current_user).deliver_later

    redirect_to root_path, notice: 'Você receberá um relatório por e-mail'
  end
end
