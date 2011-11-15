# Engine Yard Recipes

Tools to generate, upload, test and apply chef recipes for Engine Yard Cloud.

[![Build Status](https://secure.travis-ci.org/engineyard/engineyard-recipes.png)](http://travis-ci.org/engineyard/engineyard-recipes)

## Installation

    gem install engineyard-recipes
    
## Usage

Getting started:

```
$ cd /path/to/my/app
$ ey-recipes init
    create  cookbooks/main/attributes/recipe.rb
    create  cookbooks/main/definitions/ey_cloud_report.rb
    create  cookbooks/main/libraries/ruby_block.rb
    create  cookbooks/main/libraries/run_for_app.rb
    create  cookbooks/main/recipes/default.rb
```

Quickly generate recipes from git repositories or local folders.

Either repos that describe a recipe such as [ey-dnapi](https://github.com/damm/ey-dnapi):

```
$ git clone git://github.com/damm/ey-dnapi.git /tmp/ey-dnapi
$ ey-recipes clone /tmp/ey-dnapi
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
