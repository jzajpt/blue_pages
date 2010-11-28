# encoding: utf-8

require 'mongoid/tree'

class Page

  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Tree

  (BluePages.model_includes || []).each do |mod|
    include mod
  end

  store_in :blue_pages

  field :title
  field :permalink
  field :path
  field :metadata, :type => Hash
  field :content
  field :published, :type => Boolean, :default => true
  field :filter,    :default => 'none'

  validates_presence_of   :title
  validates_uniqueness_of :title
  validates_inclusion_of  :filter, :in => %w( none markdown )

  scope :published,   where(:published => true)
  scope :unpublished, where(:published => false)

  after_rearrange :rebuild_path

  def title=(new_title)
    write_attribute(:permalink, Permalink.from(new_title))
    write_attribute(:title, new_title)
  end

  def to_s
    title
  end

  def to_html
    filters = { 'markdown' => BlueCloth,
                'textile'  => RedCloth }
    if filters.include?(self.filter)
      filters[self.filter].new(self.content).to_html
    else
      self.content
    end
  end

  protected

  def rebuild_path
    self.path = self.ancestors_and_self.collect(&:permalink).join('/')
  end

end