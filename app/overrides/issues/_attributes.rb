Deface::Override.new :virtual_path => 'issues/_form',
                     :name         => 'insert_js_script_for_autocompleted_fields',
                     :insert_before => 'erb[loud]:contains("javascript_tag")',
                     :text      => <<EOD
<%= javascript_tag do %>
  <%= render :partial => "issues/autocomplete_subject.js" %>
<% end %>

EOD
