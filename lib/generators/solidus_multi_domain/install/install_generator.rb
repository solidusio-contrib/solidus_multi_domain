# frozen_string_literal: true

module SolidusMultiDomain
  module Generators
    class InstallGenerator < Rails::Generators::Base
      class_option :auto_run_migrations, type: :boolean, default: false
      class_option :auto_copy_sample, type: :boolean, default: false
      class_option :specs, type: :string, enum: %w[all], hide: true

      source_root File.expand_path('templates', __dir__)

      def handle_solidus_sample_data
        return unless File.read('Gemfile').include?('solidus_sample')

        response = options[:auto_copy_sample] || ['', 'y',
                                                  'Y'].include?(ask("Do you want to load sample data files? (y/n)"))

        if response
          say "Copying sample data files..."
          directory("sample_data", "db/samples")
          say "Sample data files copied successfully."
        else
          say "Sample data files will not be copied."
        end
      end

      def generate_specs
        return unless options[:specs] == 'all'

        spec_path = engine.root.join('spec')

        if spec_path.directory?
          directory spec_path.to_s, 'spec'
        else
          say_status :error, "Spec directory not found: #{spec_path}", :red
        end
      end

      def add_migrations
        run 'bin/rails railties:install:migrations FROM=solidus_multi_domain'
      end

      def run_migrations
        run_migrations = options[:auto_run_migrations] || ['', 'y',
                                                           'Y'].include?(ask('Would you like to run the migrations now? [Y/n]'))
        if run_migrations
          run 'bin/rails db:migrate'
        else
          puts 'Skipping bin/rails db:migrate, don\'t forget to run it!' # rubocop:disable Rails/Output
        end
      end

      def engine
        SolidusMultiDomain::Engine
      end
    end
  end
end
