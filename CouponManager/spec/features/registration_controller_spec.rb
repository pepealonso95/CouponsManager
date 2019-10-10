require 'rails_helper'

RSpec.describe 'Register users', type: :feature do

    before(:all) do
        # @organization = create(:organization)
        # @adminUser = create(:user, organization_id: @organization.id, role: 0)
    end

        
# Tests for sign up from page
it 'Sign up successfully' do
    visit('users/sign_up')
    expect(page).to have_content('Sign up')
    fill_in 'Email', :with => "seba@gmail.com"
    fill_in 'Password', :with => "123456"
    fill_in 'password_confirmation', :with => "123456"
    fill_in 'Name', :with => "Sebastian"
    fill_in 'Lastname', :with => "Rodriguez"
    fill_in 'Organization_id', :with => "Organizacion"
    click_button 'Sign up'
    expect(current_path).to eql('/')
    expect(page).to have_content('Logged in')
end


it 'Sign up no email' do
    visit('users/sign_up')
    expect(page).to have_content('Sign up')
    fill_in 'user_email', :with => ""
    fill_in 'user_password', :with => "123456"
    fill_in 'user_password_confirmation', :with => "123456"
    fill_in 'user_name', :with => "Sebastian"
    fill_in 'user_surname', :with => "Rodriguez"
    fill_in 'user_organization_id', :with => "Organizacion"
    click_button 'Sign up'
    expect(page).to have_content('error')
    expect(current_path).to eql('/users')
end


it 'Sign up no password' do
    visit('users/sign_up')
    expect(page).to have_content('Sign up')
    fill_in 'user_email', :with => "seba@gmail.com"
    fill_in 'user_password', :with => ""
    fill_in 'user_password_confirmation', :with => "123456"
    fill_in 'user_name', :with => "Sebastian"
    fill_in 'user_surname', :with => "Rodriguez"
    fill_in 'user_organization_id', :with => "Organizacion"
    click_button 'Sign up'
    expect(page).to have_content('error')
    expect(current_path).to eql('/users')
end


it 'Sign up invalid password' do
    visit('users/sign_up')
    expect(page).to have_content('Sign up')
    fill_in 'user_email', :with => "seba@gmail.com"
    fill_in 'user_password', :with => "123"
    fill_in 'user_password_confirmation', :with => "123"
    fill_in 'user_name', :with => "Sebastian"
    fill_in 'user_surname', :with => "Rodriguez"
    fill_in 'user_organization_id', :with => "Organizacion"
    click_button 'Sign up'
    expect(page).to have_content('error')
    expect(current_path).to eql('/users')
end


it 'Sign up no confirmation password' do
    visit('users/sign_up')
    expect(page).to have_content('Sign up')
    fill_in 'user_email', :with => "seba@gmail.com"
    fill_in 'user_password', :with => "123456"
    fill_in 'user_password_confirmation', :with => ""
    fill_in 'user_name', :with => "Sebastian"
    fill_in 'user_surname', :with => "Rodriguez"
    fill_in 'user_organization_id', :with => "Organizacion"
    click_button 'Sign up'
    expect(page).to have_content('error')
    expect(current_path).to eql('/users')
end


it 'Sign up passwords dont match' do
    visit('users/sign_up')
    expect(page).to have_content('Sign up')
    fill_in 'user_email', :with => "seba@gmail.com"
    fill_in 'user_password', :with => "123456"
    fill_in 'user_password_confirmation', :with => "123"
    fill_in 'user_name', :with => "Sebastian"
    fill_in 'user_surname', :with => "Rodriguez"
    fill_in 'user_organization_id', :with => "Organizacion"
    click_button 'Sign up'
    expect(page).to have_content('error')
    expect(current_path).to eql('/users')
end

it 'Sign up no name' do
    visit('users/sign_up')
    expect(page).to have_content('Sign up')
    fill_in 'user_email', :with => "seba@gmail.com"
    fill_in 'user_password', :with => "123456"
    fill_in 'user_password_confirmation', :with => "123456"
    fill_in 'user_name', :with => ""
    fill_in 'user_surname', :with => "Rodriguez"
    fill_in 'user_organization_id', :with => "Organizacion"
    click_button 'Sign up'
    expect(page).to have_content('error')
    expect(current_path).to eql('/users')
end

it 'Sign up no surname' do
    visit('users/sign_up')
    expect(page).to have_content('Sign up')
    fill_in 'user_email', :with => "seba@gmail.com"
    fill_in 'user_password', :with => "123456"
    fill_in 'user_password_confirmation', :with => "123456"
    fill_in 'user_name', :with => "Sebastian"
    fill_in 'user_surname', :with => ""
    fill_in 'user_organization_id', :with => "Organizacion"
    click_button 'Sign up'
    expect(page).to have_content('error')
    expect(current_path).to eql('/users')
end

it 'Sign up no organization' do
    visit('users/sign_up')
    expect(page).to have_content('Sign up')
    fill_in 'user_email', :with => "seba@gmail.com"
    fill_in 'user_password', :with => "123456"
    fill_in 'user_password_confirmation', :with => "123456"
    fill_in 'user_name', :with => "Sebastian"
    fill_in 'user_surname', :with => "Rodriguez"
    fill_in 'user_organization_id', :with => ""
    click_button 'Sign up'
    expect(page).to have_content('error')
    expect(current_path).to eql('/users')
end


# Tests for sign up via link     

it 'create non admin user successfully' do
    #Log in admin user
    visit('/')
    expect(page).to have_content('Log in')
    fill_in 'user_email', :with => @adminUser.email
    fill_in 'user_password', :with => @adminUser.password
    click_button 'Log in'
    expect(current_path).to eql('/')
    
    #Send sign up invitation link
    fill_in 'email', :with => "nico@gmail.com"
    click_button 'Create User'
    expect(current_path).to eql('/')
    expect(page).to have_content('Successfully')
   
end


it 'create non admin user unsuccessfully, email already used' do
    nonAdminUser = create(:user, email: "test@email.com", organization_id: @organization.id)

    #Log in admin user
    visit('/')
    expect(page).to have_content('Log in')
    fill_in 'user_email', :with => @adminUser.email
    fill_in 'user_password', :with => @adminUser.password
    click_button 'Log in'
    expect(current_path).to eql('/')
    
    #Send sign up invitation link to email from an existing user
    fill_in 'email', :with => nonAdminUser.email
    click_button 'Create User'
    expect(current_path).to eql('/')
    expect(page).to have_content('Error')
end


it 'confirm registration successfully' do
    
    non_admin = User.new(name: "default_name", surname: "default_surname", password: "default_password", email: "nico@gmail.com", organization_id: @organization.id, role:1)
    non_admin.confirmation_token = SecureRandom.urlsafe_base64
    puts non_admin.confirmation_token
    non_admin.save
 
    #Go to confirmation page
    conf_token = non_admin.confirmation_token
    url = "/users/registrations/nonAdmin/#{non_admin.confirmation_token}"
    visit(url)
    
    #Fill in user data
    fill_in 'user_password', :with => "123456"
    fill_in 'user_name', :with => "Test name"
    fill_in 'user_surname', :with => "Test surname"
    click_button 'Complete Register'
    expect(current_path). to eql('/users/sign_in')
    expect(page).to have_content('Log in')
    
end


it 'confirm registration unsuccessfully, no name' do
    
    non_admin = User.new(name: "default_name", surname: "default_surname", password: "default_password", email: "nico@gmail.com", organization_id: @organization.id, role:1)
    non_admin.confirmation_token = SecureRandom.urlsafe_base64
    puts non_admin.confirmation_token
    non_admin.save
 
    #Go to confirmation page
    base_url = "/users/registrations/nonAdmin"
    url = "/users/registrations/nonAdmin/#{non_admin.confirmation_token}"
    visit(url)
    
    #Fill in user data, no name
    fill_in 'user_password', :with => "123456"
    fill_in 'user_name', :with => ""
    fill_in 'user_surname', :with => "Test surname"
    click_button 'Complete Register'
    expect(current_path). to eql(url)
    expect(page).to have_content('All fields must be filled')
    
end


it 'confirm registration unsuccessfully, no password' do
    
    non_admin = User.new(name: "default_name", surname: "default_surname", password: "default_password", email: "nico@gmail.com", organization_id: @organization.id, role: 1)
    non_admin.confirmation_token = SecureRandom.urlsafe_base64
    puts non_admin.confirmation_token
    non_admin.save
 
    #Go to confirmation page
    base_url = "/users/registrations/nonAdmin"
    url = "/users/registrations/nonAdmin/#{non_admin.confirmation_token}"
    visit(url)
    
    #Fill in user data, no password
    fill_in 'user_password', :with => ""
    fill_in 'user_name', :with => "Test name"
    fill_in 'user_surname', :with => "Test surname"
    click_button 'Complete Register'
    expect(current_path). to eql(url)
    expect(page).to have_content('All fields must be filled')
    
end


it 'confirm registration unsuccessfully, no surname' do
    
    non_admin = User.new(name: "default_name", surname: "default_surname", password: "default_password", email: "ethos_uy@outlook.com", organization_id: @organization.id, role: 1)
    non_admin.confirmation_token = SecureRandom.urlsafe_base64
    puts non_admin.confirmation_token
    non_admin.save
 
    #Go to confirmation page
    base_url = "/users/registrations/nonAdmin"
    url = "/users/registrations/nonAdmin/#{non_admin.confirmation_token}"
    visit(url)
    
    #Fill in user data, no surname
    fill_in 'user_password', :with => "123456"
    fill_in 'user_name', :with => "Test name"
    fill_in 'user_surname', :with => ""
    click_button 'Complete Register'
    expect(current_path). to eql(url)
    expect(page).to have_content('All fields must be filled')
    
end

it 'confirm registration unsuccessfully, invalid password' do
    
    non_admin = User.new(name: "default_name", surname: "default_surname", password: "default_password", email: "ethos_uy@outlook.com", organization_id: @organization.id, role: 0)
    non_admin.confirmation_token = SecureRandom.urlsafe_base64
    puts non_admin.confirmation_token
    non_admin.save
 
    #Go to confirmation page
    base_url = "/users/registrations/nonAdmin"
    url = "/users/registrations/nonAdmin/#{non_admin.confirmation_token}"
    visit(url)
    
    #Fill in user data, password too short
    fill_in 'user_password', :with => "123"
    fill_in 'user_name', :with => "Test name"
    fill_in 'user_surname', :with => "Test surname"
    click_button 'Complete Register'
    expect(current_path). to eql(url)
    expect(page).to have_content('All fields must be filled')
    
end








end

