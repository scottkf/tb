class Article < ActiveRecord::Base
  belongs_to :user
  
  validates :title, :presence => true
  validates :body, :presence => true
  before_save :markdown

  def markdown
    self.rendered_body = RDiscount.new(self.body).to_html
  end
end
