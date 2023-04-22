//
//  LeftIconHeaderViewViewModel.swift
//  Tinkoff-Contest
//
//  Created by Alexander Mironov on 22.04.2023.
//

import UIKit

extension LeftIconHeaderView {

    public struct ViewModel {

        public enum CloseStyle {
            case none(BackgroundStyle)
            case action(didClose: () -> Void, image: UIImage)
        }

        let title: String
        let description: String
        let icon: UIImage
        let closeStyle: CloseStyle

        public init(title: String, description: String, icon: UIImage, closeStyle: CloseStyle) {
            self.title = title
            self.description = description
            self.icon = icon
            self.closeStyle = closeStyle
        }
    }
}
