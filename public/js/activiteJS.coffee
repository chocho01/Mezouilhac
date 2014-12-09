$(".activites").height($(window).height() - ($(window).height()/3.5))
$(".list-activites").height($(window).height() - ($(window).height()/4))

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
					position:
						latitude: activite.position.latitude
						longitude: activite.position.longitude
					id: activite._id
					icon: "img/icon/"+activite.icon+"_marker.png"
					url: activite.url
					img: "/img/icon/"+activite.icon+".png"
					category: activite.categorie
					title: activite.nom
					adresse: activite.adresse
					description : activite.description
					showWindow: false
					windowOptions:
						visible:false

		GoogleMapApi.then (maps) ->
			$scope.centerPos = new maps.LatLng(43.507480, 2.822272)
			# Définis la hauteur du conteneur Gmap à la hauteur du block
			$(".angular-google-map-container").height($(".activites").height())

			$scope.setOn = (id_marker)->
				angular.forEach $scope.activites, (marker)->
					marker.showWindow = false
					if marker.id == id_marker
						marker.windowOptions =
							visible: !marker.windowOptions.visible
					else
						marker.windowOptions =
							visible: false
				return

			$scope.activites.push
				position:
					latitude: $scope.map.center.latitude,
					longitude: $scope.map.center.longitude,
				title: 'Home'
				id: 0
				icon: "/img/icon/home.png"
				img: "/img/icon/home.png"
				title: "Mezouilhac"
				category: "Le gîte"
				adresse: "Riols, 34220"
				description: "Bienvenue à Mezouilhac !"
				windowOptions:
					visible:false


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


		return



]