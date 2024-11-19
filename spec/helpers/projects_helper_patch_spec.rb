require "spec_helper"

describe ProjectsHelper, :type => :controller do

  render_views

  fixtures :users, :roles, :projects, :members,
           :member_roles, :enabled_modules, :issues

  before do
    @controller = ProjectsController.new
    User.current = nil
    @request.session[:user_id] = 1 # admin
  end

  it "should display project_settings_tabs_with_autocomplete_subject IF module is enabled" do
    Project.find(1).enable_module!("autocomplete_subject")
    get :settings, params: { :id => 1 }
    assert_select "a[href='/projects/1/settings/autocomplete_subject']"
  end

  it "should NOT display project_settings_tabs_with_autocomplete_subject IF module is disabled" do
    Project.find(1).disable_module!("autocomplete_subject")
    get :settings, params: { :id => 1 }
    assert_select "a[href='/projects/1/settings/autocomplete_subject']", false
  end

  it "should NOT display project_settings_tabs_with_autocomplete_subject IF module is enabled and user does not have the permission" do
    @request.session[:user_id] = 3
    User.current = User.find(3)
    Project.find(1).enable_module!("autocomplete_subject")
    get :settings, params: { :id => 1 }
    assert_select "a[href='/projects/1/settings/autocomplete_subject']", false
  end

  it "should display project_settings_tabs_with_autocomplete_subject IF module is enabled and user have the permission" do
    Project.find(1).enable_module!("autocomplete_subject")
    get :settings, params: { :id => 1 }
    assert_select "a[href='/projects/1/settings/autocomplete_subject']"
  end
end
