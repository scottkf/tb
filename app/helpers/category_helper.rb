module CategoryHelper

  def layouts
    Dir.glob(Rails.root.join("app", "views", "layouts", "*")).map {|x| File.basename(x, ".html.erb") }
  end

end