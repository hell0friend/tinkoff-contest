//
//  HeaderViewViewModel.swift
//  Tinkoff-Contest
//
//  Created by Alexander Mironov on 22.04.2023.
//

extension RightIconHeaderView {

    public struct ViewModel {

        public enum State {
            case title(String)
            case titleAndDescription(title: String, description: String)
            case button(title: String, description: String, buttonText: String, buttonAction: (() -> Void)?)
        }

        public enum ColorStyle {
            case white
            case grey
        }

        let state: State
        let icon: UIImage
        let colorStyle: ColorStyle

        public init(state: State, icon: UIImage, colorStyle: ColorStyle) {
            self.state = state
            self.icon = icon
            self.colorStyle = colorStyle
        }
    }
}
