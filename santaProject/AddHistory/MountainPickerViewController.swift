//
//  MountainPickerViewController.swift
//  santaProject
//
//  Created by Juwon Kim on 2021/07/17.
//

import UIKit

final class MountainPickerViewController: UIViewController {

    var pickerCompletion: ((Mountain?)->())?

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
