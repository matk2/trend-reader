class CurrencyPair < ActiveRecord::Base
  has_many :rates

  def fetch_rate
    value = get_rate_value
    save_rate(value)
    save_trend
  end

  private

  def agent
    @agent ||= Mechanize.new
  end

  def get_rate_value
    page = agent.get("https://www.google.com/finance/converter?a=1&from=#{base}&to=#{quote}")
    page.search("span[@class='bld']").text.split[0]
  end

  def save_rate(value)
    rates.create(value: value)
    Rails.logger.info "[Saved] currency:#{currency_pair}, rate: #{value}"
  end

  def currency_pair
    [base, quote].join('/')
  end

  def on_trend?
    return unless recently_rates.count >= 3
    uptrend? || downtrend?
  end

  def uptrend?
    (recently_rates[0].value > recently_rates[1].value) &&
      recently_rates[1].value > recently_rates[2].value
  end

  def downtrend?
    (recently_rates[0].value < recently_rates[1].value) &&
      (recently_rates[1].value < recently_rates[2].value)
  end

  def recently_rates
    @recently_rates ||= rates.order("created_at DESC")[0..2]
  end

  def save_trend
    User.all.each do |user|
      next unless on_trend?

      trend_value = (uptrend? ? 'up' : 'down')
      recently_rates[0].create_trend!(kind: trend_value)
      Rails.logger.info "[Trend] currency: #{currency_pair}, kind: #{trend_value}"

      TrendMailer.trend_email(user, trend_value, currency_pair).deliver
    end
  end
end
