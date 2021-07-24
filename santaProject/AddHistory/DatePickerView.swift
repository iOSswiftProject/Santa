//
//  DatePickerView.swift
//  santaProject
//
//  Created by Juwon Kim on 2021/07/16.
//

import UIKit

protocol DatePickerViewDelegate: AnyObject {
    func didTapDoneButton(date: Date)
}

class DatePickerView: UIView {

    weak var delegate: DatePickerViewDelegate?

    let datePicker = UIDatePicker()
    let doneButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white
        layer.cornerRadius = 12
        setupDatePicker()
        setupDoneButton()
        sizeToFit()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupDatePicker() {
        addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        datePicker.topAnchor.constraint(equalTo: topAnchor).isActive = true

        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
    }

    private func setupDoneButton() {
        addSubview(doneButton)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor).isActive = true
        doneButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        doneButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        doneButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        doneButton.heightAnchor.constraint(equalToConstant: 30).isActive = true

        doneButton.backgroundColor = .stOrange40
        doneButton.setTitle("완료", for: .normal)
        doneButton.layer.cornerRadius = 10
        doneButton.addTarget(self, action: #selector(didTapDoneButton(_:)), for: .touchUpInside)
    }

    @objc
    private func didTapDoneButton(_ sender: UIButton) {
        let date = datePicker.date
        delegate?.didTapDoneButton(date: date)
    }
}
