//
//  AddHistoryViewController.swift
//  santaProject
//
//  Created by Juwon Kim on 2021/07/10.
//

import UIKit

class AddHistoryViewController: UIViewController {

    var addHistoryView: AddHistoryView {
        view as! AddHistoryView
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let view = AddHistoryView()
        view.delegate = self
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension AddHistoryViewController: AddHistoryViewDelegate {
    func didTapDoneButton() {
        print("didTapDoneButton()")
        dismiss(animated: true, completion: nil)
    }

    func didTapCancelButton() {
        print("didTapCancelButton()")
        dismiss(animated: true, completion: nil)
    }

    func didTapSelectMountainButton() {
        print("didTapSelectMountainButton()")
        // present select mountain
    }

    func didTapDatePickButton(completion: ((Date?) -> ())?) {
        let vc = DatePickerViewController()
        vc.pickerCompletion = completion
        vc.modalPresentationStyle = .formSheet
        present(vc, animated: true, completion: nil)
    }
}
