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
        UINavigationController(rootViewController: mapkitViewController()), // Dummy
        MyListViewController(),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // TODO: Remove or move
        tabs[1].tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "santaTabImageSearchInactive"), tag: 2)
        tabs[1].tabBarItem.selectedImage = UIImage(named: "santaTabImageSearchActive")
        tabs[1].tabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)
    }

    init() {
        super.init(nibName: nil, bundle: nil)

        tabBar.tintColor = .stGreen50
        setViewControllers(tabs, animated: false)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
