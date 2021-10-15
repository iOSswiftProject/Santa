//
//  AddHistoryViewController.swift
//  santaProject
//
//  Created by Juwon Kim on 2021/07/10.
//

import UIKit

protocol AddHistoryViewControllerDelegate: AnyObject {
    func historyViewController(_ controller: AddHistoryViewController, addedHistoryWith mountain: Mountain, dateString: String)
}

class AddHistoryViewController: UIViewController {

    weak var delegate: AddHistoryViewControllerDelegate?

    var addHistoryView: AddHistoryView {
        view as! AddHistoryView
    }

    var pickedMountain: Mountain?
    var pickedDateString: String?

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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
}

extension AddHistoryViewController: AddHistoryViewDelegate {
    private func showEmptyMessage() {
        if pickedMountain == nil {
            addHistoryView.showMountainEmptyMessage()
        }
        if pickedDateString == nil {
            addHistoryView.showDateEmptyMessage()
        }
    }

    func didTapDoneButton() {
        guard let mountain = pickedMountain, let dateString = pickedDateString else {
            showEmptyMessage()
            return
        }
        delegate?.historyViewController(self, addedHistoryWith: mountain, dateString: dateString)
        dismiss(animated: true, completion: nil)
    }

    func didTapCancelButton() {
        dismiss(animated: true, completion: nil)
    }

    func didTapSelectMountainButton() {
        let vc = SearchBarViewController()
        vc.fromAddHistory = true
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }

    func didTapDatePickButton() {
        let vc = DatePickerViewController()
        vc.delegate = self
        vc.modalPresentationStyle = .formSheet
        present(vc, animated: true, completion: nil)
    }
}

extension AddHistoryViewController: SearchBarViewControllerDelegate {
    func didSelectMountain(_ mountain: Mountain) {
        pickedMountain = mountain
        addHistoryView.hideMountainEmptyMessage()
        addHistoryView.updateMountainNameLabel(with: mountain)
    }
}

extension AddHistoryViewController: MountainPickerViewControllerDelegate, DatePickerViewControllerDelegate {
    func mountainPickerViewController(_ controller: MountainPickerViewController, didFinishPicking mountain: Mountain?) {
        guard let mountain = mountain else { return }
        pickedMountain = mountain
        addHistoryView.hideMountainEmptyMessage()
        addHistoryView.updateMountainNameLabel(with: mountain)
    }

    func datePickerViewController(_ controller: DatePickerViewController, didFinishPicking date: Date?) {
        guard let date = date else { return }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        dateFormatter.locale = Locale(identifier:"ko_KR")

        let dateString = dateFormatter.string(from: date)
        pickedDateString = dateString
        addHistoryView.hideDateEmptyMessage()
        addHistoryView.updateDateLabel(with: dateString)
    }
}
