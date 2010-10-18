class Article < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  
  validates :title, :presence => true
  validates :body, :presence => true
  validates :user, :presence => true
  validates :category, :presence => true
  before_save :markdown

  def markdown
    self.rendered_body = RDiscount.new(self.body).to_html
  end
end
