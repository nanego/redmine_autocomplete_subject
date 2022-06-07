Deface::Override.new  :virtual_path  => "projects/copy",
                        :name          => "copy-projects-autocomplete_subject",
                        :insert_after  => ".block:contains('@source_project.wiki.nil?')",
                        :text          => <<EOS
  <label class="block"><%= check_box_tag 'only[]', 'autocomplete_subject', true, :id => nil %> <%= l(:autocomplete_subject) %></label>
EOS

