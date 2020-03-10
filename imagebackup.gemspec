require_relative 'lib/imagebackup/version'

Gem::Specification.new do |spec|
  spec.name          = "imagebackup"
  spec.version       = Imagebackup::VERSION
  spec.authors       = ["adrian-sal-kennedy"]
  spec.email         = ["adrian.sal.kennedy@gmail.com"]

  spec.summary       = %q{A simple CLI app to backup all pics and vids from current folder to a destination in yyyy-mm-dd folders.}
  spec.description   = %q{Uses Exiv2 and ffprobe to find creation dates for media types it finds.}
  spec.homepage      = "https://github.com/adrian-sal-kennedy/imagebackup"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  # spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'exiv2' 'ffmpeg-video-info'
end
