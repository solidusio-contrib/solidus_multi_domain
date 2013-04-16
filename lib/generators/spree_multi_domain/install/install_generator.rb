module SpreeMultiDomain
  module Generators
    class InstallGenerator < Rails::Generators::Base

      def add_javascripts
        append_file "app/assets/javascripts/admin/all.js", "//= require admin/spree_multi_domain\n"
      end

      def add_migrations
        run 'rake railties:install:migrations FROM=spree_multi_domain'
      end

      def run_migrations
         res = ask "Would you like to run the migrations now? [Y/n]"
         if res == "" || res.downcase == "y"
           run 'rake db:migrate'
         else
           puts "Skiping rake db:migrate, don't forget to run it!"
         end
      end
    end
  end
end
