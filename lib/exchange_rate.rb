class ExchangeRate
  include Mongoid::Document
  field :date, type: Date
  field :rate, type: Integer

  def self.import!
    rates = ExchangeRatesFetcher.new.fetch_rates
    hash_rates = rates.each_with_object({}) {|rate, obj| obj[rate[:date]] = rate[:rate] }

    existing_rates = self.in(date: hash_rates.keys)
    existing_rates.each {|rate| rate.update_attribute(:rate, hash_rates[rate.date])}

    new_dates = hash_rates.keys - existing_rates.map(&:date)
    new_rates = rates.select {|rate| rate[:date].in? new_dates }
    new_rates.each {|rate| self.create(rate) }
  end
end
