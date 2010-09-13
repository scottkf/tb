class Article < ActiveRecord::Base
  belongs_to :author
  
  validate :title, :presence => true
  validate :body, :presence => true
  before_save :markdown
  self.per_page = 8

  def markdown
    self.rendered_body = RDiscount.new(self.body).to_html
  end
end
