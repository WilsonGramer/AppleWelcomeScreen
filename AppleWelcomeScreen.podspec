Pod::Spec.new do |s|
  s.name             = 'AppleWelcomeScreen'
  s.version          = '2.1.0'
  s.summary          = 'A super-simple welcome screen creator for iOS.'
  s.swift_version    = '5.2'
  s.description      = 'AppleWelcomeScreen is a super-simple way to create a welcome screen/onboarding experience similar to the ones used in built-in iOS apps.'
  s.homepage         = 'https://github.com/Wilsonator5000/AppleWelcomeScreen'
  s.screenshots      = 'https://raw.github.com/Wilsonator5000/AppleWelcomeScreen/master/readme-images/example-se.png', 'https://raw.github.com/Wilsonator5000/AppleWelcomeScreen/master/readme-images/example-x.png', 'https://raw.github.com/Wilsonator5000/AppleWelcomeScreen/master/readme-images/example-plus.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Wilson Gramer' => 'wilson@gramer.dev' }
  s.source           = { :git => 'https://github.com/WilsonGramer/AppleWelcomeScreen.git', :tag => s.version.to_s }
  s.ios.deployment_target = '11.0'
  s.source_files = 'Sources/**/*'
  s.frameworks = 'UIKit'
end
