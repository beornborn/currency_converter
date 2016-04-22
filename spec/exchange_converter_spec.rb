require_relative 'spec_helper'

describe ExchangeConverter do
  describe '.convert' do
    let!(:existing_record1) { ExchangeRate.create({ date: Date.parse('2016-04-21'), rate: 11111 }) }
    let!(:existing_record2) { ExchangeRate.create({ date: Date.parse('2016-04-18'), rate: 22222 }) }
    subject(:convert) { described_class.method :convert }

    context 'record exists' do
      it { expect(convert.call(120, '2016-04-21')).to eq 133.332 }
    end

    context 'record exists' do
      it { expect(convert.call(120, '2016-04-19')).to eq 266.664 }
    end

    context 'amount with coins' do
      it { expect(convert.call(111.1111, '2016-04-21')).to eq 123.45554321 }
    end

    context 'rate is absent' do
      it { expect{ convert.call(111.1111, '2016-04-23') }.to raise_exception ExchangeConverter::RateNotFound }
      it { expect{ convert.call(111.1111, '1000-04-23') }.to raise_exception ExchangeConverter::RateNotFound }
    end
  end
end
