require "spec_helper"

describe IssuesController, :type => :controller do
  fixtures :users, :projects, :trackers, :issues, :enabled_modules, :custom_fields, :custom_values

  let(:project) { Project.find(1) }
  let(:tracker) { Tracker.find(1) }
  let(:user) { User.find(2) }

  before do
    @request.session[:user_id] = user.id
    project.enabled_module_names = project.enabled_module_names | ["autocomplete_subject"]
    project.autocomplete_separator = "-"
    project.show_subject_input = 1
    project.autocomplete_subject_tracker_ids = "1"
    project.save!
    AutocompletedField.create!(project_id: project.id, field_object: "Issue", field_name: "issue_author_id", position: 0)
    AutocompletedField.create!(project_id: project.id, field_object: "Issue", field_name: "issue_tracker_id", position: 1)
  end

  it "generates the subject when module is activated and config is set" do
    post :create, :params => {
      :project_id => project.id,
      :issue => {
        :tracker_id => tracker.id,
        :author_id => user.id,
        :description => "Test description"
      }
    }
    issue = Issue.last
    expect(issue.subject).to eq("John Smith-Bug") # [user.name, tracker.name].join("-")
  end

  it "does not change the subject if autocompletion is DISABLED in project's settings" do
    project.update!(show_subject_input: 3) # Disable autocompletion
    post :create, :params => {
      :project_id => project.id,
      :issue => {
        :tracker_id => tracker.id,
        :author_id => user.id,
        :description => "Test description",
        :subject => "Subject added by the user"
      }
    }
    issue = Issue.last
    expect(issue.subject).to eq("Subject added by the user")
  end

  it "does not change the subject if the functionality is disabled for current tracker" do
    project.update!(autocomplete_subject_tracker_ids: "2")
    post :create, :params => {
      :project_id => project.id,
      :issue => {
        :tracker_id => tracker.id,
        :author_id => user.id,
        :description => "Test description",
        :subject => "Subject added by the user"
      }
    }
    issue = Issue.last
    expect(issue.subject).to eq("Subject added by the user")
  end

  it "adds the start_date to the subject when configured" do
    AutocompletedField.create!(project_id: project.id, field_object: "Issue", field_name: "issue_start_date", position: 2)
    post :create, :params => {
      :project_id => project.id,
      :issue => {
        :tracker_id => tracker.id,
        :author_id => user.id,
        :start_date => "2024-06-01",
        :description => "Test avec date de début"
      }
    }
    issue = Issue.last
    expect(issue.subject).to eq("John Smith-Bug-2024-06-01")
  end
end
