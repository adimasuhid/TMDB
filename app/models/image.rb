class Image < ActiveRecord::Base
  attr_accessible :approved, :image_file, :image_type, :is_main_image, :imageable_id, :imageable_type, :title
  belongs_to :imageable, polymorphic: true

  has_many :tags, :as => :taggable
  has_many :list_items, :as => :listable
  has_many :images, :as => :imageable
  has_many :videos, :as => :videable
  has_many :follows, :as => :followable
  has_many :views, :as => :viewable
  has_many :reports, :as => :reportable

end