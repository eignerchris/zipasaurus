$().ready(function() {
  var handler = StripeCheckout.configure({
    key: $("meta[name=stripe-pk]").attr('content'),
    token: function(token) {
      // Use the token to create the charge with a server-side script.
      // You can access the token ID with `token.id`
    }
  });

  $('#purchase').on('click', function(e) {
    // Open Checkout with further options
    handler.open({
      name: 'zipasaur.us',
      description: 'License Key',
      amount: 25000
    });
    e.preventDefault();
  });

  // Close Checkout on page navigation
  $(window).on('popstate', function() {
    handler.close();
  });

});