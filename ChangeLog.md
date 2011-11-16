# ChangeLog

## v0.1.0

Initial set of commands:

* `clone` - install a recipe from a local path
* `recipe` - generate a scaffold for a new recipe
* `definition` - generate a scaffold for a helper definition

Patches:

### v0.1.1

* `clone` - When cloning a recipe folder, don't insert require_recipe if the folder doesn't have a recipe folder

### v0.1.2

* `recipe` - can take --package/--version/--unmasked options

### v0.1.3

* `recipe` - if a package isn't specified then comment out the attributes/recipe.rb code as example only
