//
//  HorizontalItemView.swift
//  Tinkoff-Contest
//
//  Created by Alexander Mironov on 22.04.2023.
//

import UIKit

public final class HorizontalItemView: UIView {

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

extension HorizontalItemView: ConfigurableItem {

    public func configure(with object: Any) {
        guard let viewModel = object as? ViewModel else { return }

        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.description
        iconView.image = viewModel.icon
        didTapClosure = viewModel.didSelect
    }
}

private extension HorizontalItemView {

    func configureSubviews() {
        layer.cornerRadius = 12
        backgroundColor = UIColor(red: 0, green: 0.063, blue: 0.141, alpha: 0.03)
        titleLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        subtitleLabel.font = .systemFont(ofSize: 13, weight: .regular)
        titleLabel.textColor = UIColor(red: 51 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1)
        subtitleLabel.textColor = UIColor(red: 51 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1)
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
                widthAnchor.constraint(equalToConstant: 140),
                heightAnchor.constraint(equalTo: widthAnchor),
                iconView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
                iconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
                iconView.widthAnchor.constraint(equalToConstant: 40),
                iconView.heightAnchor.constraint(equalTo: iconView.widthAnchor),
                subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
                subtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
                subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
                subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
                subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
                titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
            ]
        )
    }

    @objc func didTap() {
        didTapClosure?()
    }
}
