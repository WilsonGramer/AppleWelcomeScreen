//
//  ViewController.swift
//  AppleWelcomeScreen
//
//  Created by Wilsonator5000 on 05/12/2018.
//  Copyright (c) 2018 Wilsonator5000. All rights reserved.
//

import UIKit
import AppleWelcomeScreen

class ViewController: UIViewController {

    var isFirstOpen = true

    var configuration = AWSConfigOptions()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // === Set up configuration === //

        configuration.appName = "Notes"
        configuration.appDescription = "Great new tools for notes synced to your iCloud account."
        configuration.tintColor = UIColor(named: "NotesYellowColor")!

        var item1 = AWSItem()
        item1.image = UIImage(named: "item1")
        item1.title = "Add almost anything"
        item1.description = "Capture documents, photos, maps, and more for a richer Notes experience."

        var item2 = AWSItem()
        item2.image = UIImage(named: "item2")
        item2.title = "Note to self, or with anyone"
        item2.description = "Invite others to view or make changes to a note."

        var item3 = AWSItem()
        item3.image = UIImage(named: "item3")
        item3.title = "Sketch your thoughts"
        item3.description = "Draw using just your finger."

        configuration.items = [item1, item2, item3]

        configuration.continueButtonAction = {
            self.dismiss(animated: true)
        }

        // === Set up view === //

        self.view.backgroundColor = .white

        let label = UILabel()
        label.text = "👨‍💻 with ❤️ by Wilsonator5000"
        self.view.addSubview(label)

        label.translatesAutoresizingMaskIntoConstraints = false
        let labelCenterX = NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: label.superview, attribute: .centerX, multiplier: 1, constant: 0)
        let labelCenterY = NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: label.superview, attribute: .centerY, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([labelCenterX, labelCenterY])


        let openAgainButton = UIButton()
        openAgainButton.setTitle("Show Welcome Screen again", for: .normal)
        openAgainButton.setTitleColor(self.view.tintColor, for: .normal)
        openAgainButton.addTarget(self, action: #selector(self.showWelcomeScreen), for: .touchUpInside)
        self.view.addSubview(openAgainButton)

        openAgainButton.translatesAutoresizingMaskIntoConstraints = false
        let openAgainButtonTop = NSLayoutConstraint(item: openAgainButton, attribute: .top, relatedBy: .equal, toItem: label, attribute: .bottom, multiplier: 1, constant: 6)
        let openAgainButtonCenterX = NSLayoutConstraint(item: openAgainButton, attribute: .centerX, relatedBy: .equal, toItem: openAgainButton.superview, attribute: .centerX, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([openAgainButtonTop, openAgainButtonCenterX])

    }

    @objc func showWelcomeScreen() {
        let vc = AWSViewController()
        vc.configuration = configuration
        self.present(vc, animated: true)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if !(self.isFirstOpen) {
            return
        } else {
            self.showWelcomeScreen()
            self.isFirstOpen = false
        }
    }
}
