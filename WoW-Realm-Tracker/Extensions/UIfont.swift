import UIKit

let applicationFont = "Din Alternate"

extension UIFont {
    static func headlineFont() -> UIFont? {
        let preferredHeadline = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        return UIFont(name: applicationFont, size: preferredHeadline.pointSize)
    }

    static func captionFont() -> UIFont? {
        let preferredCaption = UIFont.preferredFontForTextStyle(UIFontTextStyleCaption1)
        return UIFont(name: applicationFont, size: preferredCaption.pointSize)
    }

    static func bodyFont() -> UIFont? {
        let preferredBody = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        return UIFont(name: applicationFont, size: preferredBody.pointSize)
    }
}
