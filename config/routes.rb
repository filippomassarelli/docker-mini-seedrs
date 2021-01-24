Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :campaigns, only: [:index, :show] do
        collection do
          get :open
          get :target_desc
          get :target_asc
          get :open_and_target_desc
          get :open_and_target_asc
        end
      end
      resources :investments, only: :create
    end
  end
end
