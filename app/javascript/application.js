// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "popper"
import "bootstrap"
import "chartkick"
import "Chart.bundle"
import "@nathanvda/cocoon"

document.addEventListener('turbo:load', () => {
  function getCSRFToken() {
    return $('meta[name="csrf-token"]').attr('content');
  }

  // Set up AJAX with CSRF token
  $.ajaxSetup({
    beforeSend: function(xhr, settings) {
      if (!settings.crossDomain) {
        xhr.setRequestHeader('X-CSRF-Token', getCSRFToken());
      }
    }
  });

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

  $('#book_status').change(function() {
    if ($(this).val() === 'read') {
      $('#rating').show();
      $('#remove-from-shelf').hide();
    } else if ($(this).val() === 'dnf') {
      $('#remove-from-shelf').show();
    } else {
      $('#rating').hide();
      $('#remove-from-shelf').hide();
    }
  });

  $('.rating-option').on('click', function(e) {
    e.preventDefault();
    let bookId = $(this).data('book-id');
    let newRating = $(this).data('rating');

    $.ajax({
      url: `/books/${bookId}/update_rating`,
      type: 'PATCH',
      headers: {
        'Content-Type': 'application/json'
      },
      data: JSON.stringify({ rating: newRating }),
      success: function(data) {
        location.reload();
      },
    });
  });
});
