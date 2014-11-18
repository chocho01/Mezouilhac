(function() {
  $(function() {
    $('.slider').slick({
      centerMode: true,
      lazyLoad: 'ondemand',
      autoplay: true,
      autoplaySpeed: 2000,
      variableWidth: true
    });
    return $('.slider .slick-slide img').width($('.slider').width());
  });

}).call(this);

//# sourceMappingURL=index.js.map
