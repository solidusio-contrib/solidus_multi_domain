Multi Domain Store
==================

This extension adds some additional functionality to Solidus's existing store model.

[![Build Status](https://travis-ci.org/solidusio/solidus_multi_domain.svg?branch=master)](https://travis-ci.org/solidusio/solidus_multi_domain)

Current features:
------------------

1. Each store can have its own layout(s) - these layouts should be located in
   your site's theme extension in the
   app/views/spree/layouts/_store#code_/directory. So, if you have a store
   with a code of "alpha" you should store its default layout in
   app/views/spree/layouts/alpha/spree_application.html.erb

2. Each product can be assigned to one or more stores.

Install Instructions
--------------------

Add to your Gemfile:

```ruby
gem "solidus_multi_domain"
```

Then run from the command line:

```shell
bundle install
rails g solidus_multi_domain:install
```

Development
-------

To see if your stores indeed do point to the correct and unique domains, start your server with
```shell
rails s -p 3000 -b lvh.me
```
and give a store a domain like http://store1.lvh.me:3000/.

If you'd like access to Solidus factories for your own tests that work well
with this extension, add the following to your `spec_helper`:
```ruby
require "spree_multi_domain/testing_support/factory_overrides"
```

Authorization
-------------

For discrete authorization, two permission sets have been added to allow for granular display in the admin.

`Spree::PermissionSets::StoreDisplay` and `Spree::PermissionSets::StoreManagement` have been added and can be assigned via [RoleConfiguration](http://docs.solidus.io/Spree/RoleConfiguration.html)


Testing
-------

Then just run the following to automatically build a dummy app if necessary and
run the tests:

```shell
bundle exec rake
```
