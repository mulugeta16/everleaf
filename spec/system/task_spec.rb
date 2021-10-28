require 'rails_helper'
RSpec.describe 'Task management function', type: :system do
  describe 'New creation function' do
    context 'When creating a new task' do
      it 'Should display created task' do
        visit new_task_path
        fill_in 'task_name', with: 'task_name1'
        fill_in 'task_description', with: 'description1'
        click_button 'Create Task'
        expect(page).to have_content 'Task was successfully created'
      end
    end
  end
  describe 'Task management function', type: :system do
    describe 'List display function' do
      context 'When transitioning to the list screen' do
        it 'The created task list is displayed' do
        task = Task.create(name: 'task1', description: 'description1')

        visit tasks_path(task)
        expect(page).to have_content 'task'
        end
      end
    end
  end
  describe 'Detailed display function' do
     context 'When transitioned to any task details screen' do
       it 'The content of the relevant task is displayed' do
          task = Task.create(name: 'task_name1', description: 'description1')
         visit tasks_path(task)
         expect(page).to have_content 'task_name1'
       end
     end
  end
end
