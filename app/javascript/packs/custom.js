jQuery(function() {
  $("a[rel~=popover], .has-popover").popover();
  $("a[rel~=tooltip], .has-tooltip").tooltip();
});

(function ($) {
  const fillModal = $('.fill-modal'),
      fillTrigger = $('.fill-trigger'),
      confirmModal = $('.confirm-modal'),
      confirmTrigger = $('.confirm-trigger');

  // Add custom filter method to object
  Object.filter = function( obj, predicate) {
    let result = {}, key;

    for (key in obj) {
      if (obj.hasOwnProperty(key) && predicate(key)) {
        result[key] = obj[key];
      }
    }

    return result;
  };

  const textTagNames = ['H1', 'H2', 'H3', 'H4', 'H5', 'H6', 'DIV', 'P', 'SPAN', 'LABEL', 'BUTTON']

  fillTrigger.on('click', function () {
    const fillItems = Object.filter($(this).data(), function (item) {
      if (typeof item !== 'string') return false
      return item.startsWith('fill_');
    })

    for (let key in fillItems) {
      const fillTarget = fillModal.find($(`.${key}`));
      const tagName = fillTarget.prop('tagName');

      switch (tagName) {
        case 'FORM':
          if (key.includes('action')) fillTarget.attr('action', fillItems[key])
          else if (key.includes('method')) fillTarget.append(`<input type="hidden" name="_method" value="${fillItems[key]}">`)
          break

        case 'INPUT':
          fillTarget.val(fillItems[key])
          break

        case 'IMG':
          fillTarget.attr('src', fillItems[key])
          break

        default:
          fillTarget.text(fillItems[key])
          break
      }
    }
  })


  confirmTrigger.on('click', function () {
    const confirmItems = Object.filter($(this).data(), function (item) {
      if (typeof item !== 'string') return false
      return item.startsWith('confirm_');
    })

    for (let key in confirmItems) {
      const confirmTarget = confirmModal.find($(`.${key}`));
      const tagName = confirmTarget.prop('tagName');

      switch (tagName) {
        case 'FORM':
          if (key.includes('action')) confirmTarget.attr('action', confirmItems[key])
          else if (key.includes('method')) confirmTarget.append(`<input type="hidden" name="_method" value="${confirmItems[key]}">`)
          break

        case 'INPUT':
          confirmTarget.val(confirmItems[key])
          break

        case 'IMG':
          confirmTarget.attr('src', confirmItems[key])
          break

        default:
          confirmTarget.text(confirmItems[key])
          break
      }
    }
  })

})(jQuery)
