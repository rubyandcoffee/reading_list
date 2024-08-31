// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "popper"
import "bootstrap"
import "chartkick"
import "Chart.bundle"
import "@nathanvda/cocoon"

document.addEventListener('turbo:load', () => {
  let $bookGoals = $('#book-goals');
  let $addGoal = $('#add-goal');

  $bookGoals.on('cocoon:after-insert', function() {
    $addGoal
      .text('Add another month')
      .removeClass('btn-outline-success')
      .addClass('btn-outline-primary');
  });

  $bookGoals.on('cocoon:after-remove', function() {
    if ($('.book-goal').length === 0) {
      $addGoal
        .text('Are you reading it this year?')
        .removeClass('btn-outline-primary')
        .addClass('btn-outline-success');
    }
  });

  $('#show-rental-form').on('click', function(e) {
    e.preventDefault();
    $('#rental-form').toggle();
    $(this).toggle();
  });

  $('#remove-rental').on('click', function() {
    $('#book_rental_attributes_loaner_id').val('')
  })

  $('#book_status').change(function() {
    if ($(this).val() === 'read') {
      $('#rating').show();
    } else {
      $('#rating').hide();
    }
  });
});
