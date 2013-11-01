require "fpm"
require "rake"

module FPM; module Rake
  class RpmTask
    include ::Rake::DSL if defined? ::Rake::DSL

    class << self
      # set when install'd.
      attr_accessor :instance

      def install_tasks(opts = {})
        new(opts[:dir], opts[:name]).install
      end

      def gemspec(&block)
        gemspec = instance.gemspec
        block.call(gemspec) if block
        gemspec
      end
    end

    attr_reader :spec_path, :base, :gemspec

    def initialize(base = nil, name = nil)
      @base = (base ||= Dir.pwd)
      gemspecs = name ? [File.join(base, "#{name}.gemspec")]
                      : Dir[File.join(base, "{,*}.gemspec")]
      raise "Unable to determine name from existing gemspec. Use :name => 'gemname' in #install_tasks to manually set it." unless gemspecs.size == 1
      @spec_path = gemspecs.first
      @gemspec = Gem::Specification.load(@spec_path)
    end

    def install
      built_gem_path = nil

      namespace :rpm do
        desc "Build #{built_rpm_path} into the #{package_directory} directory."
        task 'build' do
          build_rpm
        end

        #desc "Build #{built_rpm_path} and install into system."
        #task 'install' => 'build' do
        #  install_gem(built_gem_path)
        #end

        #desc "Create tag #{version_tag} and build and push #{built_rpm_path} to Artifactory (or mrepo?)"
        #task 'release' => 'build' do
        #  release_gem(built_gem_path)
        #end
      end

      #desc "Test, build, release"
      # TODO determine if :test or other testing tasks exist
      #task 'my-lawn' => [:spec, :build, :'rpm:build', :'rpm:release']

      self.class.instance = self
    end

    def build_rpm
      gem = FPM::Package::Gem.new

      gem.attributes.merge!({
        :gem_gem => 'gem1.9',
        :gem_env_shebang? => false,
        :gem_package_name_prefix => package_name_prefix,
        :gem_fix_name? => true,
        :gem_bin_path => '/usr/bin',
        :prefix => '/usr/share/gem1.9',
      })

      gem.input(File.join(package_directory, built_gem_path))

      rpm = gem.convert(FPM::Package::RPM)
      # Aquire default attributes of RPM package. This works around a bug in fpm.
      # See https://github.com/jordansissel/fpm/pull/538
      # Otherwise the required attributes have no value at all.
      rpm.attributes = FPM::Package::RPM.new.attributes.merge(rpm.attributes)

      rpm.dependencies = %w( ruby19 rubygems19 )

      rpm.output(File.join(package_directory, rpm.to_s))
    end

    def built_gem_path
      # Used by bundler/gem_tasks
      "#{name}-#{version}.gem"
    end

    def built_rpm_path
      "#{package_name_prefix}-#{name}-#{version}.rpm"
    end

    def package_directory
      "pkg"
    end

    def package_name_prefix
      # Follow the CentOS/Amazon Linux RPM package naming convention.
      'rubygems19'
    end

    def name
      gemspec.name
    end

    def version
      gemspec.version
    end

  end
end; end
