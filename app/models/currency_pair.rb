class CurrencyPair < ActiveRecord::Base
  has_many :rates

  def self.fetch_rate
    all.each do |currency_pair|
      currency_pair.fetch_rate
    end
  end

  def fetch_rate
    value = get_rate_value
    save_rate(value)
    save_trend
  end

  def display_name
    [base, quote].join('/')
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
    Rails.logger.info "[Saved] currency:#{display_name}, rate: #{value}"
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
      Rails.logger.info "[Trend] currency: #{display_name}, kind: #{trend_value}"

      TrendMailer.trend_email(user, trend_value, display_name).deliver
    end
  end
end
