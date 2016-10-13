Deface::Override.new :virtual_path => 'issues/_form',
                     :name         => 'insert_js_script_for_autocompleted_fields',
                     :insert_before => 'erb[loud]:contains("javascript_tag")',
                     :partial      => "issues/autocomplete_subject"
Deface::Override.new :virtual_path => 'issues/_form_with_positions',
                     :name         => 'insert_js_script_for_autocompleted_fields',
                     :insert_before => 'erb[loud]:contains("javascript_tag")',
                     :partial      => "issues/autocomplete_subject"
