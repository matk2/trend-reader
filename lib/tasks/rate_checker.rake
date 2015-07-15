require 'rate_checker'
Dir[File.expand_path('../../rate_checker', __FILE__) << '/*.rb'].each do |file|
  require file
end

namespace :all do
  task check: :environment do
    RateChecker.currencies.each do |currency|
      "rate_checker/#{currency}".camelize.constantize.new.execute
    end
  end
end
