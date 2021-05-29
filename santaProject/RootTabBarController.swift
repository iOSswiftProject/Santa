//
//  RootTabBarController.swift
//  santaProject
//
//  Created by Journey on 2021/05/29.
//

import UIKit

class RootTabBarController: UITabBarController {

    private let tabs: [UIViewController] = [
        HomeViewController(),
        UIViewController(), // Dummy
        UIViewController(), // Dummy
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    init() {
        super.init(nibName: nil, bundle: nil)

        setViewControllers(tabs, animated: false)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
