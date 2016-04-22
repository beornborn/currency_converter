class ExchangeRatesFetcher
  URL = 'http://sdw.ecb.europa.eu/export.do?type=&trans=N&node=2018794&CURRENCY=USD&FREQ=D&start=01-01-2012&q=&submitOptions.y=6&submitOptions.x=51&sfl1=4&end=&SERIES_KEY=120.EXR.D.USD.EUR.SP00.A&sfl3=4&DATASET=0&exportType=csv'

  def fetch_rates
    raw_string = RestClient.get URL
    raw_data = raw_string.split(/\r?\n/)[5..-1]
    raw_data.map do |row|
      row = row.split(',')
      rate = (row[1].to_f * 10_000).to_i
      { date: Date.parse(row[0]), rate: rate }
    end
  end
end
