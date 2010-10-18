Before do
  @layouts = Dir[Rails.root.join("app", "views", "layouts","*")]
end
  
After do
  @new_layouts = Dir[Rails.root.join("app", "views", "layouts","*")]
  @new_layouts.map { |f| f if !@layouts.include? f }.compact.each do |f|
    File.delete(f) if File.exists? f
  end
end