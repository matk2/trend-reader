class TrendReadService
  attr_reader :user, :currency_pair

  def self.execute
    User.all.each do |user|
      CurrencyPair.all.each do |currency_pair|
        trend_reader = new(user, currency_pair)
        trend_reader.execute
      end
    end
  end

  def initialize(user, currency_pair)
    @user = user
    @currency_pair = currency_pair
  end

  def execute
    return unless on_trend?

    user.trends.create(kind: trend_value, rete_id: recently_rates[0].id)
    Rails.logger.info "[Trend] currency: #{currency_pair.display_name}, kind: #{trend_value}"

    TrendMailer.trend_email(user, trend_value, currency_pair.display_name).deliver
  end

  def on_trend?
    return unless recently_rates.count >= 3
    uptrend? || downtrend?
  end

  def recently_rates
    @recently_rates ||= currency_pair.rates.order("created_at DESC")[0..2]
  end

  def uptrend?
    (recently_rates[0].value > recently_rates[1].value) &&
      (recently_rates[1].value > recently_rates[2].value)
  end

  def downtrend?
    (recently_rates[0].value < recently_rates[1].value) &&
      (recently_rates[1].value < recently_rates[2].value)
  end

  def trend_value
    @trend_value ||= (uptrend? ? 'up' : 'down')
  end
end
