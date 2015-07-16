namespace :all_trends do
  task read: :environment do
    CurrencyPair.fetch_rate
    TrendReadService.execute
  end
end
