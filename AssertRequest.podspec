#
# Be sure to run `pod lib lint AssertRequest.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AssertRequest'
  s.version          = '0.1.0'
  s.summary          = 'Assert Request allows you to assert that your app is making the correct network request in a given situation, without any setup.'

  s.description      = <<-DESC
  Assert Request allows you to assert that your app is making the correct network request in a given situation, without any setup.
  This framework works like a snapshot test. First, you run it on record mode, so every request made during test time is stored on disk. Later, when you disable recording, the framework will assert that matching requests will be made for that same test case.
  During test time, no requests will be actually made to the web.
                       DESC

  s.homepage         = 'https://github.com/lucas1295santos/AssertRequest'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lucas1295santos' => 'lucas1295santos@gmail.com' }
  s.source           = { :git => 'https://github.com/lucas1295santos/AssertRequest.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/oliveira__lucas'

  s.ios.deployment_target = '10.0'
  s.swift_version = '5.0'

  s.source_files = 'AssertRequest/Classes/**/*'
  
  # s.resource_bundles = {
  #   'AssertRequest' => ['AssertRequest/Assets/*.png']
  # }

  s.xcconfig = { 'FRAMEWORK_SEARCH_PATHS' => '$(inherited) $(PROJECT_DIR) $(PLATFORM_DIR)/Developer/Library/Frameworks' }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
