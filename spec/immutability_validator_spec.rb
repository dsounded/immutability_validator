require 'spec_helper'

xdescribe ImmutabilityValidator do
  let(:immutableNameClass) do
    Class.new(TestModel) do
      validates :name, immutability: true
    end
  end

  let(:immutableNameClassWithMessage) do
    Class.new(TestModel) do
      validates :name, immutability: { message: 'dont change!' }
    end
  end

  describe 'immutability: true' do
    let(:object) { immutableNameClass.new(name: 'old_name') }

    context 'already persisted' do
      before do
        allow(object).to receive(:new_record?).and_return false
        allow(I18n).to receive(:t).with('.activerecord.errors.base.immutability').and_return 'cannot be changed'
      end

      it 'does not allow to change the name' do
        object.name = 'new_name'

        expect(object).to be_invalid
        expect(object.errors[:name]).to include 'cannot be changed'
      end

      context 'with custom message' do
        let(:object) { immutableNameClassWithMessage.new(name: 'old_name') }

        it 'does not allow to change the name' do
          object.name = 'new_name'

          expect(object).to be_invalid
          expect(object.errors[:name]).to include 'dont change!'
        end
      end

      context 'same new_name' do
        it 'allows to change the name' do
          object.name = 'old_name'

          expect(object).to be_valid
        end
      end
    end

    context 'not persisted' do
      before { allow(object).to receive(:new_record?).and_return true }

      it 'allows to change the name' do
        object.name = 'new_name'

        expect(object).to be_valid
      end
    end
  end

  describe 'validates_immutability_of' do
    let(:immutableNameClassViaShorthand) do
      Class.new(TestModel) do
        validates_immutability_of :name
      end
    end

    describe 'immutability: true' do
      let(:object) { immutableNameClassViaShorthand.new(name: 'old_name') }

      context 'already persisted' do
        before do
          allow(object).to receive(:new_record?).and_return false
          allow(I18n).to receive(:t).with('.activerecord.errors.base.immutability').and_return 'cannot be changed'
        end

        it 'does not allow to change the name(works with shorthand)' do
          object.name = 'new_name'

          expect(object).to be_invalid
          expect(object.errors[:name]).to include 'cannot be changed'
        end
      end
    end
  end
end
