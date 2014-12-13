app = angular.module 'mezouilhac-chalet', ['angularify.semantic.modal']

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

		$scope.changeImg = (img)->
			$scope.gallerie =  img

		$scope.open_modal = (id)->
			$scope.show_modal = true
			$scope.chalet = $scope.chalets[id]
			$scope.gallerie = $scope.chalet.img_principale

		$scope.close_modal = ->
			$scope.show_modal = false

]