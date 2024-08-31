// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "popper"
import "bootstrap"
import "chartkick"
import "Chart.bundle"
import "@nathanvda/cocoon"

$(document).ready(function() {
  let $rentals = $('#rentals');
  let $bookGoals = $('#book-goals');
  let $addRental = $('#add-rental');
  let $addGoal = $('#add-goal');

  function showOrHideNewLink(linkName, container) {
    if ($(container).is(':visible')) {
      $(linkName).hide();
    } else {
      $(linkName).show();
    }
  }

  $rentals.on('cocoon:after-insert', function() {
    showOrHideNewLink($addRental, $('.rental'));
  });

  $rentals.on('cocoon:after-remove', function() {
    showOrHideNewLink($addRental, $('.rental'));
  });

  $bookGoals.on('cocoon:after-insert', function() {
    $addGoal.text('Add another month');
  });

  $bookGoals.on('cocoon:after-remove', function() {
    if ($('.book-goal').length === 0) {
      $addGoal.text('Are you reading it this year?');
    }
  });

  showOrHideNewLink($addRental, $('.rental'));
});
