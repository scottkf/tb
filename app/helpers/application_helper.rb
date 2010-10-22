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
  
  def autocomplete(data, selector)
    output = <<-HTML
var data = "#{data}".split(" ");
$("#{selector}").autocomplete(data)
HTML
    content_tag :script, :type => "text/javascript" do
      output
    end
  end



  def habtm_checkboxes(obj, column, assignment_objects, assignment_object_display_column)
    obj_to_s = obj.class.to_s.split("::").last.underscore
    field_name = "#{obj_to_s}[#{column}][]"
    
    html = hidden_field_tag(field_name, "")
    assignment_objects.each do |assignment_obj|
      cbx_id = "#{obj_to_s}_#{column}_#{assignment_obj.id}"
      html += check_box_tag field_name, assignment_obj.id, obj.send(column).include?(assignment_obj.id), :id => cbx_id
      html += label_tag cbx_id, h(assignment_obj.send(assignment_object_display_column))
      html += content_tag(:br)
    end
    html
  end
    
  
end
