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
  s.summary          = 'A short description of AssertRequest.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/lucas1295santos/AssertRequest'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lucas1295santos' => 'lucas1295santos@gmail.com' }
  s.source           = { :git => 'https://github.com/lucas1295santos/AssertRequest.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'AssertRequest/Classes/**/*'
  
  # s.resource_bundles = {
  #   'AssertRequest' => ['AssertRequest/Assets/*.png']
  # }

  s.xcconfig = { 'FRAMEWORK_SEARCH_PATHS' => '$(inherited) $(PROJECT_DIR) $(PLATFORM_DIR)/Developer/Library/Frameworks' }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
