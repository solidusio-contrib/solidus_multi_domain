Multi Domain Store
==================

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

5. Google analytics trackers can be associated with a store.

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

Authorization
-------------

For discrete authorization, two permission sets have been added to allow for granular display in the admin.

`Spree::PermissionSets::StoreDisplay` and `Spree::PermissionSets::StoreManagement` have been added and can be assigned via [RoleConfiguration](http://docs.solidus.io/Spree/RoleConfiguration.html)

Persisting the current_spree_user across vendors
--------------------

If you would like the current_spree_user to persist across subdomains, change this line in `config/initializers/session_store.rb`:

```ruby
 Rails.application.config.session_store :cookie_store, key: '_your_app_session', domain: :all, tld_length: 2
```
Furthermore, to persist the cart across subdomains and to add items smoothly, there is a little more work you have to do.  The cart/checkout does accept multiple vendor items at once out of the box, but you will encounter problems of it a) not persisting the cart across subdomains correctly and b) raising an error once you do persist it correctly. 

To overcome the first problem, you need to override the default behavior for setting the `guest_token`. Create a file under `app/helpers/spree/auth_decorator.rb`:
```ruby
Spree::Core::ControllerHelpers::Auth.class_eval do
  def set_guest_token
    unless cookies.signed[:guest_token].present?
      cookies.permanent.signed[:guest_token] = {
        value: SecureRandom.urlsafe_base64(nil, false),
        domain: :all,
        tld_length: 2
      }
    end
  end
end
```
This change makes it so all the domains are under the same `guest_token` cookies, instead of having unique `guest_token` cookies for each.

The second change requires patching how the order params are set in `order.rb`. Under `app/helpers/spree/order_decorator.rb`, patch it with the following:
```ruby
Spree::Core::ControllerHelpers::Order.class_eval do
  def current_order_params
    { currency: current_currency, guest_token: cookies.signed[:guest_token], user_id: try_spree_current_user.try(:id) }
  end
end
```
This change prevents the cart from only including items specific to a subdomain/store. You will also need to comment out 
```ruby
raise ProductDoesNotBelongToStoreError if order.store.present? && !product.stores.include?(order.store)
```
in `app/models/spree_multi_domain/line_item_concerns.rb` in order to add items without raising this error.


Testing
-------

Then just run the following to automatically build a dummy app if necessary and
run the tests:

```shell
bundle exec rake
```
