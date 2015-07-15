require 'rate_checker'

namespace :all do
  task check: :environment do
    RateChecker.currencies.each do |currency|
      "rate_checker/#{currency}".camelize.constantize.new.execute
    end
  end
end
