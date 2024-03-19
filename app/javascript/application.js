// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "popper"
import "bootstrap"
import "chartkick"
import "Chart.bundle"
import "@nathanvda/cocoon"

$(".new-goal").on('click', function() {
  $('.new-goal').text('Add another month');
});

$('.select_per_page').on('change', function(e) {
  if (e.currentTarget.length > 0) {
    if(e.currentTarget.value) {
      window.location='?per_page=' + e.currentTarget.value;
    }
  }
})
