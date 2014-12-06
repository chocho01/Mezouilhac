$(".activites").height($(window).height() - ($(window).height()/5))
$(".list-activites").height($(window).height() - ($(window).height()/6.5))

arrayObjectIndexOf = (myArray, searchTerm, property) ->
	i = 0
	len = myArray.length

	while i < len
		return i  if myArray[i][property] is searchTerm
		i++
	-1

app = angular.module 'mezouilhac-gmap', ['google-maps'.ns()]

app.config [
	"GoogleMapApiProvider".ns()
	(GoogleMapApi) ->
		GoogleMapApi.configure
			key: 'AIzaSyDvrkKnNAGJ8w_zmoKpSVd5i_XBVS_yriA',
			v: "3.17"
			libraries: "weather,geometry,visualization"
		return
]

app.controller "activiteCtrl", [
	"$scope"
	'Logger'.ns()
	"GoogleMapApi".ns()
	"$http"
	($scope, $log, GoogleMapApi, $http) ->

		$log.doLog = true

		$scope.activites = []
		$scope.list_activites = []

		$http.get('api/activites').success (d)->
			$scope.list_activites = d
			for activite, i in d
				$scope.activites.push
					latitude: activite.position.latitude
					longitude: activite.position.longitude
					id: activite._id
					icon: "img/icon/"+activite.icon+"_marker.png"
					url: activite.url
					img: "/img/icon/"+activite.icon+".png"
					category: activite.categorie
					title: activite.nom

		GoogleMapApi.then (maps) ->
			$scope.centerPos = new maps.LatLng(43.507480, 2.822272)
			# Définis la hauteur du conteneur Gmap à la hauteur du block
			$(".angular-google-map-container").height($(".activites").height())

			$scope.activites.push
				latitude: $scope.map.center.latitude,
				longitude: $scope.map.center.longitude,
				title: 'Home'
				id: 0
				icon: "/img/icon/home.png"

			$log.log "gmap"
			$log.log(maps)

		angular.extend $scope, {
			map :
				control: {}
				markerControl: {}
				windowControl: {}
				center:
					latitude: 43.507480
					longitude: 2.822272
				zoom: 12
				event: {}
		}

		$scope.setOn = (id_marker)->
			markers =  $scope.map.markerControl.getGMarkers()
			marker = markers[arrayObjectIndexOf(markers, id_marker, "key")]
			# console.log $scope.map.windowControl.getChildWindows().get(id_marker)
			gMap = $scope.map.control.getGMap();
			gMap.setCenter(marker.position)
			return
		return



]