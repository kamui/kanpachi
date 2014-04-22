# Kanpachi Changelog

## 0.0.7
* Update html5shiv to 3.7.1
* Make response compatible with representable 1.8.0

## 0.0.6
* Update bootstrap to 3.1.1
* Use bower to manage third party js libraries

## 0.0.5
* Lock `coercible` gem at `~> 1.0.0`

## 0.0.4
* Add support for middleman-deploy extension, just add middleman-deploy to your
Gemfile and then activate it in your doc/config.rb
* Move documentation directory to doc and move doc template into doc/template
* Default render_nils to true in all roar representers

## 0.0.3
* Wrap documentation footer in a container class to pad copyright
* Switch response roar representer to decorator. Prefer decorating objects
rather than mutating them with `#extend`.

## 0.0.2

* Add error codes and responses documentation page.
* Add ability to customize the middleman config for your project.
* Replace invalid url resource paths for documentation links.
* Fix naviation link paths.
* Remove About and Contact sections from the generated documentation navigation.

## 0.0.1

* First version.