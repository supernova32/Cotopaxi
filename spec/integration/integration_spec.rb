require 'spec_helper'

feature "Projects & their features" do
  background do
    project = Project.new
    project.name = "Test Name"
    project.description = "Test description"
    project.save!
    feature = Feature.new
    feature.name = "test feature"
    feature.description = "something"
    feature.project = project
    feature.difficulty = 3
    feature.save!
  end

  scenario "GET /projects" do
    visit '/projects'
    page.should have_content "Test Name"
  end

  scenario "GET /projects/new" do
    visit '/projects/new'
    fill_in "Name", with: "Second Project"
    fill_in "Description", with: "Description for this project"
    click_button "Create Project"
    page.should have_content 'Project was successfully created.'
    page.should have_content 'Second Project'
  end

  scenario "GET /projects/1 and add a feature" do
    visit '/projects/1'
    click_link "New Feature"
    fill_in "Name", with: "New feature"
    fill_in "Description", with: "Description of feature."
    click_button "Create Feature"
    page.should have_content 'Feature was successfully created.'
    page.should have_content 'New feature'
  end

  scenario "GET /projects/1 and delete a feature" do
    visit '/projects/1'
    click_link "Delete"
    page.should have_content 'Feature was successfully deleted.'
  end

  scenario "GET /projects and delete a project" do
    visit '/projects'
    click_link 'Delete'
    page.should have_content 'Project was successfully deleted.'
  end

  scenario "GET /projects/1 and cycle the state machine" do
    visit '/projects/1'
    click_link 'Start!'
    page.should have_content 'Project was successfully updated.'
    page.should have_content 'In progress'
    click_link 'Complete!'
    page.should have_content 'Edit Project: Test Name'
  end

  scenario "GET /projects/1/features and cycle the state machine" do
    visit '/projects/1/features'
    click_link 'Start!'
    page.should have_content 'Feature was successfully updated.'
    page.should have_content 'Started'
    visit '/projects/1/features'
    click_link 'Assign!'
    page.should have_content 'Feature was successfully updated.'
    page.should have_content 'In progress'
    visit '/projects/1/features'
    click_link 'Complete!'
    page.should have_content 'Feature was successfully updated.'
    page.should have_content 'Done'
  end

  scenario "GET /projects/1 and update it" do
    visit '/projects/1'
    click_link 'Edit Project'
    fill_in "Description", with: "Updated description!"
    click_button 'Update Project'
    page.should have_content 'Project was successfully updated.'
    page.should have_content 'Updated description!'
  end

  scenario "GET /projects/1/features/1 and update it" do
    visit '/projects/1/features/1'
    click_link 'Edit'
    fill_in "Description", with: "Updated description!"
    click_button 'Update Feature'
    page.should have_content 'Feature was successfully updated.'
    page.should have_content 'Updated description!'
  end
end