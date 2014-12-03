$(document).ready(function() {

  $("#user-carousel").owlCarousel({
    autoPlay: 3000, //Set AutoPlay to 3 seconds
    items: 4,
    itemsDesktop: [1199,3],
    itemsDesktopSmall: [979,3]
  });

  $("#dive-carousel").owlCarousel({
    autoPlay: 5000,
    stopOnHover: true,
    navigation: true,
    paginationSpeed: 1000,
    goToFirstSpeed: 2000,
    singleItem: true,
    autoHeight: true,
    transitionStyle: "fade"
  });
});

