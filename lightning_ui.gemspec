require_relative "lib/lightning_ui/version"

Gem::Specification.new do |spec|
  spec.name = "lightning_ui"
  spec.version = LightningUi::VERSION
  spec.authors = ["Alex Koval"]
  spec.email = ["al3xander.koval@gmail.com"]
  spec.homepage = "https://github.com/k0va1/lightning_ui"
  spec.summary = "Lightning UI is a collection of UI components for Rails applications"
  spec.description = "Lightning UI is a collection of UI components for Rails applications"
  spec.license = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/k0va1/lightning_ui"
  spec.metadata["changelog_uri"] = "https://github.com/k0va1/lightning_ui/blob/main/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib,public,vendor}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 8.0.0"
  spec.add_dependency "view_component"
  spec.add_dependency "tailwind_merge"
  spec.add_dependency "heroicons"

  spec.add_development_dependency "standard"
end
