class CurrencyPair < ActiveRecord::Base
  has_many :rates

  def self.fetch_rate
    all.each do |currency_pair|
      currency_pair.fetch_rate
    end
  end

  def fetch_rate
    value = get_rate_value
    rates.create(value: value)
    Rails.logger.info "[Saved] currency:#{display_name}, rate: #{value}"
  end

  def get_rate_value
    page = agent.get("https://www.google.com/finance/converter?a=1&from=#{base}&to=#{quote}")
    page.search("span[@class='bld']").text.split[0]
  end

  def display_name
    [base, quote].join('/')
  end

  private

  def agent
    return @agent if @agent

    @agent = Mechanize.new
    @agent.verify_mode = OpenSSL::SSL::VERIFY_NONE
    @agent
  end
end
