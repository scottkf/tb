module ApplicationHelper

  def flash_messages 
    %w(notice warning error alert).each do |msg| 
      concat content_tag(:div, content_tag(:p, flash[msg.to_sym]), 
        :class => "notice #{msg}") unless flash[msg.to_sym].blank? 
    end 
  end
  
  
  def current_page
    (controller_name.downcase + action_name.capitalize) 
  end
  
end
