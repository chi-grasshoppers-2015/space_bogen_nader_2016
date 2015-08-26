require 'rails_helper'

feature "Signing up/in" do

  scenario "when a user visits the page, they can sign up or sign in" do
    visit '/'
    expect(page).to have_content("Sign in")
    expect(page).to have_content("Sign up")
  end

  scenario "clicking Sign up displays a form to create an account" do
    visit '/'
    click_link('Sign up')
    expect(page).to have_content('Name')
    expect(page).to have_content('Email')
    expect(page).to have_content('Password')
  end

  scenario "when a user visits the sign up page, they can sign up" do
    visit '/users/new'
    fill_in('user[name]', with: 'Jenny')
    fill_in('user[password]', with: '1234')
    fill_in('user[email]', with: 'jenny@dbc.edu')
    click_button('Sign up')
    expect(page).to have_content('Welcome, Jenny!')
  end

  scenario "when a user visits the log in page, they can log in" do
    visit '/sessions/new'
    User.create!(name: "Jim", email: "jim@dbc.edu", password: "1234")
    fill_in('user[email]', with: "jim@dbc.edu")
    fill_in('user[password]', with: "1234")
    click_button('Sign in')
    expect(page).to have_content('Welcome, Jim!')
  end

end

feature "Viewing experiments" do

  before(:each) do
    @lab = Lab.create!(name: "TestLab", location: "Hell", allotted_time: 100)
    @faculty = User.create!(name: "Tina",
                           email: "tina@dbc.edu",
                           password: "1234",
                           position: "faculty")
    @experiment = @faculty.experiments.create!(title: "test-title",
                                            description: "test-description",
                                            hypothesis: "test-hypothesis",
                                            start_date: DateTime.now,
                                            end_date: DateTime.now,
                                            lab_id: @lab.id,
                                            allotted_time: 20)
    visit '/sessions/new'
    fill_in('user[email]', with: "tina@dbc.edu")
    fill_in('user[password]', with: "1234")
    click_button('Sign in')
  end

  scenario "when a user logs in they can see their experiments" do
    expect(page).to have_content('test-title')
  end

  scenario "a user can click on an experiment from their profile page" do
    visit "/users/#{@faculty.id}"
    click_link(@experiment.title)
    expected_content = "Details for Experiment: " + @experiment.title
    expect(page).to have_content(expected_content)
  end

  scenario "a user can see all details of an experiment from the page" do
    visit "/experiments/#{@experiment.id}"
    expect(page).to have_content(@faculty.name)
    expect(page).to have_content(@experiment.description)
    expect(page).to have_content(@experiment.hypothesis)
    expect(page).to have_content(@experiment.start_date)
    expect(page).to have_content(@experiment.end_date)
    expect(page).to have_content(@experiment.allotted_time)
    expect(page).to have_content(@experiment.hours_left)
    expect(page).to have_content(@lab.name)
  end

end
