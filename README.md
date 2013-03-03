Multi Domain Store
==================

This extension allows a single Spree instance to have several customer facing stores, with a single shared backend administration system (i.e. multi-store, single-vendor).

Current features:
------------------

1. **Store** model which has the following attributes:

    1.1 name - The display name for the store.

    1.2 domains - a line separated list of fully qualified domain names used to associate a customers session with a particular store (you can use localhost and/or IP addresses too).

    1.3 code - which is a abbreviated version of the store's name (used as the layout directory name, and also helpful for separating partials by store).

    1.4 default - one store should be marked a default as a fallback in case the URL being used to access the site cannot be matched against any of the configured stores.

2. Stores and domains can be maintained via the configuration section of the Admin interface

2. Each store can have it's own layout(s) - these layouts should be located in your site's theme extension in the app/views/layouts/_store#code_/ directory. So, if you have a store with
a code of "alpha" you should store it's default layout in app/views/layouts/alpha/spree_application.html.erb

3. Each product can be assigned to one or more stores.

4. All orders are associated with the store / domain that they were placed on.

5. Google analytics trackers can be associated with a store.

Install Instructions
--------------------

Add to your Gemfile:

```ruby
gem 'spree_multi_domain', git: 'git://github.com/spree/spree-multi-domain.git'
```

Then run `bundle`, and then run:

```
bundle exec rails g spree_multi_domain:install
```

You should see 'Stores & Domains' in Configuration tab of Spree Admin.

Features To-do
--------------

1. Taxonomies - associate stores with taxonomies.
