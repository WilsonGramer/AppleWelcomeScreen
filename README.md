# AppleWelcomeScreen

![logo](readme-images/logo.png)

[![Version](https://img.shields.io/cocoapods/v/AppleWelcomeScreen.svg?style=flat)](https://cocoapods.org/pods/AppleWelcomeScreen)
[![License](https://img.shields.io/cocoapods/l/AppleWelcomeScreen.svg?style=flat)](https://cocoapods.org/pods/AppleWelcomeScreen)
[![Platform](https://img.shields.io/cocoapods/p/AppleWelcomeScreen.svg?style=flat)](https://cocoapods.org/pods/AppleWelcomeScreen)

AppleWelcomeScreen is a super-simple way to create a welcome screen/onboarding experience similar to the ones used in built-in iOS apps. For example, here's the Notes welcome screen recreated using AppleWelcomeScreen:

| iPhone SE | iPhone X | iPhone 8 Plus |
| --- | --- | --- |
| ![example-se.png](readme-images/example-se.png) | ![example-x.png](readme-images/example-x.png) | ![example-plus.png](readme-images/example-plus.png) |

## Usage

Provide a configuration and you're good to go:

```swift
let configuration = WelcomeScreenConfiguration(
    appName: "My App",
    appDescription: "Lorem ipsum dolor sit amet, consecteteur adipiscing elit.",
    features: [
        WelcomeScreenFeature(
            image: UIImage(systemName: "circle.fill")!,
            title: "Lorem ipsum",
            description: "Lorem ipsum dolor sit amet."
        ),
        WelcomeScreenFeature(
            image: UIImage(systemName: "square.fill")!,
            title: "Dolor sit amet",
            description: "Consecteteur adipiscing elit, sed do euismod tempor incdidunt."
        ),
        WelcomeScreenFeature(
            image: UIImage(systemName: "triangle.fill")!,
            title: "Consecteteur adipiscing elit, sed do euismod tempor incdidunt",
            description: "Lorem ipsum dolor sit amet, consecteteur adipiscing elit, sed do euismod tempor incdidunt ut labore et dolore magna aliqua."
        ),
    ]
)

// In your view controller:
self.present(WelcomeScreenViewController(configuration: configuration), animated: true)

// Or in SwiftUI:
MyView().sheet(isPresented: self.$showWelcomeScreen) {
    WelcomeScreen(configuration: configuration)
}
```

## Example

To run the example project, clone the repo and open `Example/Example.xcodeproj`.

## Installation

CocoaPods:

```ruby
pod 'AppleWelcomeScreen'
```

Swift Package Manager:

```swift
.package(url: "https://github.com/WilsonGramer/AppleWelcomeScreen.git", from: "2.1.0")
```

## Contributing

AppleWelcomeScreen encourages contributions! [Create an issue](https://github.com/WilsonGramer/AppleWelcomeScreen/issues/new) or submit a pull request.
