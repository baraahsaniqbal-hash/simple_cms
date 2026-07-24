module ApplicationHelper
  
  include Pagy::Frontend

  def error_messages_for(object)
    render 'shared/error_messages', :object => object 
  end

  def status_tag(boolean,options={})
    options[:true_text] ||= ''
    options[:false_text] ||= ''

    if boolean
      content_tag(:span, options[:true_text], :class =>'status true')
    else
      content_tag(:span, options[:false_text], :class =>'status false')
    end
  end
  
end
