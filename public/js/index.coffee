$ ->

    $('.slider').slick
        centerMode: true
        lazyLoad: 'ondemand'
        autoplay: true
        autoplaySpeed: 2000
        variableWidth: true

    $('.slider .slick-slide img').width($('.slider').width())