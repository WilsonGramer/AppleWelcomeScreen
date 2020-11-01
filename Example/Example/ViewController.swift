import UIKit
import AppleWelcomeScreen

class ViewController: UIViewController {
    override func loadView() {
        self.view = UIView()
        self.view.backgroundColor = .systemBackground

        let button = UIButton(type: .system, primaryAction: UIAction { action in
            self.showWelcomeScreen()
        })
        button.setTitle("Show Welcome Screen", for: .normal)
        self.view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.showWelcomeScreen()
    }

    private func showWelcomeScreen() {
        self.present(WelcomeScreenViewController(configuration: .myApp), animated: true)
    }
}
