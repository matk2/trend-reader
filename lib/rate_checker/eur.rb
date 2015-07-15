module RateChecker
  class Eur < Base

    private

    def converter_from
      'EUR'
    end

    def converter_to
      'JPY'
    end
  end
end
