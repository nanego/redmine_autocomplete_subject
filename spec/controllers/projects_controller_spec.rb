require "spec_helper"

describe ProjectsController, :type => :controller do
  fixtures  :users, :projects

  before do
    @request.session[:user_id] = 1
  end

  describe "copy a project" do
    let(:source_project) { Project.find(2) }

    it "Copy all parameters of autocomplete_subject" do
      AutocompletedField.create(project_id: source_project.id, field_object: "Issue", field_name: "issue_author_id", position: 0)
      AutocompletedField.create(project_id: source_project.id, field_object: "Issue", field_name: "issue_tracker_id", position: 1)
      AutocompletedField.create(project_id: source_project.id, field_object: "Issue", field_name: "issue_category_id", position: 2)

      source_project.autocomplete_separator = "--"
      source_project.show_subject_input = 3
      source_project.autocomplete_subject_tracker_ids = "2|3"
      source_project.save

      expect do
        post :copy, :params => {
          :id => source_project.id,
          :project => {
            :name => 'test project',
            :identifier => 'test-project'
          },
          :only => %w(autocomplete_subject)
        }
      end.to change { AutocompletedField.count }.by(3)

      new_pro = Project.last

      expect(new_pro.autocomplete_separator).to eq("--")
      expect(new_pro.show_subject_input).to eq(3)
      expect(new_pro.autocomplete_subject_tracker_ids).to eq("2|3")

      expect(AutocompletedField.last.project.id).to eq(new_pro.id)
      expect(AutocompletedField.last.field_object).to eq("Issue")
      expect(AutocompletedField.last.field_name).to eq("issue_category_id")
      expect(AutocompletedField.last.position).to eq(2)
    end
  end

  it "update AutocompletedField table when delete a project" do
    project = Project.last
    AutocompletedField.create(project_id: project.id, field_object: "Issue", field_name: "issue_author_id", position: 0)
    expect do
      project.destroy
    end.to change { AutocompletedField.count }.by(-1)
  end
end