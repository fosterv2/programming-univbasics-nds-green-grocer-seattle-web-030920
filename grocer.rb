
def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  item = nil
  item_index = 0
  while item_index < collection.length do
    if name == collection[item_index][:item]
      item = collection[item_index]
    end
    item_index += 1
  end
  item
end

def consolidate_cart(cart)
  # REMEMBER: This returns a new Array that represents the cart.
  # Don't merely change `cart` (i.e. mutate) it. It's easier to return a new thing.
  new_cart = []
  item_index = 0
  new_index = 0
  while item_index < cart.length do
    new_cart_item = find_item_by_name_in_collection(cart[item_index][:item], new_cart)
    if new_cart_item
      new_cart_item[:count] += 1
    else
      new_cart[new_index] = cart[item_index]
      new_cart[new_index][:count] = 1
      new_index += 1
    end
    item_index += 1
  end
  new_cart
end

def apply_coupons(cart, coupons)
  # REMEMBER: This method **should** update cart
  coupon_index = 0
  while coupon_index < coupons.length do
    name = coupons[coupon_index][:item]
    cart_item = find_item_by_name_in_collection(name, cart)
    couponed_name = "#{name} W/COUPON"
    cart_item_with_coupon = find_item_by_name_in_collection(couponed_name, cart)
    if cart_item && cart_item[:count] >= coupons[coupon_index][:num]
      if cart_item_with_coupon
        cart_item_with_coupon[:count] += coupons[coupon_index][:num]
        cart_item[:count] -= coupons[coupon_index][:num]
      else
        cart_item_with_coupon = {
          item: couponed_name,
          price: coupons[coupon_index][:cost] / coupons[coupon_index][:num],
          clearance: cart_item[:clearance],
          count: coupons[coupon_index][:num]
        }
        cart << cart_item_with_coupon
        cart_item[:count] -= coupons[coupon_index][:num]
      end
    end
    coupon_index += 1
  end
  cart
  # item_index = 0
  # while item_index < cart.length do
  #   coupon_index = 0
  #   while coupon_index < coupons.length do
  #     name = coupons[coupon_index][:item]
  #     item = find_item_by_name_in_collection(name, cart)
  #     if item
  #       if item[:count] == coupons[coupon_index][:num]
  #         cart[item_index] = {
  #           item: "#{name} W/COUPON",
  #           price: coupons[coupon_index][:cost] / coupons[coupon_index][:num],
  #           clearance: item[:clearance],
  #           count: coupons[coupon_index][:num]
  #         }
  #       elsif item[:count] > coupons[coupon_index][:num]
  #         cart >> {
  #           item: "#{name} W/COUPON",
  #           price: coupons[coupon_index][:cost] / coupons[coupon_index][:num],
  #           clearance: item[:clearance],
  #           count: coupons[coupon_index][:num]
  #         }
  #         cart[item_index][:count] = item[:count] - coupons[coupon_index][:num]
  #       end
  #     end
  #   end
  #   item_index += 1
  # end
  # cart
end

def apply_clearance(cart)
  # REMEMBER: This method **should** update cart
  item_index = 0
  while item_index < cart.length do
    if cart[item_index][:clearance]
      cart[item_index][:price] = (cart[item_index][:price] * 0.8).round(2)
    end
    item_index += 1
  end
  cart
end

def checkout(cart, coupons)
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  # BEFORE it begins the work of calculating the total (or else you might have some irritated customers)
  consolidated_cart = consolidate_cart(cart)
  cart_with_coupons = apply_coupons(consolidated_cart, coupons)
  discounted_cart = apply_clearance(cart_with_coupons)
  total = 0
  item_index = 0
  while item_index < discounted_cart.length do
    total += discounted_cart[item_index][:count] * discounted_cart[item_index][:price]
    item_index += 1
  end
  if total > 100
    total = (total * 0.9).round(2)
  end
  total
end
