module ApplicationHelper
  # bootstrap_class_for method used to add twitter bootstrap class names to flash messages
  def bootstrap_class_for(flash_type)
    case flash_type
      when "success"
        "alert-success"
      when "error"
        "alert-danger"
      when "notice"
        "alert-info"
      else
        flash_type.to_s
    end
  end
end
