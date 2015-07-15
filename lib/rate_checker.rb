module RateChecker
  def self.currencies
    %w(usd eur gbp cad chf cnh eur_usd)
  end

  class Base
    def initialize
      @agent = Mechanize.new
    end

    def execute
      value = get_rate_value
      save_rate(value)
      save_trend if on_trend?
    end

    private

    def agent
      @agent
    end

    def get_rate_value
      page = agent.get("https://www.google.com/finance/converter?a=1&from=#{converter_from}&to=#{converter_to}")
      page.search("span[@class='bld']").text.split[0]
    end

    def save_rate(value)
      Rate.create!(currency_pair: currency_pair, value: value)
      Rails.logger.info "[Saved] currency:#{currency_pair}, rate: #{value}"
    end

    def converter_from
      raise 'Undefined Converter From'
    end

    def converter_to
      raise 'Undefined Converter To'
    end

    def currency_pair
      [converter_from, converter_to].join('/')
    end

    def on_trend?
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
      @recently_rates ||= Rate.where(currency_pair: currency_pair).order("created_at DESC")[0..2]
    end

    def save_trend
      trend_value = (uptrend? ? 'up' : 'down')
      recently_rates[0].create_trend!(kind: trend_value)
      Rails.logger.info "[Trend] currency: #{currency_pair}, kind: #{trend_value}"
    end
  end
end
