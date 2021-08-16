//
//  DetailViewController.swift
//  santaProject
//
//  Created by Juwon Kim on 2021/08/16.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red

        let label = UILabel()
        label.text = "상세보기"
        view.addSubview(label)
        label.frame = CGRect(x: 100, y: 400, width: 200, height: 200)
    }
}
