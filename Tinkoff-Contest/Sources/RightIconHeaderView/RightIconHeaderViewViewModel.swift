//
//  RightIconHeaderViewViewModel.swift
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

        let state: State
        let icon: UIImage
        let backgroundStyle: BackgroundStyle

        public init(state: State, icon: UIImage, backgroundStyle: BackgroundStyle) {
            self.state = state
            self.icon = icon
            self.backgroundStyle = backgroundStyle
        }
    }
}
