//
//  UIKitExtensions.swift
//  Tinkoff-Contest
//
//  Created by Alexander Mironov on 22.04.2023.
//

public extension UIView {

    func forAutoLayout() -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }

    func dropShadow(radius: CGFloat, color: UIColor, opacity: Float, offsetX: CGFloat = 0, offsetY: CGFloat = 0) {
        layer.shadowOffset = CGSize(width: offsetX, height: offsetY)
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
    }

    func removeShadow() {
        layer.shadowOpacity = 0.0
        layer.shadowOffset = .zero
    }
}
