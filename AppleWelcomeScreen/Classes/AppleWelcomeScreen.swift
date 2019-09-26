import Foundation
import UIKit
import SnapKit

/// An item to be displayed in the welcome screen, used to show off a feature of your app.
public struct AWSItem {
    
    /// The icon of the item. This will appear on the left side of the item.
    public var image: UIImage!
    
    /// The title of the feature.
    public var title: String!
    
    /// More information about the feature, displayed under the title.
    public var description: String!
    
    public init() { }
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
    public var tintColor: UIColor = SystemColor.systemBlue
    
    public init() { }
}

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
        self.view.backgroundColor = SystemColor.systemBackground
        
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
        
        self.scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.topMargin)
            make.bottom.equalTo(self.continueButton.snp.top).offset(-20)
            make.left.equalTo(self.view.snp.leftMargin).offset(self.marginSize)
            make.right.equalTo(self.view.snp.rightMargin).offset(-(self.marginSize))
        }
        
        // Content view
        self.contentView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        // "Welcome to" label
        self.welcomeToLabel.text = "Welcome to"
        self.welcomeToLabel.textColor = SystemColor.label
        self.welcomeToLabel.font = UIFont.systemFont(ofSize: self.getHeaderFontSize(), weight: .heavy)
        self.welcomeToLabel.adjustsFontSizeToFitWidth = true
        
        self.welcomeToLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView.snp.topMargin).offset(self.getHeaderFontSize() - 8)
            make.left.equalTo(self.contentView.snp.leftMargin)
            make.right.equalTo(self.contentView.snp.rightMargin)
            make.height.equalTo(self.getHeaderFontSize() + 4)
        }
        
        // App Name label
        self.appNameLabel.text = self.configuration.appName
        self.appNameLabel.font = UIFont.systemFont(ofSize: self.getHeaderFontSize(), weight: .heavy)
        self.appNameLabel.adjustsFontSizeToFitWidth = true
        self.appNameLabel.textColor = self.configuration.tintColor
        
        self.appNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.welcomeToLabel.snp.bottom)
            make.left.equalTo(self.contentView.snp.leftMargin)
            make.right.equalTo(self.contentView.snp.rightMargin)
            make.height.equalTo(self.getHeaderFontSize() + 4)
        }
        
        // App description label
        self.appDescriptionLabel.text = self.configuration.appDescription
        self.appDescriptionLabel.font = UIFont.systemFont(ofSize: self.getSubtitleFontSize(), weight: .regular)
        self.appDescriptionLabel.textColor = SystemColor.label
        self.appDescriptionLabel.numberOfLines = 0
        
        self.appDescriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.appNameLabel.snp.bottom).offset(self.getHeaderFontSize() / 4.8)
            make.left.equalTo(self.contentView.snp.leftMargin)
            make.right.equalTo(self.contentView.snp.rightMargin)
            self.appDescriptionLabel.sizeToFit()
        }
        
        // Items table view
        self.itemsTableView.dataSource = self.itemsTableViewManager
        self.itemsTableView.delegate = self.itemsTableViewManager
        self.itemsTableView.bounces = false
        self.itemsTableView.separatorStyle = .none
        self.itemsTableView.layoutMargins.left = 0
        
        self.itemsTableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.appDescriptionLabel.snp.bottom).offset(18)
            make.left.equalTo(self.contentView.snp.leftMargin)
            make.right.equalTo(self.contentView.snp.rightMargin)
            make.bottom.equalTo(self.contentView.snp.bottom)
        }
        
        // "Continue" button
        self.continueButton.setTitle(self.configuration.continueButtonText, for: .normal)
        self.continueButton.addTarget(self, action: #selector(self.continueButtonTapped), for: .touchUpInside)
        self.continueButton.fillColor = self.configuration.tintColor
        self.continueButton.clipsToBounds = true
        self.continueButton.layer.cornerRadius = 8
        self.continueButton.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner]
        
        self.continueButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.scrollView.snp.bottom).offset(20)
            make.left.equalTo(self.view.snp.leftMargin).offset(self.marginSize)
            make.right.equalTo(self.view.snp.rightMargin).offset(-(self.marginSize))
            make.bottom.equalTo(self.view.snp.bottomMargin).offset(-(self.marginSize + 24))
            make.height.equalTo(self.getButtonSize())
        }
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
        return CGSize(width: UIViewNoIntrinsicMetric, height: self.contentSize.height)
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
        return UITableViewAutomaticDimension
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
        self.topSpacerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView.snp.topMargin)
            make.width.equalTo(0)
            make.height.equalTo(self.getCellSpacingSize() / 2)
        }
        
        // Item image view
        self.itemImageView = UIImageView()
        
        self.itemImageView.image = self.item.image
        self.itemImageView.contentMode = .scaleAspectFit
        
        self.contentView.addSubview(self.itemImageView)
        self.itemImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left)
            make.width.equalTo(self.getImageSize())
            make.height.equalTo(self.getImageSize())
            make.centerYWithinMargins.equalTo(0)
        }
        
        // Item title label
        self.itemTitleLabel = UILabel()
        
        self.itemTitleLabel.text = self.item.title
        self.itemTitleLabel.font = UIFont.systemFont(ofSize: self.getBodyFontSize(), weight: .bold)
        self.itemTitleLabel.textColor = SystemColor.label
        self.itemTitleLabel.numberOfLines = 0
        
        self.contentView.addSubview(self.itemTitleLabel)
        self.itemTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.topSpacerView.snp.bottom)
            make.left.equalTo(self.itemImageView.snp.right).offset(20)
            make.right.equalTo(self.contentView.snp.right)
            self.itemTitleLabel.sizeToFit()
        }
        
        // Item description label
        self.itemDescriptionLabel = UILabel()
        
        self.itemDescriptionLabel.text = self.item.description
        self.itemDescriptionLabel.font = UIFont.systemFont(ofSize: self.getBodyFontSize(), weight: .regular)
        self.itemDescriptionLabel.textColor = SystemColor.secondaryLabel
        self.itemDescriptionLabel.numberOfLines = 0
        
        self.contentView.addSubview(self.itemDescriptionLabel)
        self.itemDescriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.itemTitleLabel.snp.bottom).offset(4)
            make.left.equalTo(self.itemImageView.snp.right).offset(20)
            make.right.equalTo(self.contentView.snp.right)
            self.itemDescriptionLabel.sizeToFit()
        }
        
        // Bottom Spacer
        self.bottomSpacerView = UIView()
        
        self.bottomSpacerView.backgroundColor = .clear
        
        self.contentView.addSubview(self.bottomSpacerView)
        self.bottomSpacerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.itemDescriptionLabel.snp.bottom)
            make.bottom.equalTo(self.contentView.snp.bottomMargin)
            make.width.equalTo(0)
            make.height.equalTo(self.getCellSpacingSize() / 2)
        }
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

/// Adapted from https://github.com/Wilsonator5000/SystemColor
fileprivate enum SystemColor {
    /// The color for the main background of your interface.
    static var systemBackground: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemBackground
        } else {
            return UIColor(
                red: 1.0,
                green: 1.0,
                blue: 1.0,
                alpha: 1.0
            )
        }
    }

    /// A blue color that automatically adapts to the current trait environment.
    static var systemBlue: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemBlue
        } else {
            return UIColor(
                red: 0.0,
                green: 0.47843137254901963,
                blue: 1.0,
                alpha: 1.0
            )
        }
    }

    /// The color for text labels containing primary content.
    static var label: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.label
        } else {
            return UIColor(
                red: 0.0,
                green: 0.0,
                blue: 0.0,
                alpha: 1.0
            )
        }
    }

    /// The color for text labels containing secondary content.
    static var secondaryLabel: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.secondaryLabel
        } else {
            return UIColor(
                red: 0.23529411764705882,
                green: 0.23529411764705882,
                blue: 0.2627450980392157,
                alpha: 0.6
            )
        }
    }
}
