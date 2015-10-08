module ProductsHelper
  def shop_name(product)
    if product.name_shop.present?
      raw "<p class = 'qwe'>Shop: #{product.name_shop}</p>"

    end
  end

  def purchase_button(product)
    if product.name_shop.present? && !product.pro?
      link_to "Purchase Now", purchase_product_path(product), method:'POST', class: "btn btn-primary btn-lg active purchase-link" if can? :purchase, Product
    end
  end
end
