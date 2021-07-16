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

    var pickedMountain: Mountain?
    var pickedDate: Date?

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
        let vc = MountainPickerViewController()
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }

    func didTapDatePickButton() {
        let vc = DatePickerViewController()
        vc.delegate = self
        vc.modalPresentationStyle = .formSheet
        present(vc, animated: true, completion: nil)
    }
}

extension AddHistoryViewController: MountainPickerViewControllerDelegate, DatePickerViewControllerDelegate {
    func mountainPickerViewController(_ controller: MountainPickerViewController, didFinishPicking mountain: Mountain?) {
        pickedMountain = mountain
        addHistoryView.updateMountainNameLabel(with: mountain)
    }

    func datePickerViewController(_ controller: DatePickerViewController, didFinishPicking date: Date?) {
        pickedDate = date
        addHistoryView.updateDateLabel(with: date)
    }
}
