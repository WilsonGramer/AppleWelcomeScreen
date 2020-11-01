import UIKit
import AppleWelcomeScreen

extension WelcomeScreenConfiguration {
    static var myApp: WelcomeScreenConfiguration {
        WelcomeScreenConfiguration(
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
    }
}
