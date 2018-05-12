#
# Be sure to run `pod lib lint AppleWelcomeScreen.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AppleWelcomeScreen'
  s.version          = '1.0'
  s.summary          = 'A super-simple welcome screen creator for iOS.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
AppleWelcomeScreen is a super-simple way to create a welcome screen/onboarding experience similar to the ones used in built-in iOS apps.
                       DESC

  s.homepage         = 'https://github.com/Wilsonator5000/AppleWelcomeScreen'
  s.screenshots      = 'https://raw.github.com/Wilsonator5000/AppleWelcomeScreen/master/readme-images/example-se.png', 'https://raw.github.com/Wilsonator5000/AppleWelcomeScreen/master/readme-images/example-x.png', 'https://raw.github.com/Wilsonator5000/AppleWelcomeScreen/master/readme-images/example-plus.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Wilsonator5000' => 'wgramer03@gmail.com' }
  s.source           = { :git => 'https://github.com/Wilsonator5000/AppleWelcomeScreen.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'

  s.source_files = 'AppleWelcomeScreen/Classes/**/*'
  
  # s.resource_bundles = {
  #   'AppleWelcomeScreen' => ['AppleWelcomeScreen/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  
  s.dependency 'SnapKit'
end
