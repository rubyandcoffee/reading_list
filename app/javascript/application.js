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
  $('.new-goal').addClass('hidden');
});

$('.rentals').on('cocoon:after-insert', function() {
  $('.max-one-association').addClass('hidden');
});

$('.rentals').on('cocoon:after-remove', function() {
  $('.max-one-association').removeClass('hidden');
});

$('.book_goals').on('cocoon:after-remove', function() {
  $('.new-goal').removeClass('hidden');
});