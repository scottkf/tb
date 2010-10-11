class ApplicationController < ActionController::Base
  protect_from_forgery
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:notice] = exception.message
    redirect_to new_user_session_url
  end

  def respond_to_not_found(*types)
    asset = self.controller_name.singularize
    flick = case self.action_name
      when "destroy" then "delete"
      when "promote" then "convert"
      else self.action_name
    end
    if self.action_name == "show"
      flash[:warning] = t(:msg_asset_not_available, asset)
    else
      flash[:warning] = t(:msg_cant_do, :action => flick, :asset => asset)
    end
    respond_to do |format|
      format.html { redirect_to(:action => :index) } if types.include?(:html)
      format.js { render(:update) { |page| page.reload } } if types.include?(:js)
      format.xml { render :text => flash[:warning], :status => :not_found } if types.include?(:xml)
    end
  end


  def respond_to_destroy(method)
    if method == :ajax
    else
      flash[:notice] = "#{@user.name} has been deleted."
      redirect_to(users_path)
    end
  end
  
end
