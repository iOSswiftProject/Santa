//
//  DetailViewController.swift
//  santaProject
//
//  Created by Juwon Kim on 2021/08/16.
//

import UIKit

class DetailViewController: UIViewController {

    private var mountain: Mountain
    private let detailViewModel: DetailViewModel
    private let detailView = DetailView()

    private var navigationBarHidden: Bool?
    private var tabbarHidden: Bool?

    init(with mountain: Mountain) {
        self.mountain = mountain
        self.detailViewModel = DetailViewModel(with: mountain)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBarHidden = navigationController?.isNavigationBarHidden
        tabbarHidden = tabBarController?.tabBar.isHidden
        navigationController?.setNavigationBarHidden(true, animated: false)
        tabBarController?.tabBar.isHidden = true

        setupDetailView()
    }

    private func setupDetailView() {
        view.addSubview(detailView)
        detailView.translatesAutoresizingMaskIntoConstraints = false
        detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        detailView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        detailView.delegate = self
        detailViewModel.congifure(detailView)
    }
}

extension DetailViewController: DetailViewDelegate {
    func detailViewDidTapBackButton(_ detailView: DetailView) {
        if let navigationBarHidden = navigationBarHidden {
            navigationController?.setNavigationBarHidden(navigationBarHidden, animated: false)
        }
        if let tabbarHidden = tabbarHidden {
            tabBarController?.tabBar.isHidden = tabbarHidden
        }

        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
        else {
            dismiss(animated: true, completion: nil)
        }
    }
}
