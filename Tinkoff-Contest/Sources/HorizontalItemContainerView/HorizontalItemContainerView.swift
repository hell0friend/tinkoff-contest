//
//  HorizontalItemContainerView.swift
//  Tinkoff-Contest
//
//  Created by Alexander Mironov on 22.04.2023.
//

import UIKit

public final class HorizontalItemContainerView: UIView {

    private let cardContentView = CardContentView().forAutoLayout()
    private let titleLabel = UILabel().forAutoLayout()
    private let topButton = UIButton().forAutoLayout()
    private let itemsStackView = UIStackView().forAutoLayout()
    private let scrollView = UIScrollView().forAutoLayout()
    private let scrollContentView = UIView().forAutoLayout()

    private lazy var bottomConstraintWithoutButton = scrollView.bottomAnchor.constraint(
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

extension HorizontalItemContainerView: ConfigurableItem {

    public func configure(with object: Any) {
        guard let viewModel = object as? ViewModel else { return }

        titleLabel.text = viewModel.title
        topButton.setTitle(viewModel.topButtonConfiguration.text, for: .normal)
        didTapTopButtonClosure = viewModel.topButtonConfiguration.didTap

        itemsStackView.arrangedSubviews.forEach { itemsStackView.removeArrangedSubview($0) }
        viewModel.items.forEach { item in
            let itemView = HorizontalItemView().forAutoLayout()
            itemView.configure(with: item)
            itemsStackView.addArrangedSubview(itemView)
        }

        if let bottomButtonConfiguration = viewModel.bottomButtonConfiguration {
            bottomConstraintWithoutButton.isActive = false
        } else {
            bottomConstraintWithoutButton.isActive = true
        }

        layoutIfNeeded()
    }
}

private extension HorizontalItemContainerView {

    func configureSubviews() {
        cardContentView.configure(with: CardContentView.ViewModel(backgroundStyle: .white))
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        topButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        topButton.setTitleColor(UIColor(red: 0.259, green: 0.545, blue: 0.976, alpha: 1), for: .normal)
        itemsStackView.spacing = 12
        itemsStackView.axis = .horizontal
        topButton.addTarget(self, action: #selector(didTapTopButton), for: .touchUpInside)
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentInset.left = 20
        scrollView.contentInset.right = 20
    }

    func addSubviews() {
        addSubview(cardContentView)
        cardContentView.addSubview(titleLabel)
        cardContentView.addSubview(topButton)
        cardContentView.addSubview(scrollView)
        scrollView.addSubview(scrollContentView)
        scrollContentView.addSubview(itemsStackView)
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
                scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
                scrollView.leadingAnchor.constraint(equalTo: cardContentView.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: cardContentView.trailingAnchor),
                scrollView.heightAnchor.constraint(equalToConstant: 140),
                scrollContentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                scrollContentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                scrollContentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                scrollContentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                scrollContentView.heightAnchor.constraint(equalToConstant: 140),
                scrollContentView.topAnchor.constraint(equalTo: itemsStackView.topAnchor),
                scrollContentView.leadingAnchor.constraint(equalTo: itemsStackView.leadingAnchor),
                scrollContentView.trailingAnchor.constraint(equalTo: itemsStackView.trailingAnchor),
                scrollContentView.bottomAnchor.constraint(equalTo: itemsStackView.bottomAnchor),
                bottomConstraintWithoutButton
            ]
        )
    }

    @objc func didTapTopButton() {
        didTapTopButtonClosure?()
    }
}
