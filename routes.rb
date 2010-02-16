resources :inquiries, :as => "suggestions", :only => [:new, :create, :show]

namespace :admin do |admin|
  admin.resources :inquiries, :as => 'suggestions', :has_many => :comments
end

suggestions '/suggestions', :controller => "inquiries", :action => "new"
suggestions_received '/suggestions_received', :controller => "inquiries", :action => "index"