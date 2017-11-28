PostitTemplate::Application.routes.draw do
  root to: 'posts#index'


  get  'login',  to: 'sessions#new'
  post 'login',  to: 'sessions#create'
  get  'logout', to: 'sessions#destroy'

  resources :posts, except: [:destroy] do
    member do
      post :vote
    end

  	resources :comments, only: [:create] do
  	  member do
  	    post :vote
  	  end
  	end
  end

  # To POST to posts/:id/comments from /posts/show.html.erb,
  # need to use an array in form_for: <%= form_for [@post, @comment] do |f| %>

  resources :categories, only: [:new, :create, :show]

  # don't need index or new
  resources :users, only: [:show, :create, :edit, :update]

  # manual routes
  get 'register', to: 'users#new'



  # get 	'/posts', 					to: 'posts#index'
  # get 	'/posts/:id', 			to: 'posts#show'
  # get 	'/categories/new', 			to: 'categories#new'
  # post 	'/categories', 					to: 'categories#create'
  # get 	'/posts/:id/edit', 	to: 'posts#edit'
  # patch '/posts/:id', 			to: 'posts#update'

end
