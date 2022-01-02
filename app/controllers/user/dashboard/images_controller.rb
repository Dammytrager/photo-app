class User::Dashboard::ImagesController < User::DashboardController

  def index
    @images = user.images.order(created_at: :desc).map do |image|
      ImageStruct.new(image.blob.filename, url_for(image), image.blob.created_at, image.id)
    end
  end

  def create
    begin
      image = params.require(:image).require(:image)
      name = params.require(:image).require(:name)
      user.images.attach(io: image, filename: name)
      set_success(t('success.action_completed', item: 'Image', action: 'created'))
    rescue StandardError => e
      set_error(t('errors.action_not_completed', item: 'Image', action: 'created'))
    end
  end

  def destroy
    begin
      byebug
      @image = user.images.find(params[:format])
      @image.purge
      set_success(t('success.action_completed', item: 'Image', action: 'deleted'))
    rescue StandardError => e
      set_error(t('errors.action_not_completed', item: 'Image', action: 'deleted'))
    end
  end
end
