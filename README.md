# Engine Yard Recipes

Tools to generate, upload, test and apply chef recipes for Engine Yard Cloud.

[![Build Status](https://secure.travis-ci.org/engineyard/engineyard-recipes.png)](http://travis-ci.org/engineyard/engineyard-recipes)

## Usage

Getting started:

```
$ cd /path/to/my/app
$ ey-recipes init
  cookbooks/main/attributes/default.rb
  cookbooks/main/recipes/default.rb
```

Quickly generate recipes from git repositories.

Either repos that describe a recipe such as [ey-dnapi](https://github.com/damm/ey-dnapi):

```
$ ey-recipes clone git://github.com/damm/ey-dnapi.git
```

Or repos that contain multiple recipes, such as [ey-cloud-recipes](https://github.com/engineyard/ey-cloud-recipes/tree/master/cookbooks/):

```
$ ey-recipes clone git://github.com/engineyard/ey-cloud-recipes.git --path cookbooks/emerge
```

Generate scaffolding for a package/service.

```
$ ey-recipes recipe newthing
    create  cookbooks/newthing/attributes/recipe.rb
    create  cookbooks/newthing/recipes/default.rb
    create  cookbooks/newthing/recipes/install.rb
    append  cookbooks/main/recipes/default.rb
```

Generate scaffolding for helper functions:

```
$ ey-recipes definition myhelpers some_helper
    create  cookbooks/mylibrary/definitions/helper1.rb
```
