#$ ->
#
#    $('.slider').slick
#        centerMode: true
#        lazyLoad: 'ondemand'
#        autoplay: true
#        autoplaySpeed: 2000
#        variableWidth: true
#
#    $('.slider .slick-slide img').width($('.slider').width())

app = angular.module 'mezouilhac-home', ['ui.bootstrap']


app.controller "HomeController", [
    "$scope"
    ($scope) ->

        $scope.myInterval = 5000
        $scope.slides = [
            {
                image : "/img/slider/slider1.jpg"
                text: "trop dla balle"
            },
            {
                image : "/img/slider/slider2.jpg"
                text: "This is a caption"
            }
        ]

]