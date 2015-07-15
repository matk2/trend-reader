module RateChecker
  class Base
    def initialize
      @agent = Mechanize.new
    end

    def execute
      value = get_rate_value
      save(value)
    end

    private

    def agent
      @agent
    end

    def get_rate_value
      page = agent.get("https://www.google.com/finance/converter?a=1&from=#{converter_from}&to=#{converter_to}")
      page.search("span[@class='bld']").text.split[0]
    end

    def save(value)
      Rate.create(currency_pair: currency_pair, value: value)
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
  end
end
