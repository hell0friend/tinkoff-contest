//
//  VerticalItemContainerView.swift
//  Tinkoff-Contest
//
//  Created by Alexander Mironov on 22.04.2023.
//

import UIKit

public final class VerticalItemContainerView: UIView {

    private let cardContentView = CardContentView().forAutoLayout()
    private let titleLabel = UILabel().forAutoLayout()
    private let topButton = UIButton().forAutoLayout()
    private let itemsStackView = UIStackView().forAutoLayout()
    private let bottomButton = TCSButton().forAutoLayout()

    private lazy var stackViewBottomConstraintWithoutBottomButton = itemsStackView.bottomAnchor.constraint(
        equalTo: cardContentView.bottomAnchor,
        constant: -12
    )

    private lazy var bottomButtonTopConstraint = bottomButton.topAnchor.constraint(
        equalTo: itemsStackView.bottomAnchor,
        constant: 12
    )
    private lazy var bottomButtonBottomConstraint = bottomButton.bottomAnchor.constraint(
        equalTo: cardContentView.bottomAnchor,
        constant: -20
    )

    private var didTapTopButtonClosure: (() -> Void)?
    private var didTapBottomButtonClosure: (() -> Void)?

    public override init(frame: CGRect) {
        super.init(frame: frame)

        configureSubviews()
        addSubviews()
        activateConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension VerticalItemContainerView: ConfigurableItem {

    public func configure(with object: Any) {
        guard let viewModel = object as? ViewModel else { return }

        titleLabel.text = viewModel.title
        topButton.setTitle(viewModel.topButtonConfiguration.text, for: .normal)
        didTapTopButtonClosure = viewModel.topButtonConfiguration.didTap

        itemsStackView.arrangedSubviews.forEach { itemsStackView.removeArrangedSubview($0) }

        viewModel.items.forEach { item in
            let itemView = VerticalItemView().forAutoLayout()
            itemView.configure(with: item)
            itemsStackView.addArrangedSubview(itemView)
        }

        cardContentView.configure(with: CardContentView.ViewModel(backgroundStyle: viewModel.backgroundStyle))

        if let bottomButtonConfiguration = viewModel.bottomButtonConfiguration {
            bottomButton.isHidden = false
            bottomButton.didTapClosure = bottomButtonConfiguration.didTap
            bottomButton.setTitle(bottomButtonConfiguration.text, for: .normal)
            bottomButton.setTitle(bottomButtonConfiguration.text, for: .highlighted)
            stackViewBottomConstraintWithoutBottomButton.isActive = false
            bottomButtonTopConstraint.isActive = true
            bottomButtonBottomConstraint.isActive = true
        } else {
            bottomButton.isHidden = true
            stackViewBottomConstraintWithoutBottomButton.isActive = true
            bottomButtonTopConstraint.isActive = false
            bottomButtonBottomConstraint.isActive = false
        }

        layoutIfNeeded()
    }
}

private extension VerticalItemContainerView {

    func configureSubviews() {
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = TCSColors.defaultTitleColor
        topButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        topButton.setTitleColor(TCSColors.defaultButtonTextColor, for: .normal)
        itemsStackView.spacing = 4
        itemsStackView.axis = .vertical
        topButton.addTarget(self, action: #selector(didTapTopButton), for: .touchUpInside)
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }

    func addSubviews() {
        addSubview(cardContentView)
        cardContentView.addSubview(titleLabel)
        cardContentView.addSubview(topButton)
        cardContentView.addSubview(itemsStackView)
        cardContentView.addSubview(bottomButton)
    }

    func activateConstraints() {
        NSLayoutConstraint.activate(
            [
                cardContentView.topAnchor.constraint(equalTo: topAnchor),
                cardContentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                cardContentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                cardContentView.bottomAnchor.constraint(equalTo: bottomAnchor),
                titleLabel.topAnchor.constraint(equalTo: cardContentView.topAnchor, constant: 16),
                titleLabel.leadingAnchor.constraint(equalTo: cardContentView.leadingAnchor, constant: 20),
                titleLabel.trailingAnchor.constraint(equalTo: topButton.leadingAnchor, constant: -16),
                topButton.topAnchor.constraint(equalTo: cardContentView.topAnchor, constant: 18),
                topButton.trailingAnchor.constraint(equalTo: cardContentView.trailingAnchor, constant: -20),
                topButton.heightAnchor.constraint(equalToConstant: 20),
                itemsStackView.leadingAnchor.constraint(equalTo: cardContentView.leadingAnchor, constant: 4),
                itemsStackView.trailingAnchor.constraint(equalTo: cardContentView.trailingAnchor, constant: -4),
                itemsStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
                bottomButton.leadingAnchor.constraint(equalTo: cardContentView.leadingAnchor, constant: 20),
                bottomButton.trailingAnchor.constraint(equalTo: cardContentView.trailingAnchor, constant: -20),
                stackViewBottomConstraintWithoutBottomButton
            ]
        )
    }

    @objc func didTapTopButton() {
        didTapTopButtonClosure?()
    }
}
