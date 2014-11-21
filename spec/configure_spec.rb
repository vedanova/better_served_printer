require 'spec_helper'

describe BetterServedPrinter do

  describe '#configure' do

    context 'hash configuration' do

      before :each do
        BetterServedPrinter.configure api_key: 'API_KEY', account: '1111-2222-3333'
      end

      it 'sets the default key' do
        printer = BetterServedPrinter::Printer.new
        expect(printer.config.log_level).to eq 0
      end

      it 'sets the API key' do
        printer = BetterServedPrinter::Printer.new
        expect(printer.config.api_key).to eq 'API_KEY'
      end
    end

    context 'from file' do
      let(:path) { File.join(File.dirname(__FILE__), 'fixtures/config.yml') }

      before :each do
        BetterServedPrinter.configure path
      end

      it 'sets the API key' do
        printer = BetterServedPrinter::Printer.new
        expect(printer.config.api_key).to eq 'API_KEY'
        expect(printer.config.account).to eq '1111-2222-3333'
      end
    end

  end
end