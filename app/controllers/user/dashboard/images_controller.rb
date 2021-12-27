class User::Dashboard::ImagesController < User::DashboardController

  def index
    @images = user.images
    @image = Image.new
  end

  def create
    byebug
  end

  def destroy
  end

end
