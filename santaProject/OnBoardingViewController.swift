//
//  OnBoardingViewController.swift
//  santaProject
//
//  Created by Juwon Kim on 2021/10/17.
//

import UIKit

protocol OnBoardingCollectionViewCellDelegate: AnyObject {
    func didTapStartButton()
}

class OnBoardingCollectionViewCell: UICollectionViewCell {
    static let identifier = "OnBoardingCollectionViewCell"

    weak var delegate: OnBoardingCollectionViewCellDelegate?

    let imageView = UIImageView()
    let startButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupImageView()
        setupStartButton()
    }

    private func setupImageView() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    private func setupStartButton() {
        addSubview(startButton)
        startButton.backgroundColor = .stGreen50
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        startButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        startButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -66).isActive = true
        startButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        startButton.isHidden = true
        startButton.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)

        let label = UILabel()
        startButton.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -66).isActive = true
        label.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        label.textColor = .stCoolGray00
        label.font = .systemFont(ofSize: 20, weight: .heavy)

        let attrString = NSMutableAttributedString(string: "시작하기")
        let range = NSRange(location: 0, length: attrString.length)
        attrString.addAttribute(.kern, value: -0.04, range: range)
        label.attributedText = attrString
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc
    private func didTapStartButton() {
        delegate?.didTapStartButton()
    }
}

class OnBoardingViewController: UIViewController {

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.allowsSelection = false
        return collectionView
    }()

    let images = [
        UIImage(named: "onboarding1"),
        UIImage(named: "onboarding2"),
        UIImage(named: "onboarding3"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }

    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.frame = view.frame
        collectionView.register(OnBoardingCollectionViewCell.self, forCellWithReuseIdentifier: OnBoardingCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
    }
}

extension OnBoardingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: OnBoardingCollectionViewCell.identifier,
                for: indexPath) as? OnBoardingCollectionViewCell
        else { return UICollectionViewCell() }
        cell.imageView.image = images[indexPath.row]
        cell.delegate = self
        if indexPath.row == 2 {
            cell.startButton.isHidden = false
        }
        return cell
    }
}

extension OnBoardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionView.frame.size
    }
}

extension OnBoardingViewController: OnBoardingCollectionViewCellDelegate {
    func didTapStartButton() {
        let vc = RootTabBarController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true) {
            UserDefaults.standard.setValue(false, forKey: "isFirstTime")
        }
    }
}
