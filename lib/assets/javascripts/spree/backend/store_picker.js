$.fn.storeAutocomplete = function() {
  this.select2({
    minimumInputLength: 1,
    multiple: true,
    initSelection: function(element, callback) {
      $.get(Spree.routes.store_search, { ids: element.val() }, function(data) {
        callback(data)
      })
    },
    ajax: {
      url: Spree.routes.store_search,
      datatype: 'json',
      data: function(term, page) {
        return { q: term }
      },
      results: function(data, page) {
        return { results: data }
      }
    },
    formatResult: function(store) {
      return store.name;
    },
    formatSelection: function(store) {
      return store.name;
    },
    id: function(store) {
      return store.id
    }
  });
}

$(document).ready(function () {
  $('.store_picker').storeAutocomplete();
})
