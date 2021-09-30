//
//  DetailViewController.swift
//  santaProject
//
//  Created by Juwon Kim on 2021/08/16.
//

import UIKit

class DetailViewController: UIViewController {

    private var mountain: Mountain
    private var detailInfo: DetailInfo?
    private let detailViewModel: DetailViewModel
    private let detailView = DetailView()

    private var navigationBarHidden = true
    private var tabbarHidden = true
    private var naviBackButtonTitle: String?
    private var naviTintColor: UIColor?
    private var naviBackIndicatorImage: UIImage?
    private var naviBackIndicatorTransitionMaskImage: UIImage?

    init(with mountain: Mountain) {
        self.mountain = mountain
        self.detailInfo = mountain.detailInfo()
        self.detailViewModel = DetailViewModel(with: mountain, detailInfo: detailInfo)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDetailView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationBarHidden = navigationController?.isNavigationBarHidden ?? true
        tabbarHidden = tabBarController?.tabBar.isHidden ?? true
        navigationController?.setNavigationBarHidden(false, animated: true)
        tabBarController?.tabBar.isHidden = true

        guard let navigationBar = navigationController?.navigationBar else { return }
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.backgroundColor = .clear

        naviBackButtonTitle = navigationBar.backItem?.backButtonTitle
        navigationBar.backItem?.backButtonTitle = ""

        naviTintColor = navigationBar.tintColor
        navigationBar.tintColor = .stCoolGray70

        naviBackIndicatorImage = navigationBar.backIndicatorImage
        naviBackIndicatorTransitionMaskImage = navigationBar.backIndicatorTransitionMaskImage
        navigationBar.backIndicatorImage = UIImage(named: "santaBackButton")
        navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "santaBackButton")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.setNavigationBarHidden(navigationBarHidden, animated: true)
        tabBarController?.tabBar.isHidden = tabbarHidden

        guard let navigationBar = navigationController?.navigationBar else { return }
        navigationBar.setBackgroundImage(nil, for: .default)
        navigationBar.shadowImage = nil
        navigationBar.backgroundColor = nil
        navigationBar.backItem?.backButtonTitle = naviBackButtonTitle
        navigationBar.tintColor = naviTintColor

        navigationBar.backIndicatorImage = naviBackIndicatorImage
        navigationBar.backIndicatorTransitionMaskImage = naviBackIndicatorTransitionMaskImage
    }

    private func setupDetailView() {
        let naviBarHeight = navigationController?.navigationBar.frame.height ?? 0
        view.addSubview(detailView)
        detailView.translatesAutoresizingMaskIntoConstraints = false
        detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -naviBarHeight).isActive = true
        detailView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        detailView.delegate = self
        detailViewModel.congifure(detailView)
    }
}

extension DetailViewController: DetailViewDelegate {
    func detailViewDidTapBookmarkButton(_ detailView: DetailView) {
        guard let isFavorite = mountain.isFavorite else { return }
        mountain.isFavorite = !isFavorite
        detailViewModel.congifure(detailView)
        let mountainId = mountain.id ?? 0
        DBInterface.shared.updateIsFavorite(mountainId: mountainId, isFavorite: !isFavorite)
    }
}
