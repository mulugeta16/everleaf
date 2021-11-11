require 'rails_helper'
describe 'Label model function', type: :model do
  context 'Validation test' do
    it 'It ensures Label is present' do
      label = Label.new(name: '').save
      expect(label).to eq(false)
    end
  end
end
