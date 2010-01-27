resources :inquiries, :as => "suggestions", :only => [:new, :create]

namespace :admin do |admin|
  admin.resources :inquiries, :as => 'suggestions'
end

suggestions '/suggestions', :controller => "inquiries", :action => "new"