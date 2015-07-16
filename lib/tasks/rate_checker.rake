namespace :all do
  task check: :environment do
    CurrencyPair.all.each do |currency_pair|
      currency_pair.fetch_rate
    end
  end
end
