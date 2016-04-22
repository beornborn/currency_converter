require 'bigdecimal'

class ExchangeConverter
  def self.convert(usd, date_string)
    date = Date.parse(date_string)
    raise RateNotFound if date > Date.today
    rate = ExchangeRate.where(:date.lte => date).order_by(date: :desc).first
    raise RateNotFound unless rate

    total_value = BigDecimal(rate.rate.to_s) * BigDecimal(usd.to_s)
    (total_value / 10_000).to_f
  end

  class RateNotFound < StandardError; end
end
