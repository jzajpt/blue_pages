# encoding: utf-8

Rails::Application.routes.draw do


  if BluePages.route_prefix.present?

    match "#{BluePages.route_prefix}/*path" => "blue_pages/pages#show"

  else

    match '*path' => "blue_pages/pages#show"

  end

end
