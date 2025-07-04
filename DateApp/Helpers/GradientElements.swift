import UIKit

import UIKit

enum GradientElements {
    static func suscribeButtonGradient(frame: CGRect, cornerRadius: CGFloat = 24) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = [
            UIColor.lightGreen.cgColor,
            UIColor.lightCyan.cgColor
        ]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradient.cornerRadius = cornerRadius
        return gradient
    }
}

