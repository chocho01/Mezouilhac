(function() {
  var app;

  app = angular.module('mezouilhac-backoffice', ['angularFileUpload', 'mezouilhac-directive']);

  app.controller("chaletCtrl", [
    "$scope", "$http", "FileUploader", function($scope, $http, FileUploader) {
      $scope.uploader = new FileUploader({
        url: '/admin/chalets/upload'
      });
      $scope.list_chalets = [];
      $scope.uploader.onSuccessItem = function(fileItem, response, status, headers) {
        var name;
        name = fileItem.file.name.substring(0, fileItem.file.name.length - 4) + '-min' + fileItem.file.name.substring(fileItem.file.name.length - 4);
        return $scope.chalet.gallerie.push(name);
      };
      $scope.init = function() {
        $scope.message = null;
        $scope.chalet = {
          nom: null,
          description: null,
          capacite: null,
          img_principale: null,
          gallerie: [],
          inventaire: [],
          prix: {
            haute: {
              weekend: null,
              semaine: null
            },
            basse: {
              weekend: null,
              semaine: null
            }
          }
        };
        return $scope.action = 'add';
      };
      $scope.init();
      $scope.definirImagePrincipale = function(indexImg) {
        return $scope.chalet.img_principale = $scope.chalet.gallerie[indexImg];
      };
      $scope.supprimerImage = function(indexImg) {
        return $scope.chalet.gallerie.splice(indexImg, 1);
      };
      $scope.addChalet = function() {
        return $http.post('/admin/chalets/add', $scope.chalet).success(function(d) {
          $scope.message = d;
          if (d.ok) {
            return $scope.list_chalets.push($scope.chalet);
          }
        });
      };
      $scope.updateChalet = function(id) {
        return $http.post('/admin/chalets/update/' + $scope.chalet._id, $scope.chalet).success(function(d) {
          $scope.message = d;
          return $scope.list_chalets[$scope.getIndexInList($scope.chalet)] = $scope.chalet;
        });
      };
      $scope.deleteChalet = function(id) {
        return $http.post('/admin/chalets/remove/' + $scope.chalet._id).success(function(d) {
          $scope.message = d;
          return $scope.list_chalets.splice($scope.getIndexInList($scope.chalet), 1);
        });
      };
      $scope.getChalet = function(id) {
        return $http.get('/api/chalets/' + id).success(function(d) {
          $scope.chalet = d;
          $scope.message = null;
          return $scope.action = 'update';
        });
      };
      $http.get('/api/chalets').success(function(d) {
        return $scope.list_chalets = d;
      });
      $scope.getIndexInList = function(chalet) {
        var i;
        i = 0;
        while (i < $scope.list_chalets.length) {
          if ($scope.list_chalets[i]['_id'] === chalet._id) {
            return i;
          }
          i++;
        }
        return -1;
      };
      $scope.removeItem = function(list, item) {
        return $scope.chalet.inventaire[list].item.splice(item, 1);
      };
      $scope.updateItem = function(list, index, item) {
        console.log(item);
        return $scope.chalet.inventaire[list].item[index] = item;
      };
      $scope.addItem = function(index) {
        $scope.chalet.inventaire[index].item.push(null);
        $scope.editingItem = null;
      };
      $scope.addSection = function() {
        $scope.chalet.inventaire.push({
          nom: "Section",
          item: []
        });
      };
      return $scope.removeSection = function(list) {
        return $scope.chalet.inventaire.splice(list, 1);
      };
    }
  ]);

}).call(this);

//# sourceMappingURL=admin_chalets.js.map
