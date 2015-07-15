module RateChecker
  class EurUsd < Base

    private

    def converter_from
      'EUR'
    end

    def converter_to
      'USD'
    end
  end
end
