# encoding: utf-8
TodoRailsApi::Application.routes.draw do
  devise_for :users, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout', :sign_up => 'register'}

  mount TodoApi => '/'

  mount GrapeSwaggerRails::Engine => '/doc/api'
end
