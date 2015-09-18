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
      raw "<div class='navbar-brand'>Welcome, <a href = #{profile_path}>#{user.name}</a></div>"
    else
      raw "<div class='navbar-brand'>Welcome, <a href = #{profile_path}>#{user.shop_name}</a></div>"
    end
  end

end
