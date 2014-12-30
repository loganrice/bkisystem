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

  def link_to_add_fields(name, f, association) 
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, "#", class: "add_fields btn btn-primary", data: {id: id, fields: fields.gsub("\n", "")})  
  end

  def link_to_add_fields_to_table(name, f, association) 
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, "#", class: "add_fields btn btn-primary", data: {id: id, fields: fields.gsub("\n", "")})  
  end

  def to_dollars(cents)
    cents / 100
  end
  
end
