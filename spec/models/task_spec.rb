require 'rails_helper'
RSpec.describe Task, type: :model do
describe 'Validation test' do
  context 'If the task name is empty' do
    it 'The task cannot be validated' do
      task = Task.new(name: '', description: 'Failure test')
      expect(task).not_to be_valid
    end
  end
  context 'If the task details are empty' do
    it 'The task cannot be validated' do
      task = Task.new(name: 'Task', description: '')
      expect(task).not_to be_valid
    end
  end
  context 'If the task Title and details are described' do
        it 'Validation passes' do
          task = Task.new(name: 'Task', description: 'Test success')
          expect(task).to be_valid
        end
      end
end
end
