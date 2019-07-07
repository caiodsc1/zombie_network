require 'faker'
require 'rails_helper'
require 'helpers/trades_service_helper'

RSpec.describe TradesService do

  before do
    @resources_one = TradesServiceHelper.generate_resources
    @resources_two = TradesServiceHelper.get_equivalent_resources(@resources_one)
    @not_equivalent_resources = TradesServiceHelper.generate_invalid_resources(@resources_one)
  end

  describe 'Perform' do
    context 'Resources are equivalent' do
      context 'Survivors are not infected and have enough resources' do
        it 'Will trade' do
          survivor_one = FactoryBot.create(:not_infected_survivor_with_resources)
          survivor_two = FactoryBot.create(:not_infected_survivor_with_resources)
          trade = TradesService.new(survivor_one, survivor_two, @resources_one, @resources_two)
          puts trade.response
          expect(trade.perform).to be true
        end
      end
      context 'Survivors are not infected and have not enough resources' do
        it 'Will trade' do
          survivor_one = FactoryBot.create(:not_infected_survivor_without_resources)
          survivor_two = FactoryBot.create(:not_infected_survivor_without_resources)
          trade = TradesService.new(survivor_one, survivor_two, @resources_one, @resources_two)
          expect(trade.perform).to be false
        end
      end
      context 'Survivors are infected and have enough resources' do
        it 'Will not trade' do
          survivor_one = FactoryBot.create(:infected_survivor_with_resources)
          survivor_two = FactoryBot.create(:infected_survivor_with_resources)
          trade = TradesService.new(survivor_one, survivor_two, @resources_one, @resources_two)
          expect(trade.perform).to be false
        end
      end
      context 'Survivors are infected and have not enough resources' do
        it 'Will not trade' do
          survivor_one = FactoryBot.create(:infected_survivor_without_resources)
          survivor_two = FactoryBot.create(:infected_survivor_without_resources)
          trade = TradesService.new(survivor_one, survivor_two, @resources_one, @resources_two)
          expect(trade.perform).to be false
        end
      end
    end
    context 'Resources are not equivalent' do
      it 'Will not trade' do
        survivor_one = FactoryBot.create(:general_survivor)
        survivor_two = FactoryBot.create(:general_survivor)
        trade = TradesService.new(survivor_one, survivor_two, @resources_one, @not_equivalent_resources)
        expect(trade.perform).to be false
      end
    end
  end
end
