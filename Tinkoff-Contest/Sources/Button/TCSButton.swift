//
//  TCSButton.swift
//  Tinkoff-Contest
//
//  Created by Alexander Mironov on 22.04.2023.
//

import UIKit

public final class TCSButton: UIButton {

    public init(height: CGFloat? = 44) {
        super.init(frame: .zero)

        layer.cornerRadius = 12
        setTitleColor(UIColor(red: 0.259, green: 0.545, blue: 0.976, alpha: 1), for: .normal)
        setTitleColor(UIColor(red: 0.259, green: 0.545, blue: 0.976, alpha: 1), for: .highlighted)

        setBackgroundColor(color: UIColor(red: 0, green: 0.063, blue: 0.141, alpha: 0.03), forState: .normal)
        setBackgroundColor(color: UIColor(red: 0, green: 0.063, blue: 0.141, alpha: 0.06), forState: .highlighted)

        if let height = height {
            translatesAutoresizingMaskIntoConstraints = false
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        self.clipsToBounds = true
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.setBackgroundImage(colorImage, for: forState)
        }
    }
}
