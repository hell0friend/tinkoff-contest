//
//  LeftIconHeaderView.swift
//  Tinkoff-Contest
//
//  Created by Alexander Mironov on 22.04.2023.
//

import UIKit

public final class LeftIconHeaderView: UIView {

    private let cardContentView = UIView().forAutoLayout()
    private let iconView = UIImageView().forAutoLayout()
    private let titleLabel = UILabel().forAutoLayout()
    private let subtitleLabel = UILabel().forAutoLayout()
    private let closeImage = UIImageView().forAutoLayout()

    private lazy var titleLabelTrailingAnchorWithoutCloseButton = titleLabel.trailingAnchor.constraint(
        equalTo: cardContentView.trailingAnchor,
        constant: -20
    )
    private lazy var subtitleLabelTrailingAnchorWithoutCloseButton = subtitleLabel.trailingAnchor.constraint(
        equalTo: cardContentView.trailingAnchor,
        constant: -20
    )

    private lazy var titleLabelTrailingAnchorWithCloseButton = titleLabel.trailingAnchor.constraint(
        equalTo: closeImage.leadingAnchor,
        constant: -20
    )
    private lazy var subtitleLabelTrailingAnchorWithCloseButton = subtitleLabel.trailingAnchor.constraint(
        equalTo: closeImage.leadingAnchor,
        constant: -20
    )

    private var didCloseClosure: (() -> Void)?

    public override init(frame: CGRect) {
        super.init(frame: frame)

        configureViews()
        addSubviews()
        activateConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension LeftIconHeaderView: ConfigurableItem {

    public func configure(with object: Any) {
        guard let viewModel = object as? ViewModel else { return }

        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.description
        iconView.image = viewModel.icon

        switch viewModel.closeStyle {
        case let .none(backgroundStyle):
            closeImage.isHidden = true
            titleLabelTrailingAnchorWithoutCloseButton.isActive = true
            subtitleLabelTrailingAnchorWithoutCloseButton.isActive = true
            titleLabelTrailingAnchorWithCloseButton.isActive = false
            subtitleLabelTrailingAnchorWithCloseButton.isActive = false
            switch backgroundStyle {
            case .white:
                cardContentView.backgroundColor = .white
                cardContentView.dropShadow(
                    radius: 34,
                    color: UIColor(red: 0, green: 0, blue: 0, alpha: 0.12),
                    opacity: 1,
                    offsetY: 6
                )
            case .grey:
                cardContentView.backgroundColor = UIColor(red: 246 / 255, green: 247 / 255, blue: 248 / 255, alpha: 1)
                cardContentView.removeShadow()
            }
        case let .action(didClose, image):
            closeImage.isHidden = false
            titleLabelTrailingAnchorWithoutCloseButton.isActive = false
            subtitleLabelTrailingAnchorWithoutCloseButton.isActive = false
            titleLabelTrailingAnchorWithCloseButton.isActive = true
            subtitleLabelTrailingAnchorWithCloseButton.isActive = true
            didCloseClosure = didClose
            closeImage.image = image
            cardContentView.backgroundColor = .white
            cardContentView.dropShadow(
                radius: 34,
                color: UIColor(red: 0, green: 0, blue: 0, alpha: 0.12),
                opacity: 1,
                offsetY: 6
            )
        }

        layoutIfNeeded()
    }
}

private extension LeftIconHeaderView {

    func configureViews() {
        cardContentView.layer.cornerRadius = 24
        titleLabel.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        subtitleLabel.textColor = UIColor(red: 0.573, green: 0.6, blue: 0.635, alpha: 1)
        titleLabel.font = .systemFont(ofSize: 17, weight: .regular)
        subtitleLabel.font = .systemFont(ofSize: 13, weight: .regular)

        closeImage.isUserInteractionEnabled = true
        let closeTap = UITapGestureRecognizer()
        closeImage.addGestureRecognizer(closeTap)
        closeTap.addTarget(self, action: #selector(didClose))
    }
    
    func addSubviews() {
        addSubview(cardContentView)
        cardContentView.addSubview(iconView)
        cardContentView.addSubview(titleLabel)
        cardContentView.addSubview(subtitleLabel)
        cardContentView.addSubview(closeImage)
    }

    func activateConstraints() {
        NSLayoutConstraint.activate(
            [
                cardContentView.topAnchor.constraint(equalTo: topAnchor),
                cardContentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                cardContentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                cardContentView.bottomAnchor.constraint(equalTo: bottomAnchor),
                titleLabel.topAnchor.constraint(equalTo: cardContentView.topAnchor, constant: 20),
                titleLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 16),
                subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
                subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
                iconView.topAnchor.constraint(equalTo: cardContentView.topAnchor, constant: 16),
                iconView.leadingAnchor.constraint(equalTo: cardContentView.leadingAnchor, constant: 20),
                iconView.bottomAnchor.constraint(equalTo: cardContentView.bottomAnchor, constant: -20),
                iconView.widthAnchor.constraint(equalToConstant: 40),
                iconView.heightAnchor.constraint(equalTo: iconView.widthAnchor),
                closeImage.trailingAnchor.constraint(equalTo: cardContentView.trailingAnchor, constant: -16),
                closeImage.topAnchor.constraint(equalTo: cardContentView.topAnchor, constant: 16),
                closeImage.widthAnchor.constraint(equalToConstant: 24),
                closeImage.heightAnchor.constraint(equalTo: closeImage.widthAnchor),
                titleLabelTrailingAnchorWithoutCloseButton,
                subtitleLabelTrailingAnchorWithoutCloseButton
            ]
        )
    }

    @objc func didClose() {
        didCloseClosure?()
    }
}
