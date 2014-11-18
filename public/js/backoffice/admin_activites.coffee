app = angular.module 'mezouilhac-backoffice', []

app.controller "activiteCtrl", [
	"$scope"
	"$http"
	($scope, $http) ->


		$scope.list_activites = []

		$scope.listIcon = [
			"arbre"
			"animaux"
		]

		$scope.init = ->
			$scope.activite =
				nom: null
				position:
					latitude: null
					longitude: null
				categorie: null
				adresse: null
				url: null
				icon: 'arbre'

			$scope.action = 'add'

		$scope.init()

		$scope.addActivite = ->
			$http.post('/admin/activites/add', $scope.activite).success (d)->
				$scope.message = d
				if d.ok
					$scope.list_activites.push $scope.activite

		$scope.updateActivite = (id)->
			$http.post('/admin/activites/update/'+$scope.activite._id, $scope.activite).success (d)->
				$scope.message = d
				$scope.list_activites[$scope.getIndexInList($scope.activite)] = $scope.activite

		$scope.deleteActivite = (id)->
			$http.post('/admin/activites/remove/'+$scope.activite._id).success (d)->
				$scope.message = d
				$scope.list_activites.splice($scope.getIndexInList($scope.activite), 1)

		$scope.getActivite = (id)->
			$http.get('/api/activites/'+id).success (d)->
				$scope.activite = d
				$scope.action = 'update'

		$scope.changeCategorie = (choix_categorie)->
			$scope.activite.categorie = choix_categorie

		$scope.changeIcon = (icon)->
			$scope.activite.icon = icon

		$http.get('/api/activites').success (d)->
			$scope.list_activites = d

		$scope.getAdresse = ->
			lat = parseFloat($scope.activite.position.latitude)
			lon = parseFloat($scope.activite.position.longitude)
			$http.get('https://maps.googleapis.com/maps/api/geocode/json?latlng='+lat+','+lon+'6&key=AIzaSyDvrkKnNAGJ8w_zmoKpSVd5i_XBVS_yriA').success (d)->
				$scope.activite.adresse = d.results[0].formatted_address

		$scope.getIndexInList = (activite)->
			i = 0
			while i <  $scope.list_activites.length
				if $scope.list_activites[i]['_id'] is activite._id  then return i
				i++
			return -1

]