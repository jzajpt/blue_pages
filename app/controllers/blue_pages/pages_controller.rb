# encoding: utf-8

class BluePages::PagesController < ::ApplicationController

  respond_to :html

  def show
    @page = ::Page.where(:path => params[:path]).first
    if @page
      render_page
    else
      render_404
    end
  end

  protected
  
  def render_page
    if BluePages.layout.present?
      render_text
    else
      render_app_page
    end
  end

  def render_app_page
    render 'pages/show'
  end

  def render_text
    render :text => @page.content, :layout => BluePages.layout
  end

  def render_404
    render :file => File.join(Rails.root, "/public/404.html"),
           :status => :not_found,
           :layout => false
  end

end