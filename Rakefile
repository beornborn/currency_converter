desc "load all application files"
task :environment do
  load 'app.rb'
end

namespace :rates do
  desc "Sync exchange rates with the external source"
  task :sync => :environment do
    count_before = ExchangeRate.count
    puts "rates amount before sync: #{count_before}"
    ExchangeRate.import!
    count_after = ExchangeRate.count
    puts "rates amount after sync: #{count_after}"
    puts "added #{count_after - count_before} new records"
  end
end

desc "Convert USD to EUR. example: rake convert[120,2016-04-20]"
task :convert, [:usd, :date] => [:environment] do |t, args|
  begin
    eur = ExchangeConverter.convert(args[:usd].to_i, args[:date])
    puts "You can convert #{args[:usd]}$ to #{eur} euro on #{args[:date]}"
  rescue ExchangeConverter::RateNotFound => e
    puts "There is no currency exchange rate presented for #{args[:date]}. Try another date."
  end
end
