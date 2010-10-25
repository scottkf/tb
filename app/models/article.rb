class Article < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  
  validates :title, :presence => true
  validates :body, :presence => true
  validates :user, :presence => true
  validates :category, :presence => true
  validates :permalink, :uniqueness => true

  before_save :markdown
  before_save :format_permalink

  #scopes
  def self.published
    where(:published => true).order('created_at DESC')
  end
  
  def self.ordered(o)
    order(sort_params[o] || 'created_at DESC')
  end
  
  #order params
  def self.sort_params
    { 
      "by_title" => "title ASC", 
      "by_created" => "created_at DESC", 
      "by_updated" => "updated_at DESC", 
      "published" => "published DESC"
    }
  end
  
  #override route
  def to_param
    id.to_s + "-" + permalink
  end

  def to_permalink
    self.title.parameterize
  end

  def format_permalink
    if self.permalink and self.permalink.size > 0
      self.permalink = self.permalink.parameterize
    else
      self.permalink = self.to_permalink
    end
  end
  

  def markdown
    self.rendered_body = RDiscount.new(self.body).to_html
  end
end
