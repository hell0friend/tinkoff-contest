//
//  TCSButton.swift
//  Tinkoff-Contest
//
//  Created by Alexander Mironov on 22.04.2023.
//

import UIKit

public final class VerticalItemContainerView: UIView {

    private let cardContentView = UIView().forAutoLayout()
    private let titleLabel = UILabel().forAutoLayout()
    private let button = UIButton().forAutoLayout()
    private let leftIconsStackView = UIStackView().forAutoLayout()
}

extension VerticalItemContainerView: ConfigurableItem {

    public func configure(with object: Any) {
        guard let viewModel = object as? ViewModel else { return }
    }
}


private extension VerticalItemContainerView {

    func addSubviews() {
        addSubview(cardContentView)
        cardContentView.addSubview(titleLabel)
        cardContentView.addSubview(button)
        cardContentView.addSubview(leftIconsStackView)
    }
}
