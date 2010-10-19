class Category < ActiveRecord::Base

  has_ancestry
  has_many :articles
  
  validates :name, :presence => true, :uniqueness => true
  validates :layout, :presence => true
  validates :description, :presence => true
  validates :url, :presence => true, :uniqueness => true
  
  before_create :layout_exists

  validates_format_of :url, :with => /\A[a-zA-Z0-9]+\z/, :message => "No special characters are allowed"
  validates_length_of :url, :in => 3..10, :too_short => "Must have atleast 3 characters", :too_long => "Must have 10 or fewers characters"

  private
  def layout_exists
    if !File.exists?(Rails.root.join("app", "views", "layouts", "#{self.layout}.html.erb"))
      File.open(Rails.root.join("app", "views", "layouts", "#{self.layout}.html.erb"), 'w') {|f| f.write("<html>\n<body>\n</body>\n</html>\n") }
    end
  end
end
