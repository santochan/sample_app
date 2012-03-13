require 'spec_helper'

describe "StaticPages" do
  
  describe "Home Page" do
    it "should have the h1 'Sample App'" do
      visit root_path
      page.should have_selector('h1',:text => 'Sample App')
    end
    
    it "should have the title 'Home'" do
      visit root_path
      page.should have_selector('title',
                  :text  => "Ruby on Rails Tutorial Sample App | Home")
    end
    
  end
  
  describe "Help Page" do
    it "should have the h1 'Help'" do
      visit help_path
      page.should have_selector('h1',:text => 'Help')
    end
    
    it "should have the title 'Help'" do
      visit help_path
      page.should have_selector('title',
                  :text  => "Ruby on Rails Tutorial Sample App | Help")
    end
  end
  
  describe "About page" do
    it "should have the h1 'About us'" do
      visit about_path
      page.should have_selector('h1',:text => 'About us')
    end
    
    it "should have the title 'About us'" do
      visit about_path
      page.should have_selector('title',
                  :text  => "Ruby on Rails Tutorial Sample App | About us")
    end
  end
  
  describe "Contact page" do
    it "should have the h1 'Contact'" do
      visit contact_path
      page.should have_selector('h1', text: "Contact")
    end
    
    it "should have the title 'Contact'"do
      visit contact_path
      page.should have_selector('title',
                  text: "Ruby on Rails Tutorial Sample App | Contact")
    end
    
  end
  
end
