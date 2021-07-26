//
//  HomeViewController.swift
//  santaProject
//
//  Created by Juwon Kim on 2021/05/29.
//

import UIKit

class HomeViewController: UIViewController {

    let homeView = HomeView()
    var homeViewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupHomeView()
        setupHomeViewModel()
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "santaTabImageHomeInactive"), tag: 1)
        self.tabBarItem.selectedImage = UIImage(named: "santaTabImageHomeActive")
        self.tabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func setupHomeViewModel() {
        homeViewModel.update()
    }

    private func setupHomeView() {
        view.addSubview(homeView)
        homeView.translatesAutoresizingMaskIntoConstraints = false
        homeView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        homeView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        homeView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        homeView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
