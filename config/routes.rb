Rails.application.routes.draw do
  get '/:locale' => 'books#index'

  scope '(:locale)', locale: /en|ja/ do
    resources :books
  end
end
