import Foundation
import UIKit

public struct WelcomeScreenConfiguration {
    public var welcomeString: String
    public var appName: String
    public var welcomeAccessibilityLabel: String
    public var appDescription: String
    public var features: [WelcomeScreenFeature]
    public var continueButton: ContinueButtonConfiguration
    public var tintColor: UIColor?

    public init(welcomeString: String = NSLocalizedString("Welcome to", comment: "Welcome screen 'Welcome' string"), appName: String, welcomeAccessibilityLabel: String? = nil, appDescription: String, features: [WelcomeScreenFeature], continueButton: ContinueButtonConfiguration = .init(), tintColor: UIColor? = nil) {
        self.welcomeString = welcomeString
        self.appName = appName
        self.welcomeAccessibilityLabel = welcomeAccessibilityLabel ?? NSLocalizedString("\(welcomeString) \(appName)", comment: "Welcome screen accessibility label")
        self.appDescription = appDescription
        self.features = features
        self.continueButton = continueButton
        self.tintColor = tintColor
    }
}

public struct WelcomeScreenFeature {
    public var image: UIImage
    public var title: String
    public var description: String
    public var accessibilityLabel: String

    public init(image: UIImage, title: String, description: String, accessibilityLabel: String? = nil) {
        self.image = image
        self.title = title
        self.description = description
        self.accessibilityLabel = NSLocalizedString("\(title): \(description)", comment: "Welcome screen feature")
    }
}

public struct ContinueButtonConfiguration {
    public var title: String
    public var titleColor: UIColor
    public var action: (() -> Void)?

    public init(title: String = NSLocalizedString("Continue", comment: "Welcome screen continue button"), titleColor: UIColor = .white, action: (() -> Void)? = nil) {
        self.title = title
        self.titleColor = titleColor
        self.action = action
    }
}
