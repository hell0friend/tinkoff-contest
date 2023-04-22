//
//  VerticalItemViewModel.swift
//  Tinkoff-Contest
//
//  Created by Alexander Mironov on 22.04.2023.
//

import UIKit

extension VerticalItemView {

    public struct ViewModel {

        let icon: UIImage
        let title: String
        let description: String
        let didSelect: () -> Void

        /// icon: Иконка слева
        /// title: Заголовок
        /// description: Подзаголовок, описание
        /// didSelect: Замыкание, вызывающееся при нажатии на область View
        public init(icon: UIImage, title: String, description: String, didSelect: @escaping () -> Void) {
            self.icon = icon
            self.title = title
            self.description = description
            self.didSelect = didSelect
        }
    }
}
