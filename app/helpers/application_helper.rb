module ApplicationHelper
  def edit_and_destroy_buttons(item)
    return if current_user.nil?

    edit = link_to('Edit', url_for([:edit, item]), class: "btn btn-primary")
    del = button_to "Destroy", item, method: :delete,
                                     data: { turbo_confirm: "Are you sure ?" },
                                     class: "btn btn-danger"
    if current_user.admin?
      raw("#{edit} #{del}")
    else
      raw(edit.to_s)
    end
  end

  def change_status_button(user)
    return if current_user.nil? && current_user.admin?

    change = link_to "Change account status", toggle_status_user_path(user.id), data: { turbo_method: "post" }, class: "btn btn-danger"
    raw(change.to_s)
  end

  def round(number)
    number_with_precision(number, precision: 2)
  end
end
