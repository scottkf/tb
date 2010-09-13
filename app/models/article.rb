class Article < ActiveRecord::Base
  belongs_to :author
  
  validates :title, :presence => true
  validates :body, :presence => true
  before_save :markdown
  self.per_page = 8


  def markdown
    self.rendered_body = RDiscount.new(self.body).to_html
  end
end
