Badgenator::Application.routes.draw do
  root :to => 'welcome#index'

  match '/contacts' => 'welcome#contacts', :as => :contacts
  match '/archive' => 'badge_sets#index'
  match '/archive/page/:page' => 'badge_sets#index'
  match '/archive/new' => 'badge_sets#new'
  match '/archive/:id/edit' => 'badge_sets#edit'
  
  match '/archive/:badge_set_id/badges' => 'badges#index'
  match '/archive/:badge_set_id/badges/page/:page' => 'badges#index'
  match '/archive/:badge_set_id/print' => 'badge_sets#print'
  match '/archive/:badge_set_id/badges/new' => 'badges#new'
  match '/archive/:badge_set_id/badges/:id' => 'badges#show'
  match '/archive/:badge_set_id/badges/:id/edit' => 'badge_sets#edit'
end
