//
//  DatePickerViewController.swift
//  santaProject
//
//  Created by Juwon Kim on 2021/07/16.
//

import UIKit

protocol DatePickerViewControllerDelegate: AnyObject {
    func datePickerViewController(_ controller: DatePickerViewController, didFinishPicking date: Date?)
}

class DatePickerViewController: UIViewController {

    weak var delegate: DatePickerViewControllerDelegate?

    let datePickerView = DatePickerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear

        setupView()
        setupTapGesture()
    }

    private func setupView() {
        view.addSubview(datePickerView)
        datePickerView.translatesAutoresizingMaskIntoConstraints = false
        datePickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        datePickerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        datePickerView.delegate = self
    }

    private func setupTapGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(gesture)
    }

    @objc
    private func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        let point = gestureRecognizer.location(in: view)
        guard datePickerView.frame.contains(point) == false else { return }
        close()
    }

    private func close(with date: Date? = nil) {
        delegate?.datePickerViewController(self, didFinishPicking: date)
        dismiss(animated: true, completion: nil)
    }
}

extension DatePickerViewController: DatePickerViewDelegate {
    func didTapDoneButton(date: Date) {
        close(with: date)
    }
}
