require 'spec_helper'

describe "Authentication" do

	describe "signin" do
		before { visit signin_path }

		describe "with invalid information" do
			before { click_button "Sign in" }

			it { should have_title ('Sign in') }
			it { should have_selector('div.alert.bg-danger') }
		end


		describe "with valid information" do
			let(:user) 
		end
	end
end
