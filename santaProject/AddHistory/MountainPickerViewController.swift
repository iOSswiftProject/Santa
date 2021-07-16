//
//  MountainPickerViewController.swift
//  santaProject
//
//  Created by Juwon Kim on 2021/07/17.
//

import UIKit

protocol MountainPickerViewControllerDelegate: AnyObject {
    func mountainPickerViewController(_ controller: MountainPickerViewController, didFinishPicking mountain: Mountain?)
}

final class MountainPickerViewController: UIViewController {

    weak var delegate: MountainPickerViewControllerDelegate?

    let mountainPickerView = MountainPickerView()

    var allMountains: [Mountain] = []

    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        allMountains = DBInterface.shared.selectMountain()
        setupMountainPickerView()
    }

    private func setupMountainPickerView() {
        view.addSubview(mountainPickerView)
        mountainPickerView.translatesAutoresizingMaskIntoConstraints = false
        mountainPickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mountainPickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mountainPickerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mountainPickerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        mountainPickerView.tableView.dataSource = self
        mountainPickerView.tableView.delegate = self
    }
}

extension MountainPickerViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allMountains.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MountainPickerTableViewCell.identifier) as? MountainPickerTableViewCell else {
            return UITableViewCell()
        }
        cell.updateInfo(with: allMountains[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        96
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mountain = allMountains[indexPath.row]
        delegate?.mountainPickerViewController(self, didFinishPicking: mountain)
        dismiss(animated: true, completion: nil)
    }
}
