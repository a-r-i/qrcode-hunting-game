Rails.application.routes.draw do
    get '/', to:'user#infomation'
    get '/mining/:id', to: 'mining#index'
    get '/payment', to: 'user#payment'
    post '/payment', to: 'user#payment'
    get '/payment/completion/:result', to: 'user#payment_completion'
    get '/signup', to:'user#signup'
    get '/auth/:provider/callback', to: 'sessions#create'
    get '/logout', to: 'sessions#destroy'
    get '/api', to:'apis#index'
end
