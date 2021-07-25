//
//  MountainPickerView.swift
//  santaProject
//
//  Created by Juwon Kim on 2021/07/17.
//

import UIKit

class MountainPickerView: UIView {

    let label = UILabel()
    let tableView = UITableView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLabel() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        label.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true

        label.font = .systemFont(ofSize: 32)
        label.text = "산 선택"
    }

    private func setupTableView() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        tableView.register(MountainPickerTableViewCell.self, forCellReuseIdentifier: MountainPickerTableViewCell.identifier)
    }
}

class MountainPickerTableViewCell: UITableViewCell {
    static let identifier = "MountainPickerTableViewCell"

    let baseInfoView = MountainInfoBaseView()
    var mountain: Mountain?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        layer.cornerRadius = 18
        setupBaseInfoView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        mountain = nil
    }

    private func setupBaseInfoView() {
        addSubview(baseInfoView)
        baseInfoView.translatesAutoresizingMaskIntoConstraints = false
        baseInfoView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        baseInfoView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        baseInfoView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        baseInfoView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        baseInfoView.backgroundColor = .stCoolGray10
    }

    func updateInfo(with model: Mountain) {
        mountain = model
        guard let mountainName = model.name,
              let regionName = model.depth1,
              let subRegionName = model.depth2,
              let height = model.height
        else { return }

        let peakName = model.peak ?? ""
        let nameView = baseInfoView.mountainNameView

        nameView.updateMountainNameLabelAttributedText(mountainName: mountainName, peakName: peakName)
        nameView.updateRegionTag(regionName: regionName)

        baseInfoView.updateSubRegion(subregionName: subRegionName)
        baseInfoView.updateHeight(height)
    }
}
