app = angular.module 'mezouilhac-directive', []

app.directive "editText", ['$parse' , ($parse)->
  restrict: "AE"
  replace: true
  require: '?ngModel'
  transclude: true,
  scope:
    item: '=ngModel'
    remove: '&onRemove'
    update: '&onChange'
  template:
    "<div class='edit-text' ng-class=\"{editing: editing}\">
        <div class=\"row\">
            <label class=\"item-name\">{{item}}</label>
            <div class=\"right floated compact ui mini icon buttons\">
              <div class=\"ui button\" ng-click=\"editItem()\"><i class=\"edit icon\"></i></div>
              <div class=\"ui button\" ng-click=\"remove()\"><i class=\"remove icon\"></i></div>
            </div>
        </div>
        <input type=\"text\"  placeholder=\"Nouvel item\" ng-model=\"item\"  ng-blur=\"editing = false\" />
		</div>"
  link: (scope, elem, attr, ngModel) ->
    if scope.item == null
      scope.editing = true
    else
      scope.editing = false

    scope.editItem = ->
      scope.editing = true

    scope.$watch "item", ->
      ngModel.$setViewValue scope.item
      scope.update()
      return

    return


]