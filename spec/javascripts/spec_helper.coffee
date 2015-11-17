#= require support/bind-poly
#= require application
#= require angular-mocks/angular-mocks
beforeEach ->
  jasmine.addMatchers toEqualData: (util, customEqualityTesters) ->
    {
      compare: (actual, expected) ->
        result = {}
        result.pass = angular.equals(actual, expected)
        result
    }