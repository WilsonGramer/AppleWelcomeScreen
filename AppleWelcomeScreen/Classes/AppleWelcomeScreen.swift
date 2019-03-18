import Foundation
import UIKit

/// An item to be displayed in the welcome screen, used to show off a feature of your app.
public struct AWSItem {

    /// The icon of the item. This will appear on the left side of the item.
    public var image: UIImage!

    /// The title of the feature.
    public var title: String!

    /// More information about the feature, displayed under the title.
    public var description: String!

    public init() {
    }
}

/// Use this to manage the configuration options of the welcome screen.
public struct AWSConfigOptions {

    /// The name of your app. This will be shown (by default) as "Welcome to \<appName\>".
    public var appName: String = ""

    /// The description of your app. This will be shown under the app name.
    public var appDescription: String = ""

    /// The items that will appear on the welcome screen. Create and configure them using instances of `AWSItem`.
    public var items: [AWSItem] = []

    /// The text of the "Continue" button that appears at the bottom of the screen. By default this is set to `"Continue"`.
    public var continueButtonText: String = "Continue"

    /// The closure to be executed when the "Continue" button is pressed.
    public var continueButtonAction: (() -> ())?

    /// The tint of the welcome screen. This color will be reflected in the color of the app name and the "Continue" button.
    public var tintColor: UIColor = .blue

    public init() {
    }
}

fileprivate let awsTextColor = UIColor(white: 0.075, alpha: 1.0)

/// The view controller that displayes the welcome screen.
public class AWSViewController: UIViewController {

    /// The configuration for the welcome screen to use.
    public var configuration: AWSConfigOptions!

    private var itemsTableViewManager: AWSItemsTableViewManager!

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let welcomeToLabel = UILabel()
    private let appNameLabel = UILabel()
    private let appDescriptionLabel = UILabel()
    private let itemsTableView = AWSIntrinsicTableView()
    private let continueButton = AWSFilledButton()

    private var marginSize: CGFloat = 0

    override public func viewDidLoad() {
        super.viewDidLoad()

        // === Initialization === //

        assert((self.configuration != nil), "Please provide a configuration for the welcome screen to use.")

        self.title = "Welcome to \(self.configuration.appName)"
        self.view.backgroundColor = .white

        self.itemsTableViewManager = AWSItemsTableViewManager()
        self.itemsTableViewManager.items = self.configuration.items

        self.marginSize = self.getMarginSize()

        // === Construct the view === //

        // Add the views
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.contentView)
        self.contentView.addSubview(self.welcomeToLabel)
        self.contentView.addSubview(self.appNameLabel)
        self.contentView.addSubview(self.appDescriptionLabel)
        self.contentView.addSubview(self.itemsTableView)
        self.view.addSubview(self.continueButton)

        // Scroll view
        self.scrollView.alwaysBounceVertical = true

        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        let scrollViewTop = NSLayoutConstraint(item: self.scrollView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .topMargin, multiplier: 1, constant: 0)
        let scrollViewBottom = NSLayoutConstraint(item: self.scrollView, attribute: .bottom, relatedBy: .equal, toItem: continueButton, attribute: .top, multiplier: 1, constant: -20)
        let scrollViewLeft = NSLayoutConstraint(item: self.scrollView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .leftMargin, multiplier: 1, constant: self.marginSize)
        let scrollViewRight = NSLayoutConstraint(item: self.scrollView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .rightMargin, multiplier: 1, constant: -self.marginSize)
        NSLayoutConstraint.activate([scrollViewTop, scrollViewBottom, scrollViewLeft, scrollViewRight])
        self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollView.frame.height)


        // Content view
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        let attributes: [NSLayoutConstraint.Attribute] = [.top, .bottom, .right, .left]
        NSLayoutConstraint.activate(attributes.map {
            NSLayoutConstraint(item: self.contentView, attribute: $0, relatedBy: .equal, toItem: self.contentView.superview, attribute: $0, multiplier: 1, constant: 0)
        })

        // "Welcome to" label
        self.welcomeToLabel.text = "Welcome to"
        self.welcomeToLabel.textColor = .darkText
        self.welcomeToLabel.font = UIFont.systemFont(ofSize: self.getHeaderFontSize(), weight: .heavy)
        self.welcomeToLabel.adjustsFontSizeToFitWidth = true


        self.welcomeToLabel.translatesAutoresizingMaskIntoConstraints = false
        let welcomeTop = NSLayoutConstraint(item: self.welcomeToLabel, attribute: .top, relatedBy: .equal, toItem: self.contentView, attribute: .topMargin, multiplier: 1, constant: self.getHeaderFontSize() - 8)
        let welcomeLeft = NSLayoutConstraint(item: self.welcomeToLabel, attribute: .left, relatedBy: .equal, toItem: self.contentView, attribute: .leftMargin, multiplier: 1, constant: 0)
        let welcomeRight = NSLayoutConstraint(item: self.welcomeToLabel, attribute: .right, relatedBy: .equal, toItem: self.contentView, attribute: .rightMargin, multiplier: 1, constant: 0)
        let welcomeHeight = NSLayoutConstraint(item: self.welcomeToLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: self.getHeaderFontSize() + 4)
        NSLayoutConstraint.activate([welcomeTop, welcomeLeft, welcomeRight, welcomeHeight])

        // App Name label
        self.appNameLabel.text = self.configuration.appName
        self.appNameLabel.font = UIFont.systemFont(ofSize: self.getHeaderFontSize(), weight: .heavy)
        self.appNameLabel.adjustsFontSizeToFitWidth = true
        self.appNameLabel.textColor = self.configuration.tintColor

        self.appNameLabel.translatesAutoresizingMaskIntoConstraints = false
        let appNameLabelTop = NSLayoutConstraint(item: self.appNameLabel, attribute: .top, relatedBy: .equal, toItem: self.welcomeToLabel, attribute: .bottom, multiplier: 1, constant: 0)
        let appNameLabelLeft = NSLayoutConstraint(item: self.appNameLabel, attribute: .left, relatedBy: .equal, toItem: self.contentView, attribute: .leftMargin, multiplier: 1, constant: 0)
        let appNameLabelRight = NSLayoutConstraint(item: self.appNameLabel, attribute: .right, relatedBy: .equal, toItem: self.contentView, attribute: .rightMargin, multiplier: 1, constant: 0)
        let appNameLabelHeight = NSLayoutConstraint(item: self.appNameLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: self.getHeaderFontSize() + 4)
        NSLayoutConstraint.activate([appNameLabelTop, appNameLabelLeft, appNameLabelRight, appNameLabelHeight])

        // App description label
        self.appDescriptionLabel.text = self.configuration.appDescription
        self.appDescriptionLabel.font = UIFont.systemFont(ofSize: self.getSubtitleFontSize(), weight: .regular)
        self.appDescriptionLabel.textColor = awsTextColor
        self.appDescriptionLabel.numberOfLines = 0

        self.appDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        let appDescriptionLabelTop = NSLayoutConstraint(item: self.appDescriptionLabel, attribute: .top, relatedBy: .equal, toItem: self.appNameLabel, attribute: .bottom, multiplier: 1, constant: self.getHeaderFontSize() / 4.8)
        let appDescriptionLabelLeft = NSLayoutConstraint(item: self.appDescriptionLabel, attribute: .left, relatedBy: .equal, toItem: self.contentView, attribute: .leftMargin, multiplier: 1, constant: 0)
        let appDescriptionLabelRight = NSLayoutConstraint(item: self.appDescriptionLabel, attribute: .right, relatedBy: .equal, toItem: self.contentView, attribute: .rightMargin, multiplier: 1, constant: 0)
        let appDescriptionLabelWidth = NSLayoutConstraint(item: self.appDescriptionLabel, attribute: .width, relatedBy: .equal, toItem: self.scrollView, attribute: .width, multiplier: 1, constant: -self.marginSize)
        self.appDescriptionLabel.sizeToFit()
        NSLayoutConstraint.activate([appDescriptionLabelTop, appDescriptionLabelLeft, appDescriptionLabelRight, appDescriptionLabelWidth])


        // Items table view
        self.itemsTableView.dataSource = self.itemsTableViewManager
        self.itemsTableView.delegate = self.itemsTableViewManager
        self.itemsTableView.bounces = false
        self.itemsTableView.separatorStyle = .none
        self.itemsTableView.layoutMargins.left = 0

        self.itemsTableView.translatesAutoresizingMaskIntoConstraints = false
        let itemsTableViewTop = NSLayoutConstraint(item: self.itemsTableView, attribute: .top, relatedBy: .equal, toItem: self.appDescriptionLabel, attribute: .bottom, multiplier: 1, constant: 18)
        let itemsTableViewLeft = NSLayoutConstraint(item: self.itemsTableView, attribute: .left, relatedBy: .equal, toItem: self.contentView, attribute: .leftMargin, multiplier: 1, constant: 0)
        let itemsTableViewRight = NSLayoutConstraint(item: self.itemsTableView, attribute: .right, relatedBy: .equal, toItem: self.contentView, attribute: .rightMargin, multiplier: 1, constant: 0)
        let itemsTableViewBottom = NSLayoutConstraint(item: self.itemsTableView, attribute: .bottom, relatedBy: .equal, toItem: self.contentView, attribute: .bottom, multiplier: 1, constant: self.getHeaderFontSize() + 4)
        NSLayoutConstraint.activate([itemsTableViewTop, itemsTableViewLeft, itemsTableViewRight, itemsTableViewBottom])

        self.itemsTableView.backgroundColor = .orange

        // "Continue" button
        self.continueButton.setTitle(self.configuration.continueButtonText, for: .normal)
        self.continueButton.addTarget(self, action: #selector(self.continueButtonTapped), for: .touchUpInside)
        self.continueButton.fillColor = self.configuration.tintColor
        self.continueButton.clipsToBounds = true
        self.continueButton.layer.cornerRadius = 8

        self.continueButton.translatesAutoresizingMaskIntoConstraints = false
        let continueButtonTop = NSLayoutConstraint(item: self.continueButton, attribute: .top, relatedBy: .equal, toItem: self.scrollView, attribute: .bottom, multiplier: 1, constant: 20)
        let continueButtonLeft = NSLayoutConstraint(item: self.continueButton, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .leftMargin, multiplier: 1, constant: self.marginSize)
        let continueButtonRight = NSLayoutConstraint(item: self.continueButton, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .rightMargin, multiplier: 1, constant: -(self.marginSize))
        let continueButtonBottom = NSLayoutConstraint(item: self.continueButton, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottomMargin, multiplier: 1, constant: -(self.marginSize + 24))
        let continueButtonHeight = NSLayoutConstraint(item: self.continueButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: self.getButtonSize())

        NSLayoutConstraint.activate([continueButtonTop, continueButtonLeft, continueButtonRight, continueButtonBottom, continueButtonHeight])

    }

    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.scrollView.flashScrollIndicators() // If the scroll view is scrollable, let the user know by flashing the scroll indicators.
    }

    @objc private func continueButtonTapped() {
        self.configuration.continueButtonAction?()
    }

    func getHeaderFontSize() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        if screenWidth >= 414 {
            return 48
        } else if screenWidth >= 375 {
            return 42
        } else {
            return 36
        }
    }

    func getSubtitleFontSize() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        if screenWidth >= 414 {
            return 17
        } else if screenWidth >= 375 {
            return 17
        } else {
            return 15
        }
    }

    func getMarginSize() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        if screenWidth >= 414 {
            return 24
        } else if screenWidth >= 375 {
            return 20
        } else {
            return 16
        }
    }

    func getButtonSize() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        if screenWidth >= 414 {
            return 52
        } else if screenWidth >= 375 {
            return 52
        } else {
            return 42
        }
    }
}

/// Modified version of <https://stackoverflow.com/a/48623673/5569234>
fileprivate class AWSIntrinsicTableView: UITableView {

    override var contentSize: CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: self.contentSize.height)
    }

}

fileprivate class AWSFilledButton: UIButton {

    var fillColor: UIColor? {
        didSet {
            self.backgroundColor = self.fillColor
        }
    }

    override open var isHighlighted: Bool {
        didSet {
            if let fillColor = self.fillColor {
                self.backgroundColor = isHighlighted ? fillColor.withAlphaComponent(0.75) : fillColor
            }
        }
    }
}

fileprivate class AWSItemsTableViewManager: NSObject, UITableViewDataSource, UITableViewDelegate {

    var items: [AWSItem]!

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AWSItemCell(item: self.items[indexPath.row])
        cell.isUserInteractionEnabled = false
        return cell
    }
}

fileprivate class AWSItemCell: UITableViewCell {

    var item: AWSItem

    var itemImageView: UIImageView!
    var itemTitleLabel: UILabel!
    var itemDescriptionLabel: UILabel!
    var topSpacerView: UIView!
    var bottomSpacerView: UIView!

    init(item: AWSItem) {
        self.item = item

        super.init(style: .default, reuseIdentifier: nil)

        // === Create the cell === //

        self.preservesSuperviewLayoutMargins = true
        self.layoutMargins.top = 8
        self.layoutMargins.bottom = 8

        // Top Spacer
        self.topSpacerView = UIView()

        self.topSpacerView.backgroundColor = .clear

        self.contentView.addSubview(self.topSpacerView)

        self.topSpacerView.translatesAutoresizingMaskIntoConstraints = false
        let topSpacerViewTop = NSLayoutConstraint(item: self.topSpacerView, attribute: .top, relatedBy: .equal, toItem: self.contentView, attribute: .topMargin, multiplier: 1, constant: 0)
        let topSpacerViewWidth = NSLayoutConstraint(item: self.topSpacerView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
        let topSpacerViewHeight = NSLayoutConstraint(item: self.topSpacerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: self.getCellSpacingSize() / 2)
        NSLayoutConstraint.activate([topSpacerViewTop, topSpacerViewWidth, topSpacerViewHeight])


        // Item image view
        self.itemImageView = UIImageView()

        self.itemImageView.image = self.item.image
        self.itemImageView.contentMode = .scaleAspectFit

        self.contentView.addSubview(self.itemImageView)

        self.itemImageView.translatesAutoresizingMaskIntoConstraints = false
        let itemImageViewLeft = NSLayoutConstraint(item: self.itemImageView, attribute: .left, relatedBy: .equal, toItem: self.contentView, attribute: .left, multiplier: 1, constant: 0)
        let itemImageViewWidth = NSLayoutConstraint(item: self.itemImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: self.getImageSize())
        let itemImageViewHeight = NSLayoutConstraint(item: self.itemImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: self.getImageSize())
        let itemImageViewCenterY = NSLayoutConstraint(item: self.itemImageView, attribute: .centerYWithinMargins, relatedBy: .equal, toItem: self.contentView, attribute: .centerYWithinMargins, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([itemImageViewLeft, itemImageViewWidth, itemImageViewHeight, itemImageViewCenterY])

        // Item title label
        self.itemTitleLabel = UILabel()

        self.itemTitleLabel.text = self.item.title
        self.itemTitleLabel.font = UIFont.systemFont(ofSize: self.getBodyFontSize(), weight: .bold)
        self.itemTitleLabel.textColor = awsTextColor
        self.itemTitleLabel.numberOfLines = 0

        self.contentView.addSubview(self.itemTitleLabel)

        self.itemTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        let itemTitleLabelTop = NSLayoutConstraint(item: self.itemTitleLabel, attribute: .top, relatedBy: .equal, toItem: self.topSpacerView, attribute: .bottom, multiplier: 1, constant: 0)
        let itemTitleLabelLeft = NSLayoutConstraint(item: self.itemTitleLabel, attribute: .left, relatedBy: .equal, toItem: self.itemImageView, attribute: .right, multiplier: 1, constant: 20)
        let itemTitleLabelRight = NSLayoutConstraint(item: self.itemTitleLabel, attribute: .right, relatedBy: .equal, toItem: self.contentView, attribute: .right, multiplier: 1, constant: 0)
        self.itemTitleLabel.sizeToFit()
        NSLayoutConstraint.activate([itemTitleLabelTop, itemTitleLabelLeft, itemTitleLabelRight])


        // Item description label
        self.itemDescriptionLabel = UILabel()

        self.itemDescriptionLabel.text = self.item.description
        self.itemDescriptionLabel.font = UIFont.systemFont(ofSize: self.getBodyFontSize(), weight: .regular)
        self.itemDescriptionLabel.textColor = awsTextColor
        self.itemDescriptionLabel.numberOfLines = 0

        self.contentView.addSubview(self.itemDescriptionLabel)

        self.itemDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        let itemDescriptionLabelTop = NSLayoutConstraint(item: self.itemDescriptionLabel, attribute: .top, relatedBy: .equal, toItem: self.itemTitleLabel, attribute: .bottom, multiplier: 1, constant: 4)
        let itemDescriptionLabelLeft = NSLayoutConstraint(item: self.itemDescriptionLabel, attribute: .left, relatedBy: .equal, toItem: self.itemImageView, attribute: .right, multiplier: 1, constant: 20)
        let itemDescriptionLabelRight = NSLayoutConstraint(item: self.itemDescriptionLabel, attribute: .right, relatedBy: .equal, toItem: self.contentView, attribute: .right, multiplier: 1, constant: 0)
        self.itemDescriptionLabel.sizeToFit()
        NSLayoutConstraint.activate([itemDescriptionLabelTop, itemDescriptionLabelLeft, itemDescriptionLabelRight])


        // Bottom Spacer
        self.bottomSpacerView = UIView()

        self.bottomSpacerView.backgroundColor = .clear

        self.contentView.addSubview(self.bottomSpacerView)

        self.bottomSpacerView.translatesAutoresizingMaskIntoConstraints = false
        let bottomSpacerViewTop = NSLayoutConstraint(item: self.bottomSpacerView, attribute: .top, relatedBy: .equal, toItem: self.itemDescriptionLabel, attribute: .bottom, multiplier: 1, constant: 0)
        let bottomSpacerViewBottom = NSLayoutConstraint(item: self.bottomSpacerView, attribute: .bottom, relatedBy: .equal, toItem: self.contentView, attribute: .bottomMargin, multiplier: 1, constant: 0)
        let bottomSpacerViewWidth = NSLayoutConstraint(item: self.bottomSpacerView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
        let bottomSpacerViewHeight = NSLayoutConstraint(item: self.bottomSpacerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: self.getCellSpacingSize() / 2)
        NSLayoutConstraint.activate([bottomSpacerViewTop, bottomSpacerViewBottom, bottomSpacerViewWidth, bottomSpacerViewHeight])

    }

    func getBodyFontSize() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        if screenWidth >= 414 {
            return 15
        } else if screenWidth >= 375 {
            return 15
        } else {
            return 13
        }
    }

    func getImageSize() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        if screenWidth >= 414 {
            return 60
        } else if screenWidth >= 375 {
            return 55
        } else {
            return 50
        }
    }

    func getCellSpacingSize() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        if screenWidth >= 414 {
            return 16
        } else if screenWidth >= 375 {
            return 12
        } else {
            return 8
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
