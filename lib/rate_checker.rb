Dir[File.expand_path('../rate_checker', __FILE__) << '/*.rb'].each do |file|
  require file
end

module RateChecker
  def self.currencies
    %w(usd eur gbp cad chf cnh eur_usd)
  end
end
