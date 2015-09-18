module ApplicationHelper
  def pro_product(product)
    if product.pro
      raw '<span class="label label-info">PRO</span>'
    end
  end
  def wellcome_name(user)
    if user.role == 'user'
      raw "<div class='navbar-brand'>Welcome, #{user.email}</div>"
    elsif user.role == 'admin'
      raw "<div class='navbar-brand'>Welcome, #{user.name}</div>"
    else
      raw "<div class='navbar-brand'>Welcome, #{user.shop_name}</div>"
    end
  end

end
