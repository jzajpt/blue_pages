# encoding: utf-8

class Page

  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Tree

  field :title
  field :permalink
  field :path
  field :metadata, :type => Hash
  field :content
  field :published, :type => Boolean, :default => true 

  validates_presence_of   :title
  validates_uniqueness_of :title
  
  scope :published,   where(:published => true)
  scope :unpublished, where(:published => false)

  after_rearrange :rebuild_path

  def title=(new_title)
    write_attribute(:permalink, Permalink.from(new_title))
    write_attribute(:title, new_title)
  end

  protected

  def rebuild_path
    self.path = self.ancestors_and_self.collect(&:permalink).join('/')
  end

end