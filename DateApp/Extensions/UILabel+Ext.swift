import UIKit

extension UILabel {
    func setLetterSpacing(_ spacing: CGFloat) {
        guard let text = self.text else { return }
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(
            .kern,
            value: spacing,
            range: NSRange(location: 0, length: text.count)
        )
        self.attributedText = attributedString
    }
}
