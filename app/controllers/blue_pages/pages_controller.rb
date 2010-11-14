# encoding: utf-8

class BluePages::PagesController < ::ApplicationController

  respond_to :html

  def show
    @page = BluePages::Page.where(:path => params[:path]).first
    unless @page
      render_404
    end
  end
  
  protected
  
  def render_404
    render :file => File.join(Rails.root, "/public/404.html"), 
           :status => :not_found,
           :layout => false
  end

end