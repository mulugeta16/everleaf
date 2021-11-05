require 'rails_helper'
RSpec.describe 'Task management function', type: :system do
  before do
    FactoryBot.create(:user, name: 'sample',
                             email: 'sample@example.com',
                             password: 'password',
                             password_confirmation: 'password')
    visit new_session_path
    fill_in 'email', with: 'sample@example.com'
    fill_in 'password', with: 'password'
    click_button 'Login'
    @user = User.first
    FactoryBot.create(:task, name: "task1", description: "description1", deadline: "2021/11/10", status:"Completed", priority: "low", user_id: @user.id)
    FactoryBot.create(:task, name: "task2", description: "description2", deadline: "2021/11/11", status:"Completed", priority: "low", user_id: @user.id)
      describe 'New creation function' do
    context 'When creating a new task' do
      it 'Should display created task' do
        visit new_task_path
        fill_in "task_name", with: 'task1'
        fill_in 'task_description', with: 'description1'
        click_button 'Register'
        expect(page).to have_content 'The task was successfully created'
      end
    end
  end
  describe 'List display function' do
    context 'When transitioning to the list screen' do
      it 'The created task list is displayed' do
        task = Task.create(name: 'task1', description: 'description1')
        task = Task.create(name: 'task1', description: 'description1')

                visit tasks_path(task)
                expect(page).to have_content 'task'
        visit tasks_path(task)
        expect(page).to have_content 'task'
      end
    end
  end
 describe 'Detailed display function' do
    context 'When transitioned to any task details screen' do
      it 'The content of the relevant task is displayed' do
         task = Task.create(name: 'task1', description: 'description1')
        visit tasks_path(task)
        expect(page).to have_content 'task'
      end
    end

    context 'When the tasks are arranged in descending order of creation date and time' do
          it 'A new task is displayed at the top' do
            task = Task.create(name: 'task1', description: 'description1')
            visit tasks_path
            assert Task.all.order(created_at: "desc")
      end
    end
  end

  context 'If you do a fuzzy search by name' do
     it "Filter by tasks that include search keywords" do
       visit tasks_path
       search_name = "task1"
       visit tasks_path(name: search_name)
       expect(page).to have_content 'Name'
     end
   end
   context 'When you search for status' do
     it "Tasks that exactly match the status are narrowed down" do
       visit tasks_path
       search_status = "Not started"
       visit tasks_path(status: search_status)
       expect(page).to have_content search_status
     end
   end

    context 'When you search by title and status' do
      it "Tasks that include the search keyword in the title and exactly match the status are narrowed down" do
        search_name = "task2"
        search_status = "Not started"
          visit tasks_path(name: search_name, status: search_status)
          expect(page).to have_content 'Name'
          expect(page).to have_content 'Status'
      end
    end
end
end 
