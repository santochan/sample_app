require 'spec_helper'

describe "Authentication" do
  subject { page }
  
  describe "sigin page" do
    before { visit signin_path}
    
    it { should have_selector('h1', text: 'Sign in')}
    it { should have_selector('title', text: 'Sign in')}
    
    describe "with invalid information" do
      before { click_button "Sign in"}
      
      it { should have_selector('title',text:'Sign in')}
      it { should have_selector('div.alert.alert-error',text:'Invalid')}
      
      describe "after visit another page" do
        before { click_link "Home"}
        
        it { should_not have_selector('div.alert.alert-error')}
      end
    end
    
    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before {sign_in user}
      
      it { should have_selector('title',text:user.name)}
      it { should have_link('Users',herf: users_path)}
      it { should have_link('Profile',href: user_path(user))}
      it { should have_link('Sign out', href: signout_path)}
      it { should_not have_link('Sign in',href: signin_path)}
      it { should have_link('Setting',href:edit_user_path(user))}
      
      describe "followed by sign out" do 
        before { click_link "Sign out"}
        it { should have_link('Sign in',href:signin_path)}
      end
      
      
    end
    
  end
  
  describe "for non-sign user" do
    let(:user) {FactoryGirl.create(:user)}
    
      describe "in the user controller" do
      
      describe "visit the edit page" do
        before { visit edit_user_path(user)}
        it { should have_selector('title',text:"Sign in")}
      end
      
      describe "submitting to the update action" do
        before { put user_path(user)}
        specify { response.should redirect_to(signin_path) }
      end
      
      describe "visiting the user index" do
        before { visit users_path }
        it { should have_selector('title',text:'Sign in')}
      end
    end
    
    
  end
  
  describe "as  wrong user" do
    let(:user) { FactoryGirl.create(:user)}
    let(:wrong_user) {FactoryGirl.create(:user,email:"wrong@example.com")}
    before { sign_in user}
    
    describe "visit Users#edit page" do
      before { visit edit_user_path(wrong_user)}
      it { should have_selector('title',text: full_title(''))}
    end
    
    describe "submitting a PUT Request to the Users#update action" do
      before { put user_path(wrong_user)}
      specify { response.should redirect_to(root_path)}
    end
    
  end
  
  describe "for non-signed-in users" do
    let(:user) { FactoryGirl.create(:user)}
    
    describe "when attemping to visit a protected page" do
      before do
        visit edit_user_path(user)
        fill_in "Email",        with:user.email
        fill_in "Password",     with:user.password
        click_button "Sign in"
      end
      it "should render the desired protected page" do
         page.should have_selector('title',text:"Edit user")
      end
    end
    
  end

  describe "for non_admin users" do
    let(:user) { FactoryGirl.create(:user)}
    let(:non_admin) {FactoryGirl.create(:user)}
    
    before {sign_in non_admin}
    
    describe "submitting a DELETE request to the Users#destroy action " do
      before { delete user_path(user)}
      specify { response.should redirect_to root_path}
    end
    
  end
end
