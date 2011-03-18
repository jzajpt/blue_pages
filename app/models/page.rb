# encoding: utf-8

require 'mongoid/tree'
require 'bluecloth'
require 'redcloth'

class Page

  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Tree
  include LocalizedKeys

  (BluePages.model_includes || []).each do |mod|
    include mod
  end

  store_in :blue_pages

  i18n_field :title
  i18n_field :content
  field :permalink
  field :path
  field :meta_data,        :type => Hash
  field :published,        :type => Boolean, :default => true
  field :custom_permalink, :type => Boolean, :default => false
  field :filter,           :default => 'none'

  validates_presence_of   :title
  validates_uniqueness_of :title
  validates_inclusion_of  :filter, :in => %w( none markdown )

  scope :published,   where(:published => true)
  scope :unpublished, where(:published => false)

  before_save     :check_permalink_presence
  after_rearrange :rebuild_path

  # Sets title and generates permalink if custom permalink is disabled.
  def title=(new_title)
    write_attribute(:permalink, Permalink.from(new_title)) unless self.custom_permalink?
    write_attribute(:title, new_title)
  end
  
  # Sets permalink only if custom permalink is enabled.
  def permalink=(permalink)
    write_attribute(:permalink, permalink) if self.custom_permalink?
  end

  def to_s
    title
  end
  
  def preferred_content
    lang = I18n.locale.to_s
    if content(lang).present?
      content(lang)
    else
      content
    end
  end

  def to_html
    content = I18n.locale
    filters = { 'markdown' => BlueCloth,
                'textile'  => RedCloth }
    if filters.include?(self.filter)
      filters[self.filter].new(self.preferred_content).to_html
    else
      self.preferred_content
    end
  end

  protected
  
  def check_permalink_presence
    unless self.permalink.present? || self.custom_permalink?
      write_attribute(:permalink, Permalink.from(title)) if title
    end
  end

  def rebuild_path
    check_permalink_presence
    self.path = self.ancestors_and_self.collect(&:permalink).join('/')
  end

end