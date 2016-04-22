require_relative 'spec_helper'

describe ExchangeRate do
  describe '.import!' do
    let(:fetched_records) do
      [
        { date: Date.today, rate: 11111 },
        { date: Date.today + 1.day, rate: 22222 },
        { date: Date.today + 2.days, rate: 33333 }
      ]
    end

    before do
      allow_any_instance_of(ExchangeRatesFetcher).to receive(:fetch_rates).and_return(fetched_records)
    end

    subject(:import) { described_class.import! }

    context 'regular storing' do
      it 'stores imported records' do
        import
        expect(described_class.count).to eq 3
        expect(described_class.first.date).to be_a Date
        expect(described_class.first.rate).to be_an Integer
      end
    end

    context 'regular storing' do
      let!(:existing_record) { described_class.create({ date: Date.today, rate: 55555 }) }

      it 'updates existing records' do
        import
        expect(described_class.count).to eq 3
        updated_record = described_class.where(date: Date.today).first
        expect(updated_record.rate).to eq 11111
      end
    end

    context 'regular storing' do
      let!(:existing_record1) { described_class.create({ date: Date.today, rate: 11111 }) }
      let!(:existing_record2) { described_class.create({ date: Date.today + 3.days, rate: 77777 }) }

      it 'doesnt duplicate existing records and adds only new' do
        import
        expect(described_class.count).to eq 4
        updated_record = described_class.where(date: Date.today).first
      end
    end
  end
end
