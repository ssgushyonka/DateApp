import Foundation

enum PaywallLayout {
    enum Ellipse {
        static let width: CGFloat = 1270
        static let height: CGFloat = 732
        static let xPosition: CGFloat = -447
        static let bottomInset: CGFloat = 222
    }

    enum Labels {
        static let mainLabelHeight: CGFloat = 24
        static let subLabelHeight: CGFloat = 18
        static let letterSpacing: CGFloat = 0.5

        enum Insets {
            static let mainLabelLeading: CGFloat = 60
            static let mainLabelTrailing: CGFloat = 60
            static let subLabelLeading: CGFloat = 26
            static let subLabelTrailing: CGFloat = 24
        }

        enum Spacing {
            static let bottomPageControl: CGFloat = 38
            static let betweenLabels: CGFloat = 6
        }
    }

    enum PageControl {
        static let bottomInset: CGFloat = 243
    }

    enum Buttons {
        static let cornerRadius: CGFloat = 24
        static let closeButtonSize: CGFloat = 26
        static let closeButtonTop: CGFloat = 45
        static let closeButtonLeading: CGFloat = 19
        
        static let restoreButtonWidth: CGFloat = 63
        static let restoreButtonTop: CGFloat = 46
        static let restoreButtonTrailing: CGFloat = -24
        
        static let subButtonHeight: CGFloat = 48
        static let subButtonLeading: CGFloat = 32
        static let subButtonTopSpace: CGFloat = 19
    }
}

enum PaywallStrings {
    enum MainLabel {
        static let text = "Subscribe for $0.99 weekly"
    }

    enum SubLabel {
        static let text = "Plan automatically renews. Cancel anytime."
    }

    enum Buttons {
        static let suscribeTitle = "Subscribe"
        static let restoreTitle = "Restore"
    }
}
