Pod::Spec.new do |spec|

  spec.name         = "NSAttributedStringBuilder-jaeilers"
  spec.version      = "0.1.0"
  spec.summary      = "An easy to use attributed string builder with extended modifier support (bold, italic, image, custom spacings etc.)"

  spec.description  = <<-DESC
  The `NSAttributedStringBuilder` is an easy to use attributed string builder with extended modifier support (bold/italic, image, custom spacings etc.) that supports most platforms, can be extended easily and has accessibility support.
  DESC

  spec.homepage     = "https://github.com/jaeilers/NSAttributedStringBuilder"
  spec.license      = { :type => "MIT", :file => "LICENSE.md" }
  spec.author       = "Jasmin Eilers"

  spec.ios.deployment_target = "13.0"
  spec.osx.deployment_target = "11.0"
  spec.watchos.deployment_target = "6.0"
  spec.tvos.deployment_target = "13.0"

  spec.source       = { :git => "https://github.com/jaeilers/NSAttributedStringBuilder.git", :tag => "#{spec.version}" }

  spec.source_files  = "Sources", "Sources/**/*.{swift}"

  spec.swift_version = "5.8"

end
