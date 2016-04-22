require_relative '../app'
Mongoid.load!(File.expand_path('mongodb.yml'), :test)

RSpec.configure do |config|
  config.after(:each) do
    ExchangeRate.delete_all
  end
end
