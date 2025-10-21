public import SwiftUI

/// Color extension for hexadecimal initialization.
public extension Color {
    /// Optional SwiftUI.Color initialization.
    ///
    /// - Parameter hex: hexadecimal value. It can be similar to "#FFFFFF" or "FFFFFF". If there are 8 characters, the latest two represent an alpha channel value.
    /// - Returns: color if hex is resolved to a valid color. Nil otherwise.
    init?(hex: String) {
        var rawHex = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if rawHex.hasPrefix("#") {
            rawHex.remove(at: rawHex.startIndex)
        }
        var rgb: UInt64 = 0
        Scanner(string: rawHex).scanHexInt64(&rgb)
        let alpha, red, green, blue: CGFloat
        switch rawHex.count {
        case 6:
            red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            blue = CGFloat(rgb & 0x0000FF) / 255.0
            alpha = 1
        case 8:
            red = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            green = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            blue = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            alpha = CGFloat(rgb & 0x000000FF) / 255.0
        default:
            return nil
        }
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }

    /// Optional SwiftUI.Color initialization.
    ///
    /// - Parameter figmaHex: hexadecimal value. It can be similar to "#FFFFFF" or "FFFFFF".
    /// - Returns: color if hex is resolved to a valid color. Nil otherwise.
    init?(figmaHex: String) {
        var rawHex = figmaHex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if rawHex.hasPrefix("#") {
            rawHex.remove(at: rawHex.startIndex)
        }
        var rgb: UInt64 = 0
        Scanner(string: rawHex).scanHexInt64(&rgb)
        let alpha, red, green, blue: CGFloat
        switch rawHex.count {
        case 6:
            red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            blue = CGFloat(rgb & 0x0000FF) / 255.0
            alpha = 1
        case 8:
            alpha = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            red = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            green = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            blue = CGFloat(rgb & 0x000000FF) / 255.0
        default:
            return nil
        }
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }
}
