module ApplicationHelper
  def return_to_or_url(url)
    params[:return_to] || url
  end

  def activate_class(klass = nil)
    check = yield
    check ? (klass || 'active') : nil
  end
end
