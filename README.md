# Engine Yard Recipes

Tools to generate, upload, test and apply chef recipes for Engine Yard Cloud.

## Installation

    gem install engineyard-recipes

## Quick Guide

```
$ cd /path/to/my/app
$ ey-recipes init   # initial scaffolding for cookbooks
$ ey-recipes package somepackage
$ ey-recipes definition somehelpers specific_helper_method
$ git clone git://github.com/damm/ey-dnapi.git /tmp/recipes/ey-dnapi
$ ey-recipes clone /tmp/recipes/ey-dnapi

# then to upload and apply to your environment
$ ey recipes upload --apply
```

Alternately, you can have chef recipes run during deployment rather than by explicitly running them:

```
$ cd /path/to/my/app
$ ey-recipes init -d
$ ey-recipes package somepackage

# then deploy to apply recipes
$ ey deploy
```

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

$ ey recipes upload
$ ey recipes apply
```

The `-d` or `--on-deploy` flag will setup your application to run recipes during each deployment.

```
$ cd /path/to/my/app
$ ey-recipes init --on-deploy
    create  deploy/before_migrate.rb
    create  deploy/solo.rb
    create  deploy/cookbooks/main/attributes/recipe.rb
    create  deploy/cookbooks/main/definitions/ey_cloud_report.rb
    create  deploy/cookbooks/main/libraries/ruby_block.rb
    create  deploy/cookbooks/main/libraries/run_for_app.rb
    create  deploy/cookbooks/main/recipes/default.rb

$ ey deploy
```

Quickly generate recipes from git repositories or local folders. See bottom of README for community examples.

Either repos that describe a recipe such as [ey-dnapi](https://github.com/damm/ey-dnapi):

```
$ mkdir /tmp/recipes/
$ git clone git://github.com/damm/ey-dnapi.git /tmp/recipes/ey-dnapi
$ ey-recipes clone /tmp/recipes/ey-dnapi
```

Generate scaffolding for a package/service.

```
$ ey-recipes package newthing
    create  cookbooks/newthing/attributes/recipe.rb
    create  cookbooks/newthing/recipes/default.rb
    create  cookbooks/newthing/recipes/install.rb
    append  cookbooks/main/recipes/default.rb
```

Specify an explicit Gentoo package.

```
$ ey-recipes package gitosis -p dev-util/gitosis-gentoo -v 0.2_p20081028
$ ey-recipes package qt-webkit -p x11-libs/qt-webkit -v 4.4.2 -u
```

To use a masked package, pass the `--unmasked/-u` flag, and install the `emerge` helper described below.

Generate scaffolding for helper functions:

```
$ ey-recipes definition myhelpers some_helper
    create  cookbooks/mylibrary/definitions/helper1.rb
```

## Community recipe repos to clone

### Components

* mongodb [[repo](https://github.com/engineyard/ey-cloud-recipes/tree/master/cookbooks/mongodb)]

```
$ git clone https://github.com/engineyard/ey-cloud-recipes.git /tmp/recipes/ey-cloud-recipes
$ ey-recipes clone /tmp/recipes/ey-cloud-recipes/cookbooks/mongodb
```

* [elasticsearch](http://www.elasticsearch.org/)

```
$ git clone https://github.com/damm/ey-elasticsearch.git /tmp/recipes/ey-elasticsearch
$ ey-recipes clone /tmp/recipes/ey-elasticsearch -n elasticsearch
```

* [riak](http://basho.com/products/riak-overview/) [[repo](https://github.com/damm/ey-riak)]

```
$ git clone https://github.com/damm/ey-riak.git /tmp/recipes/ey-riak
$ ey-recipes clone /tmp/recipes/ey-riak -n riak
```

* [riaksearch](http://basho.com/products/riak-overview/) [[repo](https://github.com/damm/ey-riaksearch)]

Either use riak above or riaksearch, not both!

```
$ git clone https://github.com/damm/ey-riaksearch.git /tmp/recipes/ey-riaksearch
$ ey-recipes clone /tmp/recipes/ey-riaksearch -n riaksearch
```



### Environment Customizations

* database.yml [[repo](https://github.com/damm/ey-database)]

```
$ git clone https://github.com/damm/ey-database.git /tmp/recipes/ey-database
$ ey-recipes clone /tmp/recipes/ey-database
```

Also install ey-dnapi below.

### Helpers

* ey-emerge - additional helpers to install/use masked packages [[repo](https://github.com/damm/ey-emerge)]

```
$ git clone https://github.com/engineyard/ey-cloud-recipes.git /tmp/recipes/ey-cloud-recipes
$ ey-recipes clone /tmp/recipes/ey-cloud-recipes/cookbooks/emerge
```

* ey-dnapi - access the internal dna.json metadata via `node[:engineyard]` [[repo](https://github.com/damm/ey-dnapi)]

```
$ git clone https://github.com/damm/ey-dnapi.git /tmp/recipes/ey-dnapi
$ ey-recipes clone /tmp/recipes/ey-dnapi -n dnapi
```

## Development

### Tests

The tests are currently a suite of Cucumber tests that run the generators and assert that specific files are generated. It does not test the generated files/recipes against EY Cloud.

```
bundle exec rake # to run all non-WIP tests
bundle exec rake cucumber:wip # to run all WIP tests
```

### CI

See the latest [CI build results on Travis](http://travis-ci.org/#!/engineyard/engineyard-recipes "Travis CI - Distributed build platform for the open source community") (for ruby 1.8.7, 1.9.3, rbx and jruby)

From the command line:

```
bundle exec rake travis
```

[![Build Status](https://secure.travis-ci.org/engineyard/engineyard-recipes.png)](http://travis-ci.org/engineyard/engineyard-recipes) 

Not sure why its failing.

### Release

1. Push the changes to master. This triggers the CI build on TravisCI.
1. Wait for the build to complete successfully.1. Bump the VERSION number in `lib/engineyard-recipes/version.rb`
1. Update the ChangeLog.md file
1. Commit the changes
1. Release

```
bundle exec rake release
```
