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
        self.tabBarItem = UITabBarItem(title: "Home", image: nil, tag: 1)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
