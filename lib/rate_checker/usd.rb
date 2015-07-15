module RateChecker
  class Usd < Base

    private

    def converter_from
      'USD'
    end

    def converter_to
      'JPY'
    end
  end
end
