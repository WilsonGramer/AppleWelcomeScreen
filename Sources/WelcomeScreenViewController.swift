import UIKit

public class WelcomeScreenViewController: UIViewController {
    public var configuration: WelcomeScreenConfiguration

    public init(configuration: WelcomeScreenConfiguration) {
        self.configuration = configuration
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func loadView() {
        self.view = UIView()
        self.view.backgroundColor = .systemBackgroundCompat
        self.view.tintColor = self.configuration.tintColor

        let rootStackView = UIStackView()
        rootStackView.axis = .vertical
        rootStackView.spacing = 24
        rootStackView.alignment = .fill
        self.view.addSubview(rootStackView)
        rootStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.view.safeAreaLayoutGuide.centerXAnchor.constraint(equalTo: rootStackView.centerXAnchor),
            self.view.safeAreaLayoutGuide.centerYAnchor.constraint(equalTo: rootStackView.centerYAnchor),
            self.view.safeAreaLayoutGuide.widthAnchor.constraint(equalTo: rootStackView.widthAnchor, multiplier: 1.2),
            self.view.safeAreaLayoutGuide.heightAnchor.constraint(equalTo: rootStackView.heightAnchor, multiplier: 1.15),
        ])

        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        rootStackView.addArrangedSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        let scrollViewContent = UIStackView()
        scrollViewContent.axis = .vertical
        scrollViewContent.spacing = 24
        scrollView.addSubview(scrollViewContent)
        scrollViewContent.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollViewContent.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollViewContent.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollViewContent.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])

        let headingStackView = UIStackView()
        headingStackView.axis = .vertical
        headingStackView.spacing = 8
        scrollViewContent.addArrangedSubview(headingStackView)
        headingStackView.translatesAutoresizingMaskIntoConstraints = false

        let titleStackView = UIStackView()
        titleStackView.axis = .vertical
        titleStackView.spacing = 4
        titleStackView.isAccessibilityElement = true
        titleStackView.accessibilityLabel = self.configuration.welcomeAccessibilityLabel
        headingStackView.addArrangedSubview(titleStackView)
        titleStackView.translatesAutoresizingMaskIntoConstraints = false

        let welcomeLabel = UILabel()
        welcomeLabel.text = self.configuration.welcomeString
        welcomeLabel.font = .preferredFont(for: .largeTitle, weight: .bold)
        welcomeLabel.adjustsFontForContentSizeCategory = true
        welcomeLabel.textColor = .labelCompat
        titleStackView.addArrangedSubview(welcomeLabel)
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false

        let appNameLabel = UILabel()
        appNameLabel.text = self.configuration.appName
        appNameLabel.font = .preferredFont(for: .largeTitle, weight: .bold)
        appNameLabel.adjustsFontForContentSizeCategory = true
        appNameLabel.textColor = self.view.tintColor
        appNameLabel.numberOfLines = 0
        titleStackView.addArrangedSubview(appNameLabel)
        appNameLabel.translatesAutoresizingMaskIntoConstraints = false

        let appDescriptionLabel = UILabel()
        appDescriptionLabel.text = self.configuration.appDescription
        appDescriptionLabel.font = .preferredFont(for: .title3, weight: .semibold)
        appDescriptionLabel.adjustsFontForContentSizeCategory = true
        appDescriptionLabel.textColor = .secondaryLabelCompat
        appDescriptionLabel.numberOfLines = 0
        headingStackView.addArrangedSubview(appDescriptionLabel)
        appDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        let featuresStackView = UIStackView()
        featuresStackView.axis = .vertical
        featuresStackView.spacing = 18
        scrollViewContent.addArrangedSubview(featuresStackView)
        featuresStackView.translatesAutoresizingMaskIntoConstraints = false

        for feature in self.configuration.features {
            let featureView = FeatureView(for: feature)
            featuresStackView.addArrangedSubview(featureView)
            featureView.translatesAutoresizingMaskIntoConstraints = false
        }

        let continueButtonContainer = UIView()
        rootStackView.addArrangedSubview(continueButtonContainer)
        continueButtonContainer.translatesAutoresizingMaskIntoConstraints = false

        let continueButton = UIButton()
        continueButton.setTitle(self.configuration.continueButton.title, for: .normal)
        continueButton.setTitleColor(self.configuration.continueButton.titleColor, for: .normal)
        continueButton.addTarget(self, action: #selector(self.continueButtonTouchDown(_:)), for: .touchDown)
        continueButton.addTarget(self, action: #selector(self.continueButtonTouchUpOutside(_:)), for: .touchUpOutside)
        continueButton.addTarget(self, action: #selector(self.continueButtonTouchUpInside(_:)), for: .touchUpInside)
        continueButton.addTarget(self, action: #selector(self.continueButtonTouchCancel(_:)), for: .touchCancel)
        continueButton.clipsToBounds = true
        continueButton.layer.masksToBounds = true
        continueButton.layer.cornerRadius = 16
        continueButton.backgroundColor = self.view.tintColor
        continueButton.titleLabel!.font = .preferredFont(for: .body, weight: .semibold)
        continueButtonContainer.addSubview(continueButton)
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            continueButton.topAnchor.constraint(equalTo: continueButtonContainer.topAnchor),
            continueButton.bottomAnchor.constraint(equalTo: continueButtonContainer.bottomAnchor),
            continueButton.leadingAnchor.constraint(equalTo: continueButtonContainer.leadingAnchor),
            continueButton.trailingAnchor.constraint(equalTo: continueButtonContainer.trailingAnchor),
            continueButton.titleLabel!.topAnchor.constraint(equalTo: continueButton.topAnchor, constant: 16),
            continueButton.titleLabel!.bottomAnchor.constraint(equalTo: continueButton.bottomAnchor, constant: -16),
        ])
    }

    @objc private func continueButtonTouchDown(_ continueButton: UIButton) {
        UIView.animate(withDuration: 0.25) {
            continueButton.layer.opacity = 0.75
        }
    }

    @objc private func continueButtonTouchUpOutside(_ continueButton: UIButton) {
        self.resetContinueButton(continueButton)
    }

    @objc private func continueButtonTouchUpInside(_ continueButton: UIButton) {
        self.resetContinueButton(continueButton)
        self.dismiss(animated: true)
        self.configuration.continueButton.action?()
    }

    @objc private func continueButtonTouchCancel(_ continueButton: UIButton) {
        self.resetContinueButton(continueButton)
    }

    private func resetContinueButton(_ continueButton: UIButton) {
        UIView.animate(withDuration: 0.25) {
            continueButton.layer.opacity = 1.0
        }
    }
}

private class FeatureView: UIView {
    init(for feature: WelcomeScreenFeature) {
        super.init(frame: .zero)

        self.isAccessibilityElement = true
        self.accessibilityLabel = feature.accessibilityLabel

        let imageView = UIImageView()
        imageView.image = feature.image
        imageView.contentMode = .scaleAspectFit
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let size = UIFontMetrics.default.scaledValue(for: 48)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor),
            imageView.widthAnchor.constraint(equalToConstant: size),
            imageView.heightAnchor.constraint(greaterThanOrEqualToConstant: size),
        ])

        let titleLabel = UILabel()
        titleLabel.text = feature.title
        titleLabel.font = .preferredFont(for: .body, weight: .semibold)
        titleLabel.textColor = .labelCompat
        titleLabel.numberOfLines = 0
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)

        let descriptionLabel = UILabel()
        descriptionLabel.text = feature.description
        descriptionLabel.font = .preferredFont(for: .body, weight: .regular)
        descriptionLabel.textColor = .secondaryLabelCompat
        descriptionLabel.numberOfLines = 0
        self.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        descriptionLabel.setContentCompressionResistancePriority(.required, for: .vertical)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension UIColor {
    static var systemBackgroundCompat: UIColor {
        if #available(iOS 13.0, *) {
            return .systemBackground
        } else {
            return .white
        }
    }

    static var labelCompat: UIColor {
        if #available(iOS 13.0, *) {
            return .label
        } else {
            return .black
        }
    }

    static var secondaryLabelCompat: UIColor {
        if #available(iOS 13.0, *) {
            return .secondaryLabel
        } else {
            return .black
        }
    }
}

private extension UIFont {
    static func preferredFont(for style: TextStyle, weight: Weight) -> UIFont {
        let metrics = UIFontMetrics(forTextStyle: style)
        let desc = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style)
        let font = UIFont.systemFont(ofSize: desc.pointSize, weight: weight)
        return metrics.scaledFont(for: font)
    }
}
