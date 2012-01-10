# ChangeLog

## v0.3.pre

* `--local` (clone, recipes, definitions) - generates into local path instead of cookbooks/ subfolder; useful for developing dedicated recipe repositories instead of an entire cookbook; ignores cookbooks/main/recipes/default.rb

## v0.2

Timezones & SM Extensions

* `timezone` - set the required timezone for instances
* `sm` - use SM extensions (wrapped in chef recipes)
* `init --sm` & `init-sm` - setup to use SM extensions (required for `sm`)

## v0.1

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
