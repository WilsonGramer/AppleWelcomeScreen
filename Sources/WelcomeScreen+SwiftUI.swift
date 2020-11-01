import SwiftUI

public struct WelcomeScreen: UIViewControllerRepresentable {
    public let configuration: WelcomeScreenConfiguration

    public init(configuration: WelcomeScreenConfiguration) {
        self.configuration = configuration
    }

    public func makeUIViewController(context: Context) -> WelcomeScreenViewController {
        WelcomeScreenViewController(configuration: self.configuration)
    }

    public func updateUIViewController(_ uiViewController: WelcomeScreenViewController, context: Context) {}
}
