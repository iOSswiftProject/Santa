//
//  OnBoardingViewController.swift
//  santaProject
//
//  Created by Juwon Kim on 2021/10/17.
//

import UIKit

class OnBoardingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        setupButton()
    }

    private func setupButton() {
        let button = UIButton()
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        button.widthAnchor.constraint(equalToConstant: 200).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.setTitle("시작", for: .normal)
        button.backgroundColor = .blue

        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }

    @objc
    private func didTapButton() {
        let vc = RootTabBarController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true) {
//            UserDefaults.standard.setValue(false, forKey: "isFirstTime")
        }
    }
}
