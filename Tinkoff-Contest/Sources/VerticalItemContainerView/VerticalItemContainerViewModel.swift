//
//  TCSButton.swift
//  Tinkoff-Contest
//
//  Created by Alexander Mironov on 22.04.2023.
//

import UIKit

extension VerticalItemContainerView {

    public struct ViewModel {

        public struct ButtonConfiguration {
            let text: String
            let didTap: () -> Void

            public init(text: String, didTap: @escaping () -> Void) {
                self.text = text
                self.didTap = didTap
            }
        }

        let title: String
        let items: [VerticalItemView.ViewModel]
        let backgroundStyle: BackgroundStyle
        let topButtonConfiguration: ButtonConfiguration
        let bottomButtonConfiguration: ButtonConfiguration?

        public init(
            title: String,
            backgroundStyle: BackgroundStyle,
            topButtonConfiguration: ButtonConfiguration,
            bottomButtonConfiguration: ButtonConfiguration?,
            items: [VerticalItemView.ViewModel]
        ) {
            self.title = title
            self.topButtonConfiguration = topButtonConfiguration
            self.items = items
            self.backgroundStyle = backgroundStyle
            self.bottomButtonConfiguration = bottomButtonConfiguration
        }
    }
}
