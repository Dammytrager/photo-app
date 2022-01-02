module User::DropdownHelper

  def image_dropdown(image)
    return [
      {
        label: 'View',
        class: 'fill-trigger',
        data: {
          target: '#image_modal',
          toggle: 'modal',
          fill_image: image.url,
          fill_modal_title: image.name
        }
      },
      {
        label: 'Delete',
        class: 'confirm-trigger',
        data: {
          target: '#confirm_image_modal',
          toggle: 'modal',
          confirm_modal_title: 'Delete Image?',
          confirm_action: user_dashboard_images_path(image.id),
          confirm_method: :delete,
          confirm_message: t('images.confirm_delete'),
          confirm_button_label: t('images.delete_label')
        }
      }
    ]
  end

end
