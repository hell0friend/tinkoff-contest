//
//  BackgroundStyle.swift
//  TinkoffContest
//
//  Created by Alexander Mironov on 22.04.2023.
//

/// Стиль для заднего фона
public enum BackgroundStyle {
    /// белый цвет, присутствует тень
    case white
    /// UIColor(red: 246 / 255, green: 247 / 255, blue: 248 / 255, alpha: 1), тень отстутсвует
    case grey

    var backgroundColor: UIColor {
        switch self {
        case .white:
            return .white
        case .grey:
            return UIColor(red: 246 / 255, green: 247 / 255, blue: 248 / 255, alpha: 1)
        }
    }
}
