//
//  VerticalItemView.swift
//  Tinkoff-Contest
//
//  Created by Alexander Mironov on 22.04.2023.
//

import UIKit

public final class VerticalItemView: UIView {

    private let iconView = UIImageView().forAutoLayout()
    private let titleLabel = UILabel().forAutoLayout()
    private let subtitleLabel = UILabel().forAutoLayout()

    private var didTapClosure: (() -> Void)?

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

extension VerticalItemView: ConfigurableItem {

    public func configure(with object: Any) {
        guard let viewModel = object as? ViewModel else { return }

        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.description
        iconView.image = viewModel.icon
        didTapClosure = viewModel.didSelect
    }
}

private extension VerticalItemView {

    func configureSubviews() {
        titleLabel.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        subtitleLabel.textColor = UIColor(red: 0.573, green: 0.6, blue: 0.635, alpha: 1)
        titleLabel.font = .systemFont(ofSize: 17, weight: .regular)
        subtitleLabel.font = .systemFont(ofSize: 13, weight: .regular)

        let tapGesture = UITapGestureRecognizer()
        isUserInteractionEnabled = true
        addGestureRecognizer(tapGesture)
        tapGesture.addTarget(self, action: #selector(didTap))
    }

    func addSubviews() {
        addSubview(iconView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
    }

    func activateConstraints() {

        NSLayoutConstraint.activate(
            [
                titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
                titleLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 16),
                subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
                subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
                titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                iconView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
                iconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                iconView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
                iconView.widthAnchor.constraint(equalToConstant: 40),
                iconView.heightAnchor.constraint(equalTo: iconView.widthAnchor),

            ]
        )
    }

    @objc func didTap() {
        didTapClosure?()
    }
}
