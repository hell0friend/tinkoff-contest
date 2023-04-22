//
//  TCSButton.swift
//  Tinkoff-Contest
//
//  Created by Alexander Mironov on 22.04.2023.
//

import UIKit

public final class CardContentView: UIView {

    public override init(frame: CGRect) {
        super.init(frame: frame)

        layer.cornerRadius = 24
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CardContentView: ConfigurableItem {

    public func configure(with object: Any) {
        guard let viewModel = object as? ViewModel else { return }

        switch viewModel.backgroundStyle {
        case .white:
            backgroundColor = .white
            dropShadow(
                radius: 34,
                color: UIColor(red: 0, green: 0, blue: 0, alpha: 0.12),
                opacity: 1,
                offsetY: 6
            )
        case .grey:
            backgroundColor = UIColor(red: 246 / 255, green: 247 / 255, blue: 248 / 255, alpha: 1)
            removeShadow()
        }
    }
}
