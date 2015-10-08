class PurchaseService
  def call(user)
    AllowUserService.new(user).call
    photo = GetPhotoService.new.call
    todo = PostTodoService.new.call
    return photo, todo
  end
end
