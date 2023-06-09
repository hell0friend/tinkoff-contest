//
//  LeftIconHeaderView.swift
//  Tinkoff-Contest
//
//  Created by Alexander Mironov on 22.04.2023.
//

import UIKit

public final class LeftIconHeaderView: UIView {

    private let cardContentView = CardContentView().forAutoLayout()
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
            cardContentView.configure(with: CardContentView.ViewModel(backgroundStyle: backgroundStyle))
        case let .action(didClose, image):
            closeImage.isHidden = false
            titleLabelTrailingAnchorWithoutCloseButton.isActive = false
            subtitleLabelTrailingAnchorWithoutCloseButton.isActive = false
            titleLabelTrailingAnchorWithCloseButton.isActive = true
            subtitleLabelTrailingAnchorWithCloseButton.isActive = true
            didCloseClosure = didClose
            closeImage.image = image

            cardContentView.configure(with: CardContentView.ViewModel(backgroundStyle: .white))
        }

        layoutIfNeeded()
    }
}

private extension LeftIconHeaderView {

    func configureViews() {
        titleLabel.textColor = TCSColors.defaultTitleColor
        subtitleLabel.textColor = TCSColors.defaultSubtitleColor
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
