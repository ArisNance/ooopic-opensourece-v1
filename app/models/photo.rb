require "google/cloud/storage"
class Photo < ActiveRecord::Base
    mount_uploader :image, ImageUploader
      
    attr_accessor :content, :name, :tag_list
    has_many :taggings
    has_many :tags, through: :taggings
    belongs_to :user
    
    # Tagging system
    def self.tagged_with(name)
      Tag.find_by_name!(name).photos
    end
    
    def self.tag_counts
      Tag.select("tags.*, count(taggings.tag_id) as count").
        joins(:taggings).group("taggings.tag_id")
    end
    
    def tag_list
      tags.map(&:name).join(", ")
    end
    
    def tag_list=(names)
      self.tags = names.split(",").map do |n|
        Tag.where(name: n.strip).first_or_create!
      end
    end
      
    belongs_to :category
       
    # Storage upload for Google.. DON'T TOUCH!  
    def self.storage_bucket
        @storage_bucket ||= begin
         config = Rails.application.config.x.settings
         storage = Google::Cloud::Storage.new project_id: config["lavail-203802"],
                                  credentials: config["lavail-53f1310346ba.json"]
         storage.bucket config["ooopic"]
    end
    ######## 
    
    # Implementing a simple search function
    def self.search(search)
      where("title ILIKE ?", "%#{search}%")
    end
    ####
    
    end
end
