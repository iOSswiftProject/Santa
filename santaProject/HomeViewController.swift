//
//  HomeViewController.swift
//  santaProject
//
//  Created by Juwon Kim on 2021/05/29.
//

import UIKit

class HomeViewController: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "santaTabImageHomeInactive"), tag: 1)
        self.tabBarItem.selectedImage = UIImage(named: "santaTabImageHomeActive")
        self.tabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
