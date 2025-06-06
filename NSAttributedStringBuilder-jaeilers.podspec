Pod::Spec.new do |spec|

  spec.name         = "NSAttributedStringBuilder-jaeilers"
  spec.module_name  = "NSAttributedStringBuilder"
  spec.version      = "0.4.0"
  spec.summary      = "An easy to use NSAttributedString builder with extended modifier support (bold, italic, image, custom spacings etc.)"

  spec.description  = <<-DESC
  The `NSAttributedStringBuilder` is an easy to use attributed string builder with extended modifier support (bold/italic, image, custom spacings etc.) that supports most platforms and can be extended easily.
  DESC

  spec.homepage     = "https://github.com/jaeilers/NSAttributedStringBuilder"
  spec.license      = { :type => "MIT", :file => "LICENSE.md" }
  spec.author       = "Jasmin Eilers"

  spec.ios.deployment_target = "13.0"
  spec.osx.deployment_target = "11.0"
  spec.watchos.deployment_target = "6.0"
  spec.tvos.deployment_target = "13.0"

  spec.source       = { :git => "https://github.com/jaeilers/NSAttributedStringBuilder.git", :tag => "#{spec.version}" }

  spec.source_files  = "Sources/**/*.swift"

  spec.resource_bundle = {
    "NSAttributedStringBuilder-jaeilers" => ["Sources/NSAttributedStringBuilder/PrivacyInfo.xcprivacy"]
  }

  spec.swift_version = "5.8"

end
