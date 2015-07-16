# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

[
 ['USD', 'JPY'],
 ['EUR', 'JPY'],
 ['GBP', 'JPY'],
 ['CAD', 'JPY'],
 ['CHF', 'JPY'],
 ['CNH', 'JPY'],
 ['EUR', 'USD']
].each { |base, quote| CurrencyPair.create(base: base, quote: quote) }
