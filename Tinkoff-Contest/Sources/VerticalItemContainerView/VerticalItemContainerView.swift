//
//  TCSButton.swift
//  Tinkoff-Contest
//
//  Created by Alexander Mironov on 22.04.2023.
//

import UIKit

public final class VerticalItemContainerView: UIView {

    private let cardContentView = CardContentView().forAutoLayout()
    private let titleLabel = UILabel().forAutoLayout()
    private let button = UIButton().forAutoLayout()
    private let itemsStackView = UIStackView().forAutoLayout()

    private var didTapButtonClosure: (() -> Void)?

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
        button.setTitle(viewModel.buttonTitle, for: .normal)
        didTapButtonClosure = viewModel.buttonAction

        itemsStackView.arrangedSubviews.forEach { itemsStackView.removeArrangedSubview($0) }

        viewModel.items.forEach { item in
            let itemView = VerticalItemView().forAutoLayout()
            itemView.configure(with: item)
            itemsStackView.addArrangedSubview(itemView)
        }

        cardContentView.configure(with: CardContentView.ViewModel(backgroundStyle: viewModel.backgroundStyle))
    }
}


private extension VerticalItemContainerView {

    func configureSubviews() {
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        button.setTitleColor(UIColor(red: 0.259, green: 0.545, blue: 0.976, alpha: 1), for: .normal)
        itemsStackView.spacing = 4
        itemsStackView.axis = .vertical
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }

    func addSubviews() {
        addSubview(cardContentView)
        cardContentView.addSubview(titleLabel)
        cardContentView.addSubview(button)
        cardContentView.addSubview(itemsStackView)
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
                titleLabel.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: -16),
                button.topAnchor.constraint(equalTo: cardContentView.topAnchor, constant: 18),
                button.trailingAnchor.constraint(equalTo: cardContentView.trailingAnchor, constant: -20),
                button.heightAnchor.constraint(equalToConstant: 20),
                itemsStackView.leadingAnchor.constraint(equalTo: cardContentView.leadingAnchor, constant: 4),
                itemsStackView.trailingAnchor.constraint(equalTo: cardContentView.trailingAnchor, constant: -4),
                itemsStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
                itemsStackView.bottomAnchor.constraint(equalTo: cardContentView.bottomAnchor, constant: -12)
            ]
        )
    }

    @objc func didTapButton() {
        didTapButtonClosure?()
    }
}
