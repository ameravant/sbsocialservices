resources :inquiries, :as => "suggestions", :only => [:new, :create]

namespace :admin do |admin|
  admin.resources :inquiries, :as => 'suggestions', :has_many => :comments
end

suggestions '/suggestions', :controller => "inquiries", :action => "new"