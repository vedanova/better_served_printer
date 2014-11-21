require 'spec_helper'

module BetterServedPrinter
  describe Configuration do

    it 'should set default values' do
      expect(subject.log_level).to eq(0)
    end

    it 'can set the log_level' do
      subject.log_level = Logger::INFO
      expect(subject.log_level).to eq(1)
    end

    it '#set' do
      subject.set(:log_level, Logger::INFO)
      expect(subject.log_level).to eq(1)
    end


  end
end