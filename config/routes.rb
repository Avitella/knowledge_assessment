Rails.application.routes.draw do
  root 'welcome#index'
  
  resources :users
  resources :user_sessions

  get  '/topics',               to: 'topics#index',     as: :topics
  get  '/topics/all',           to: 'topics#all',       as: :all_topics
  get  '/topics/:id',           to: 'topics#show',      as: :topic
  get  '/topics/destroy/:id',   to: 'topics#destroy',   as: :topic_destroy
  post '/topics/new',           to: 'topics#new',       as: :new_topic
  get  '/topics/edit/:id',      to: 'topics#edit',      as: :edit_topic
  post '/topics/edit_text/:id', to: 'topics#edit_text', as: :edit_topic_text

  get  '/questions',             to: 'questions#index',   as: :questions
  get  '/questions/:id',         to: 'questions#show',    as: :question
  get  '/questions/destroy/:id', to: 'questions#destroy', as: :question_destroy
  post '/questions/new',         to: 'questions#new',     as: :new_question
  post '/questions/edit/:id',    to: 'questions#edit',    as: :edit_question
  get  '/questions/show/:id',    to: 'questions#show',    as: :show_question

  get  '/answers',             to: 'answers#index',   as: :answers
  get  '/answers/destroy/:id', to: 'answers#destroy', as: :answer_destroy
  post '/answers/new',         to: 'answers#new',     as: :new_answer
  post '/answers/edit/:id',    to: 'answers#edit',    as: :edit_answer

  get  '/tests',             to: 'tests#index',   as: :tests
  get  '/tests/new',         to: 'tests#new',     as: :new_test
  get  '/tests/:id',         to: 'tests#show',    as: :test
  get  '/tests/destroy/:id', to: 'tests#destroy', as: :test_destroy
  post '/tests',             to: 'tests#save',    as: :save_test
  post '/tests/edit',        to: 'tests#edit',    as: :edit_tests
  get  '/tests/run/:id',     to: 'tests#run',     as: :run_test

  post '/variant/check/:id', to: 'variants#check', as: :check_variant

  get 'login'  => 'user_sessions#new', as: :login
  get 'logout' => 'user_sessions#destroy', as: :logout
end
