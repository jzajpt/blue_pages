# encoding: utf-8

Rails::Application.routes.draw do


  if BluePages.route_prefix.present?
    
    match "#{BluePages.route_prefix}/*path" => "pages#show"
    
  else
    
    match '*path' => "pages#show"
    
  end

end

