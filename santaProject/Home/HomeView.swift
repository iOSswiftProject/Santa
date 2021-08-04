//
//  HomeView.swift
//  santaProject
//
//  Created by Juwon Kim on 2021/07/26.
//

import UIKit

class HomeView: UIView {

    let menuButton = UIButton()
    let tableView = UITableView(frame: .zero, style: .grouped)
    let accumulateHeightTitleLabel = UILabel()
    let accumulateHeightLabel = UILabel()
    let topGradientView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
        setupTopGradientView()
        setupMenuButton()
        setupAccumulateHeightLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setGradientLayer()
    }

    private func setupMenuButton() {
        addSubview(menuButton)
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        menuButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        menuButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24).isActive = true
        menuButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        menuButton.heightAnchor.constraint(equalToConstant: 24).isActive = true

        menuButton.setImage(#imageLiteral(resourceName: "santaHomeMenuButton"), for: .normal)
        menuButton.addTarget(self, action: #selector(didTapMenuButton(_:)), for: .touchUpInside)
    }

    private func setupTableView() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none

        tableView.register(HomeViewTableViewCell.self, forCellReuseIdentifier: HomeViewTableViewCell.identifier)
        tableView.register(HomeViewTableViewHeaderView.self,
                           forHeaderFooterViewReuseIdentifier: HomeViewTableViewHeaderView.identifier)
    }

    private func setupAccumulateHeightLabel() {
        let container = UIView()
        addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        container.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 25).isActive = true

        container.addSubview(accumulateHeightTitleLabel)
        accumulateHeightTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        accumulateHeightTitleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        accumulateHeightTitleLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true

        container.addSubview(accumulateHeightLabel)
        accumulateHeightLabel.translatesAutoresizingMaskIntoConstraints = false
        accumulateHeightLabel.leadingAnchor.constraint(equalTo: accumulateHeightTitleLabel.trailingAnchor,
                                                       constant: 8).isActive = true
        accumulateHeightLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        accumulateHeightLabel.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        accumulateHeightLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true

        accumulateHeightTitleLabel.font = .systemFont(ofSize: 14, weight: .bold)
        accumulateHeightTitleLabel.textColor = .stGreen40

        accumulateHeightLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        accumulateHeightLabel.textColor = .stGreen40

        let attrTitle = NSMutableAttributedString(string: "총 높이")
        let range = NSRange(location: 0, length: attrTitle.length)
        attrTitle.addAttribute(.kern, value: -0.08, range: range)
        accumulateHeightTitleLabel.attributedText = attrTitle
    }

    private func setupTopGradientView() {
        addSubview(topGradientView)
        topGradientView.translatesAutoresizingMaskIntoConstraints = false
        topGradientView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        topGradientView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        topGradientView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topGradientView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        topGradientView.backgroundColor = UIColor(hex: "FFE1CD")
    }

    private func setGradientLayer() {
        let colors: [UIColor] = [.black, .black, .black, .black.withAlphaComponent(0.7), .clear]
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = topGradientView.bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)

        topGradientView.layer.mask = gradientLayer
    }

    @objc
    private func didTapMenuButton(_ sender: UIButton) {
        print("home menu button tapped!")
    }

    func updateAccumulateHeight(_ height: Int) {
        let heightString: String
        switch height {
        case ..<1000:
            heightString = "\(height)m"
        default:
            let kilometer = Double(height) / 1000
            heightString = "\(kilometer)km"
        }
        let attrString = NSMutableAttributedString(string: heightString)
        let range = NSRange(location: 0, length: attrString.length)
        attrString.addAttribute(.kern, value: -0.02, range: range)
        accumulateHeightLabel.attributedText = attrString
    }
}
