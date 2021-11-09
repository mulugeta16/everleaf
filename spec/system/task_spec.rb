equire 'rails_helper'
RSpec.describe 'Task management function', type: :system do
  before do
    FactoryBot.create(:user, name: 'mulu',
                             email: 'mulugeta2030@gmail.com',
                             password: 'password',
                             password_confirmation: 'password')
    visit new_session_path
    fill_in 'Email', with: 'mulugeta2030@gmail.com'
    fill_in 'Password', with: 'password'
    click_button 'Login'
    @user = User.first
    FactoryBot.create(:task, Task Name: "task1", Descroption: "description1", Deadline: "2021/11/24", Status:"Complete", Priority: "Low", user_id: @user.id)
    FactoryBot.create(:task, Task Name: "task2", Descroption: "description2", Deadline: "2021/11/24", Status:"Complete", Priority: "Low", user_id: @user.id)
    FactoryBot.create(:task, Task Name: "task3", Descroption: "description3", Deadline: "2021/11/24", Status:"Complete", Priority: "Low", user_id: @user.id)
  end

  describe 'New creation function' do
    context 'When creating a new task' do
      it 'Should display created task' do
        visit new_task_path
        fill_in 'Task Name', with: 'Task1'
        fill_in 'Description', with: 'description1'
        fill_in 'Deadline', with: '002021-11-24'
        select 'Complete'
        select 'High'
        click_button 'Register'
        expect(page).to have_content 'Task was successfully created.'
      end
    end
  end

  describe 'List display function' do
    context 'When transitioning to the list screen' do
      it 'The created task list is displayed' do
      end
    end
    context 'When tasks are arranged in descending order of creation date and time' do
      it 'New task is displayed at the top' do
        assert Task.all.order(created_at: :desc)
      end
    end
  end
  describe 'Search function' do
    context 'When you search by title' do
      it "Filter by tasks that include search keywords" do
        visit tasks_path
        fill_in 'Task Name', with: 'task1'
        click_on 'search'
        assert Task.ransack(title:[:q])
      end
    end
    context 'When you search by status' do
      it "Tasks that exactly match the status are narrowed down" do
          visit tasks_path
          select 'Complete'
          click_on 'search'
          expect(page).to have_content 'Complete'
          assert Task.ransack(title:[:q])
      end
    end
    context 'When you search by title and status' do
      it "Tasks that include the search keyword in the title and exactly match the status are narrowed down" do
          visit tasks_path
          fill_in 'Task Name', with: 'task1'
          select 'Complete'
          click_on 'search'
          expect(page).to have_content 'task1'
          expect(page).to have_content 'Complete'
      end
    end
  end
end
