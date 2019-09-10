Multi Domain Store
==================

[![CircleCI](https://circleci.com/gh/solidusio-contrib/solidus_multi_domain.svg?style=svg)](https://circleci.com/gh/solidusio-contrib/solidus_multi_domain)

This extension allows a single Solidus instance to have several customer facing
stores, with a single shared backend administration system (i.e. multi-store,
single-vendor).

Current features:
------------------

1. **Store** model which has the following attributes:

    1.1 name - The display name for the store.

    1.2 domains - a line separated list of fully qualified domain names used to
    associate a customers session with a particular store (you can use
    localhost and/or IP addresses too).

    1.3 code - which is a abbreviated version of the store's name (used as the
    layout directory name, and also helpful for separating partials by store).

    1.4 default - one store should be marked a default as a fallback in case
    the URL being used to access the site cannot be matched against any of the
    configured stores.

2. Stores and domains can be maintained via the configuration section of the
   Admin interface

2. Each store can have its own layout(s) - these layouts should be located in
   your site's theme extension in the
   app/views/spree/layouts/_store#code_/directory. So, if you have a store
   with a code of "alpha" you should store its default layout in
   app/views/spree/layouts/alpha/spree_application.html.erb

3. Each product can be assigned to one or more stores.

4. All orders are associated with the store / domain that they were placed on.

Looking for additional information? Checkout out the [wiki](https://github.com/solidusio/solidus_multi_domain/wiki).

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

You should see 'Stores & Domains' in Configuration tab of Spree Admin.

Development
-------

To see if your stores indeed do point to the correct and unique domains, start your server with
```shell
rails s -p 3000 -b lvh.me
```
and give a store a domain like `store1.lvh.me`.

Then you can access to your store by going to `http://store1.lvh.me:3000/` in your browser.

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
