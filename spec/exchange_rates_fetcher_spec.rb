require_relative 'spec_helper'

describe ExchangeRatesFetcher do
  describe '#fetch_rates' do
    let(:raw_string) do
      path = File.expand_path(File.join('spec', 'fixtures', 'exchange_rates.csv'))
      File.open(path).read
    end
    before do
      allow(RestClient).to receive(:get).and_return(raw_string)
    end

    subject(:result) { described_class.new.fetch_rates }

    it { expect(result.size).to eq 9 }
    it { expect(result[0][:date]).to be_a Date }
    it { expect(result[0][:rate]).to be_a Fixnum }
  end
end
