require 'rails_helper'
describe 'User test', type: :system do

  describe 'User registration test' do
    context 'when you sign up' do
      it 'registers new users' do
        visit new_user_path
        fill_in "name",         with: "Example User"
        fill_in "email",        with: "user@example.com"
        fill_in "password",     with: "foobar"
        fill_in "password_confirmation", with: "foobar"
        expect{ click_button "Register" }.to change(User, :count).by(1)
      end
    end
    context 'When the user tries to jump to the task list screen without logging in' do
      it 'transition to the login screen' do
        visit tasks_path
        expect(current_path).to eq new_session_path
        expect(current_path).not_to eq tasks_path
      end
    end
  end

  describe 'Session functionality test' do
    before do
      User.create(name: 'user1',
                               email: 'user1@example.com',
                               password: 'password',
                               password_confirmation: 'password')
      visit new_session_path
      fill_in 'email', with: 'user1@example.com'
      fill_in 'password', with: 'password'
      click_button 'Login'
      @user = User.first
    end
    context 'to be able to log in' do
      it 'enables log in' do
        expect(current_path).to eq user_path(id: @user.id)
      end
    end
    context 'to be able to log in' do
      it 'enables login' do
        expect(page).to have_content("New task")
      end
    end
    context 'When a general user jumps to another persons details screen' do
      it 'transition to the task list screen' do
        sue = User.create(name: 'Hi',
                                 email: 'hi@gmail.com',
                                 password: 'password',
                                 password_confirmation: 'password')
        visit user_path(id: sue.id)
        expect(page).to have_content("General Tasks List")
      end
    end
  end
  describe 'Admin screen test' do
    context 'Admin users should be able to access the admin screen' do
      before do
        User.create(name: 'admin',
                          email: 'admin@gmail.com',
                          password: 'password',
                          password_confirmation: 'password',
                          admin:true
                           )
        visit new_session_path
        fill_in 'email', with: 'admin@gmail.com'
        fill_in 'password', with: 'password'
        click_button 'Login'
        @admin_user = User.first
      end
      it 'accesses admin screen' do
        expect(page).to have_content("Users")
      end
    end
    context 'General users' do
      it 'cannot access the management screen' do
        User.create(name: 'user1',
                                 email: 'user1@example.com',
                                 password: 'password',
                                 password_confirmation: 'password'
                               )
        visit new_session_path
        fill_in 'email', with: 'user1@example.com'
        fill_in 'password', with: 'password'
        click_button 'Login'
        @user = User.first
        visit admin_users_path
        expect(page).to have_content("Task")
      end
    end
    context 'Admin users can' do
      it 'register new users' do
        User.create(name: 'admin',
                          email: 'admin@example.com',
                          password: 'password',
                          password_confirmation: 'password',
                          admin:true
                           )
        visit new_session_path
        fill_in 'email', with: 'admin@example.com'
        fill_in 'password', with: 'password'
        click_button 'Login'
      visit new_admin_user_path
        fill_in "name",         with: "Example User"
        fill_in "email",        with: "user1@example.com"
        fill_in "password",     with: "foobar"
        fill_in "password_confirmation", with: "foobar"
        click_button 'Register'
        end
    end
    context 'Admin users should be able to' do
      it ' access the user details screen' do
        User.create(name: 'admin',
                          email: 'admin@example.com',
                          password: 'password',
                          password_confirmation: 'password',
                          admin:true
                           )
        visit new_session_path
        fill_in 'email', with: 'admin@example.com'
        fill_in 'password', with: 'password'
        click_button 'Login'
        @admin_user = User.first
        click_on 'Show'
        expect(page).to have_content("admin@example.com")
      end
    end
    context 'Admin user can' do
      before do
        User.create(name: 'Hi',
                                 email: 'hi@gmail.com',
                                 password: 'password',
                                 password_confirmation: 'password')
        @user = User.first
      end
      it 'Edit the user from the user edit screen' do
        User.create(name: 'admin',
                          email: 'admin@example.com',
                          password: 'password',
                          password_confirmation: 'password',
                          admin:true
                           )
        visit new_session_path
        fill_in 'email', with: 'admin@example.com'
        fill_in 'password', with: 'password'
        click_button 'Login'
        @admin_user = User.first
        click_on('Modify', match: :first)

        expect(current_path).to eq edit_admin_user_path(id: @user.id)
      end
    end
    context 'Admin users' do
      before do
        User.create(name: 'Hi',
                                 email: 'hi@gmail.com',
                                 password: 'password',
                                 password_confirmation: 'password')
        @user = User.first
      end
      it 'can delete users' do
      User.create(name: 'admin',
                          email: 'admin@example.com',
                          password: 'password',
                          password_confirmation: 'password',
                          admin:true
                           )
        visit new_session_path
        fill_in 'email', with: 'admin@example.com'
        fill_in 'password', with: 'password'
        click_button 'Login'
        @admin_user = User.first
        click_on('Delete', match: :first)
              expect(page).to have_content('Users list')
      end
    end
  end
end
