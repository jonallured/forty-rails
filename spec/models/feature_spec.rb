require 'rails_helper'

describe 'Feature' do
  describe '.enabled?' do
    context 'with an unknown flag' do
      it 'raises an error' do
        expect do
          Feature.enabled?(:invalid)
        end.to raise_error(Feature::UnknownFeatureFlag)
      end
    end

    context 'with a known flag' do
      before do
        expect(ENV).to receive(:[]).with('FEATURE_SANITY').and_return(flag_value)
      end

      context 'with a flag not found in ENV' do
        let(:flag_value) { nil }

        it 'returns false' do
          enabled = Feature.enabled?(:sanity)
          expect(enabled).to eq false
        end
      end

      context 'with a flag set as disabled in ENV' do
        let(:flag_value) { 'disabled' }

        it 'returns false' do
          enabled = Feature.enabled?(:sanity)
          expect(enabled).to eq false
        end
      end

      context 'with a flag set as enabled in ENV' do
        let(:flag_value) { 'enabled' }

        it 'returns true' do
          enabled = Feature.enabled?(:sanity)
          expect(enabled).to eq true
        end
      end
    end
  end
end
