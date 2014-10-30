Gem::Specification.new do |spec|
  spec.name    = "form_interactor"
  spec.version = "0.1.0"

  spec.author      = "Icelab"
  spec.email       = "hello@icelab.com.au"
  spec.description = "Form classes."
  spec.summary     = "Form classes"
  spec.homepage    = "https://github.com/icelab/form_interactor"
  spec.license     = "MIT"

  spec.files      = Dir["README.md", "lib/**/*"]
  spec.test_files = spec.files.grep(/^spec/)

  spec.add_dependency "rails", ">= 3", "< 4.2"
  spec.add_dependency "interactor", "~> 3.0"
end
