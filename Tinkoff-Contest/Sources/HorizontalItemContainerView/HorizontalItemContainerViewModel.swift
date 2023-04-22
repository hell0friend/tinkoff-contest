//
//  TCSButton.swift
//  Tinkoff-Contest
//
//  Created by Alexander Mironov on 22.04.2023.
//

import UIKit

extension HorizontalItemContainerView {

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
        let items: [HorizontalItemView.ViewModel]
        let topButtonConfiguration: ButtonConfiguration
        let bottomButtonConfiguration: ButtonConfiguration?

        /// title: Заголовок
        /// topButtonConfiguration: Конфигурация для верхней кнопки
        /// bottomButtonConfiguration: Конфигурация для нижней кнопки. Если nil, то кнопка будет скрыта
        /// items: Модели для списка элементов
        public init(
            title: String,
            topButtonConfiguration: ButtonConfiguration,
            bottomButtonConfiguration: ButtonConfiguration?,
            items: [HorizontalItemView.ViewModel]
        ) {
            self.title = title
            self.topButtonConfiguration = topButtonConfiguration
            self.items = items
            self.bottomButtonConfiguration = bottomButtonConfiguration
        }
    }
}
