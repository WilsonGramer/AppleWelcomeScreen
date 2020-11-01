import UIKit

public struct WelcomeScreenConfiguration {
    public var appName: String
    public var appDescription: String
    public var features: [WelcomeScreenFeature]
    public var continueButton: ContinueButtonConfiguration
    public var tintColor: UIColor?

    public init(appName: String, appDescription: String, features: [WelcomeScreenFeature], continueButton: ContinueButtonConfiguration = .init(), tintColor: UIColor? = nil) {
        self.appName = appName
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

    public init(image: UIImage, title: String, description: String) {
        self.image = image
        self.title = title
        self.description = description
    }
}

public struct ContinueButtonConfiguration {
    public var title: String
    public var titleColor: UIColor
    public var action: (WelcomeScreenViewController) -> Void

    public init(title: String = "Continue", titleColor: UIColor = .white, action: @escaping (WelcomeScreenViewController) -> Void = { $0.dismiss(animated: true) }) {
        self.title = title
        self.titleColor = titleColor
        self.action = action
    }
}
