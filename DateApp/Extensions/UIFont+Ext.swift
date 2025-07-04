import UIKit

extension UIFont {
    enum fontName: String {
        case latoBold = "Lato-Bold"
        case latoExtraBold = "Lato-ExtraBold"
        case latoRegular = "Lato-Regular"
        case latoSemibold = "Lato-SemiBold"
        case interSemiBold = "Inter-SemiBold"
    }

    static func customFont(
        _ font: fontName,
        size: CGFloat,
        style: UIFont.TextStyle? = nil
    ) -> UIFont {
        guard let customFont = UIFont(name: font.rawValue, size: size) else {
            print("cant find \(font.rawValue). using system font.")
            return UIFont.systemFont(ofSize: size)
        }

        if let style = style {
            let metrics = UIFontMetrics(forTextStyle: style)
            return metrics.scaledFont(for: customFont)
        }
        return customFont
    }
}
