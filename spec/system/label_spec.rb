require 'rails_helper'
RSpec.describe 'Label function', type: :system do
  before do
  User.create(name: 'mulu',
                             email: 'mulugeta2030@gmail.com',
                             password: 'password',
                             password_confirmation: 'password')
    visit new_session_path
    fill_in 'email', with: 'mulugeta2030@gmail.com'
    fill_in 'password', with: 'password'
    click_button 'Login'
    @user = User.first
    Label.create(name: "Work")
    Label.create(name: "School")
    Label.create(name: "Social")
  end

  describe 'New creation function' do
    context 'When creating a new label' do
      it 'Should display created Label' do
        visit new_label_path
        fill_in 'Name', with: 'Work'
        click_button 'Create Label'
        expect(page).to have_content 'successfully created.'
      end
    end
  end

  describe 'Adding multiple labels to tasks function' do
    context 'When you add labels to task' do
      it 'The creates task with label' do
        Label.create(name: 'Work')
        Label.create(name: 'Social')
        visit new_task_path
        fill_in 'Task Name', with: 'task1'
        fill_in 'Description', with: 'description1'
        fill_in 'Deadline', with: '002021-11-24'
        select 'Complete'
        select 'High'
        select 'Work'
        select 'Social'
        click_button 'Register'
        expect(page).to have_content 'The task was successfully created'
      end
    end
  end

  describe 'Search function' do
    context 'When you search by label' do
      it "Filter by tasks that include label selected" do
        label = Label.create(name: 'Work')
        task = Task.create(name: "task1", description: "description1", deadline: "2021/11/24", status:"Complete", priority: "low", user_id: @user.id)
        labelling = Labelling.create(label_id: label.id)
        visit tasks_path
                click_on 'search'
        expect(page).to have_content 'Work'
              end
    end
  end
end
