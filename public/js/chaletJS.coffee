# $ ->
# 	$('.open-chalet').click (e)->
# 		modal = $(e.target).attr "data-modal"
# 		$('.ui.modal.modal'+modal).modal 'show'
# 		return
# 	return


app = angular.module 'mezouilhac-chalet', []

app.controller "chaletsCtrl", [
	"$scope"
	"$http"
	($scope, $http) ->

		$scope.chalets = []
		$scope.chalet = null
		$scope.gallery = {
			main : null
		}

		$scope.loadChalet = (id)->
			$http.get("/chalet/"+id).success((d)->
				$scope.chalets[id] = d[0]
			)

		$scope.openModal = (id)->
			$('.ui.modal').modal 'show'
			$scope.chalet = $scope.chalets[id]
			$scope.gallery.main = $scope.chalet.image.principale

		$scope.changeImg = (img)->
			$scope.gallery.main = img
]