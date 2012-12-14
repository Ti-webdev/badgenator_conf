Badgenator::Application.routes.draw do
  match 'contacts' => 'welcome#contacts', :as => :contacts
  match 'archive' => 'welcome#archive'
  match 'archive/new' => 'badge_sets#create'
  
  root :to => 'welcome#index'
end
