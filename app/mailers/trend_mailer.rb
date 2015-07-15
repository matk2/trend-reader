class TrendMailer < ApplicationMailer

  def trend_email(user, trend, currency_pair)
    @user = user
    @trend = trend
    @currency_pair = currency_pair

    mail(to: @user.email, subject: 'Trend Mail')
  end
end
