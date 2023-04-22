//
//  RightIconHeaderView.swift
//  Tinkoff-Contest
//
//  Created by Alexander Mironov on 22.04.2023.
//

import UIKit

public final class RightIconHeaderView: UIView {

    private let cardContentView = UIView().forAutoLayout()
    private let labelsStackView = UIStackView().forAutoLayout()
    private let titleLabel = UILabel().forAutoLayout()
    private let subtitleLabel = UILabel().forAutoLayout()
    private let iconView = UIImageView().forAutoLayout()
    private let button = TCSButton().forAutoLayout()

    // Для состояния title
    private lazy var titleCenterYConstraint = titleLabel.centerYAnchor.constraint(
        equalTo: cardContentView.centerYAnchor
    )
    private lazy var iconViewBottomConstraint = iconView.bottomAnchor.constraint(
        equalTo: cardContentView.bottomAnchor,
        constant: -16
    )

    // Для состояния titleAndDescription и button
    private lazy var titleTopConstraint = titleLabel.topAnchor.constraint(
        equalTo: cardContentView.topAnchor,
        constant: 16
    )

    // Для состояния titleAndDescription
    private lazy var subtitleBottomConstraint = subtitleLabel.bottomAnchor.constraint(
        equalTo: cardContentView.bottomAnchor,
        constant: -18
    )

    // Для состояния button
    private lazy var buttonBottomConstraint = button.bottomAnchor.constraint(
        equalTo: cardContentView.bottomAnchor,
        constant: -20
    )
    private lazy var buttonTopConstraint = button.topAnchor.constraint(
        equalTo: subtitleLabel.bottomAnchor,
        constant: 14
    )

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

extension RightIconHeaderView: ConfigurableItem {
    public func configure(with object: Any) {
        guard let viewModel = object as? ViewModel else { return }

        iconView.image = viewModel.icon

        switch viewModel.state {
        case let .title(title):
            titleLabel.text = title

            titleCenterYConstraint.isActive = true
            iconViewBottomConstraint.isActive = true
            titleTopConstraint.isActive = false
            subtitleBottomConstraint.isActive = false
            buttonBottomConstraint.isActive = false
            buttonTopConstraint.isActive = false

            subtitleLabel.isHidden = true
            button.isHidden = true

        case let .titleAndDescription(title, description):
            titleLabel.text = title
            subtitleLabel.text = description

            titleCenterYConstraint.isActive = false
            iconViewBottomConstraint.isActive = false
            titleTopConstraint.isActive = true
            subtitleBottomConstraint.isActive = true
            buttonBottomConstraint.isActive = false
            buttonTopConstraint.isActive = false

            subtitleLabel.isHidden = false
            button.isHidden = true

        case let .button(title, description, buttonText, buttonAction):
            titleLabel.text = title
            subtitleLabel.text = description
            button.setTitle(buttonText, for: .normal)
            button.didTapClosure = buttonAction

            titleCenterYConstraint.isActive = false
            iconViewBottomConstraint.isActive = false
            titleTopConstraint.isActive = true
            subtitleBottomConstraint.isActive = false
            buttonBottomConstraint.isActive = true
            buttonTopConstraint.isActive = true

            subtitleLabel.isHidden = false
            button.isHidden = false
        }

        switch viewModel.backgroundStyle {
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

        layoutIfNeeded()
    }
}

private extension RightIconHeaderView {

    func configureViews() {
        cardContentView.layer.cornerRadius = 24
        button.backgroundColor = UIColor(red: 0, green: 0.063, blue: 0.141, alpha: 0.03)
        titleLabel.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        subtitleLabel.textColor = UIColor(red: 146 / 255, green: 153 / 255, blue: 162 / 255, alpha: 1)
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        subtitleLabel.font = .systemFont(ofSize: 15, weight: .regular)
    }

    func addSubviews() {
        addSubview(cardContentView)
        cardContentView.addSubview(labelsStackView)
        cardContentView.addSubview(titleLabel)
        cardContentView.addSubview(subtitleLabel)
        cardContentView.addSubview(iconView)
        cardContentView.addSubview(button)
    }

    func activateConstraints() {
        NSLayoutConstraint.activate(
            [
                cardContentView.topAnchor.constraint(equalTo: topAnchor),
                cardContentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                cardContentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                cardContentView.bottomAnchor.constraint(equalTo: bottomAnchor),

                titleLabel.leadingAnchor.constraint(
                    equalTo: cardContentView.leadingAnchor,
                    constant: 20
                ),
                titleLabel.trailingAnchor.constraint(
                    equalTo: iconView.leadingAnchor,
                    constant: -16
                ),

                subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
                subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
                subtitleLabel.trailingAnchor.constraint(
                    equalTo: iconView.leadingAnchor,
                    constant: -16
                ),
                button.leadingAnchor.constraint(equalTo: cardContentView.leadingAnchor, constant: 20),
                button.trailingAnchor.constraint(equalTo: cardContentView.trailingAnchor, constant: -20),
                iconView.topAnchor.constraint(equalTo: cardContentView.topAnchor, constant: 16),
                iconView.trailingAnchor.constraint(equalTo: cardContentView.trailingAnchor, constant: -16),
                iconView.widthAnchor.constraint(equalToConstant: 40),
                iconView.heightAnchor.constraint(equalTo: iconView.widthAnchor),
                titleCenterYConstraint,
                iconViewBottomConstraint
            ]
        )
    }
}
