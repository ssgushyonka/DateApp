import UIKit

enum PaywallStepConstants {
    static let imageHeightMult: CGFloat = Device.isiPhoneSE ? 0.65 : 1.2
    static let textLeading: CGFloat = 22
    static let textTop: CGFloat = 101
    static let textHeight: CGFloat = 58
    static let topImageSpace: CGFloat = 5
}

enum Device {
    static var isiPhoneSE: Bool {
        return UIScreen.main.bounds.height <= 667
    }
}
