import UIKit

final class GradientView: UIView {
    private let firstGradient = CAGradientLayer()
    private let secondGradient = CAGradientLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
    }

    private func setupLayers() {
        firstGradient.colors = [
            UIColor.bgLightBlue.cgColor,
            UIColor.bgLightPurple.cgColor
        ]
        firstGradient.startPoint = CGPoint(x: 0.5, y: 1)
        firstGradient.endPoint = CGPoint(x: 0.5, y: 0)
        layer.addSublayer(firstGradient)

        secondGradient.colors = [
            UIColor.bgGreen.cgColor,
            UIColor.bgPink.cgColor
        ]
        secondGradient.startPoint = CGPoint(x: 0.5, y: 1)
        secondGradient.endPoint = CGPoint(x: 0.5, y: 0)
        secondGradient.opacity = 0.35
        secondGradient.compositingFilter = "overlayBlendMode"
        layer.addSublayer(secondGradient)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        firstGradient.frame = bounds
        secondGradient.frame = bounds
    }
}
