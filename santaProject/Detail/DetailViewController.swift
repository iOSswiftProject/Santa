//
//  DetailViewController.swift
//  santaProject
//
//  Created by Juwon Kim on 2021/08/16.
//

import UIKit

class DetailViewController: UIViewController {

    private var mountain: Mountain
    private let detailView = DetailView()

    init(with mountain: Mountain) {
        self.mountain = mountain
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()

        tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDetailView()
    }

    private func setupDetailView() {
        let navigationHeight = navigationController?.navigationBar.frame.height ?? 0
        view.addSubview(detailView)
        detailView.translatesAutoresizingMaskIntoConstraints = false
        detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                        constant: -navigationHeight).isActive = true
        detailView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
