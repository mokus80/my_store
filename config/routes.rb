Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'shopping_cart/home'
 
  root 'shopping_cart#home'
end
