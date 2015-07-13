Rails.application.routes.draw do

  resources :autocompleted_fields, except: [:show] do
    collection do
      post 'update_by_project'
    end
  end

end
