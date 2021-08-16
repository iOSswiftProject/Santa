//
//  DetailViewController.swift
//  santaProject
//
//  Created by Juwon Kim on 2021/08/16.
//

import UIKit

class DetailViewController: UIViewController {

    private var mountain: Mountain

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
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let label = UILabel()
        label.text = mountain.name
        view.addSubview(label)
        label.frame = CGRect(x: 100, y: 400, width: 200, height: 200)
    }
}
