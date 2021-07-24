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
}

extension AddHistoryViewController: AddHistoryViewDelegate {
    private func showToastMessage() {
        let message: String
        switch (pickedMountain, pickedDateString) {
        case (nil, nil):
            message = "다녀온 산, 날짜를 선택해주세요"
        case (_, nil):
            message = "다녀온 날짜를 선택해주세요"
        case (nil, _):
            message = "다녀온 산을 선택해주세요"
        default:
            fatalError("cannot be excecuted")
        }
        // TODO: show toast
        print("showToast: \(message)")
    }

    func didTapDoneButton() {
        guard let mountain = pickedMountain, let dateString = pickedDateString else {
            showToastMessage()
            return
        }
        delegate?.historyViewController(self, addedHistoryWith: mountain, dateString: dateString)
        dismiss(animated: true, completion: nil)
    }

    func didTapCancelButton() {
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
        guard let date = date else { return }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        dateFormatter.locale = Locale(identifier:"ko_KR")

        let dateString = dateFormatter.string(from: date)
        pickedDateString = dateString
        addHistoryView.updateDateLabel(with: dateString)
    }
}
