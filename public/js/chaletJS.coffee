app = angular.module 'mezouilhac-chalet', []

app.filter "imgFull", [ ->
	(img)->
			if !img
				return null
			return img.substr(0, img.length-8)+img.substr(img.length-4, img.length)
]

app.controller "chaletsCtrl", [
	"$scope"
	"$http"
	($scope, $http) ->

		$scope.chalets = []
		$scope.chalet = null
		$scope.gallerie = null

		$scope.loadChalet = (id)->
			$http.get("/api/chalets/"+id).success((d)->
				$scope.chalets[id] = d
			)

		$scope.openModal = (id)->
			$('.ui.modal').modal 'show'
			$scope.chalet = $scope.chalets[id]
			$scope.gallerie = $scope.chalet.img_principale

		$scope.changeImg = (img)->
			$scope.gallerie =  img

]