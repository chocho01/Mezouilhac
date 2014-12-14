app = angular.module 'mezouilhac-backoffice', ['angularFileUpload', 'mezouilhac-directive']

app.controller "chaletCtrl", [
	"$scope"
	"$http"
	"FileUploader"
	($scope, $http, FileUploader) ->

		$scope.uploader = new FileUploader(
			url: '/admin/chalets/upload'
		)
		$scope.list_chalets = []

		$scope.uploader.onSuccessItem = (fileItem, response, status, headers) ->
			name = fileItem.file.name.substring(0, fileItem.file.name.length-4)+'-min'+fileItem.file.name.substring(fileItem.file.name.length-4)
			$scope.chalet.gallerie.push(name)


		$scope.init = ->
			$scope.message = null
			$scope.chalet =
				nom: null
				description: null
				capacite: null
				img_principale: null
				gallerie: []
				inventaire : []
				prix:
					haute:
						weekend: null
						semaine: null
					basse:
						weekend: null
						semaine: null

			$scope.action = 'add'

		$scope.init()

		$scope.definirImagePrincipale = (indexImg)->
			$scope.chalet.img_principale = $scope.chalet.gallerie[indexImg]

		$scope.supprimerImage = (indexImg)->
			$scope.chalet.gallerie.splice(indexImg, 1)

		$scope.addChalet = ->
			$http.post('/admin/chalets/add', $scope.chalet).success (d)->
				$scope.message = d
				if d.ok
					$scope.list_chalets.push $scope.chalet

		$scope.updateChalet = (id)->
			$http.post('/admin/chalets/update/'+$scope.chalet._id, $scope.chalet).success (d)->
				$scope.message = d
				$scope.list_chalets[$scope.getIndexInList($scope.chalet)] = $scope.chalet

		$scope.deleteChalet = (id)->
			$http.post('/admin/chalets/remove/'+$scope.chalet._id).success (d)->
				$scope.message = d
				$scope.list_chalets.splice($scope.getIndexInList($scope.chalet), 1)

		$scope.getChalet = (id)->
			$http.get('/api/chalets/'+id).success (d)->
				$scope.chalet = d
				$scope.message = null
				$scope.action = 'update'


		$http.get('/api/chalets').success (d)->
			$scope.list_chalets = d

		$scope.getIndexInList = (chalet)->
			i = 0
			while i <  $scope.list_chalets.length
				if $scope.list_chalets[i]['_id'] is chalet._id  then return i
				i++
			return -1

		$scope.removeItem = (list, item)->
			$scope.chalet.inventaire[list].item.splice(item, 1)

		$scope.updateItem = (list, index, item)->
			console.log(item)
			$scope.chalet.inventaire[list].item[index] = item

		$scope.addItem = (index)->
			$scope.chalet.inventaire[index].item.push(null)
			$scope.editingItem = null
			return

		$scope.addSection = ->
			$scope.chalet.inventaire.push {
				nom: "Section"
				item: []
			}
			return

		$scope.removeSection= (list)->
			$scope.chalet.inventaire.splice(list, 1)
]