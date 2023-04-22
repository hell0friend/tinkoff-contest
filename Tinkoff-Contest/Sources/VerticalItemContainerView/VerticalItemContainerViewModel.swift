//
//  TCSButton.swift
//  Tinkoff-Contest
//
//  Created by Alexander Mironov on 22.04.2023.
//

import UIKit

extension VerticalItemContainerView {

    public struct ViewModel {

        let title: String
        let buttonTitle: String
        let buttonAction: () -> Void
        let items: [VerticalItemView.ViewModel]
        let backgroundStyle: BackgroundStyle

        public init(
            title: String,
            buttonTitle: String,
            backgroundStyle: BackgroundStyle,
            buttonAction: @escaping () -> Void,
            items: [VerticalItemView.ViewModel]
        ) {
            self.title = title
            self.buttonTitle = buttonTitle
            self.buttonAction = buttonAction
            self.items = items
            self.backgroundStyle = backgroundStyle
        }
    }
}
