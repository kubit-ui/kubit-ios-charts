// swiftlint:disable:this file_name
public import SwiftUI

/// This extension provides style for the component.
public extension KLine.Style {
    /// Background configuration of the model.
    struct Background: Equatable {
        let type: BackgroundType
        /// Y-axis threshold value that defines the boundary for background application.
        /// Background is applied from Y values down to this threshold value.
        public let yThreshold: CGFloat

        enum BackgroundType: Equatable {
            case plain(color: Color)
            case linearGradient(_ gradient: Gradient, startPoint: UnitPoint, endPoint: UnitPoint)
            case radialGradient(_ gradient: Gradient, center: UnitPoint, startRadius: CGFloat, endRadius: CGFloat)
        }

        /// Plain background.
        /// - Parameters:
        ///   - color: color for the background.
        ///   - yThreshold: background that is applied from Y values to yThreshold. `.zero` by default.
        public static func plain(color: Color, yThreshold: CGFloat = .zero) -> Background {
            Background(type: .plain(color: color), yThreshold: yThreshold)
        }

        /// Linear gradient background.
        /// - Parameters:
        ///   - gradient: gradient that is used to fill the line.
        ///   - startPoint: it represents the initial point of the gradient. `.top` by  default.
        ///   - endPoint: represents the final point of the gradient.  `.bottom` by  default.
        ///   - yThreshold: gradient that is applied from Y values to yThreshold. `.zero` by default.
        public static func linearGradient(_ gradient: Gradient,
                                          startPoint: UnitPoint = .top,
                                          endPoint: UnitPoint = .bottom,
                                          yThreshold: CGFloat = .zero) -> Background {
            Background(type: .linearGradient(gradient, startPoint: startPoint, endPoint: endPoint), yThreshold: yThreshold)
        }

        /// Radial gradient background.
        /// - Parameters:
        ///   - gradient: gradient that will be used to fill the line.
        ///   - center: center of the gradient. `.center` by default.
        ///   - startRadius: initial radius of the gradient.
        ///   - endRadius: final radius of the gradient.
        ///   - yThreshold: gradient will be applied from Y values to yThreshold. `.zero` by default.
        public static func radialGradient(_ gradient: Gradient,
                                          center: UnitPoint = .center,
                                          startRadius: CGFloat,
                                          endRadius: CGFloat,
                                          yThreshold: CGFloat = .zero) -> Background {
            Background(
                type: .radialGradient(gradient, center: center, startRadius: startRadius, endRadius: endRadius),
                yThreshold: yThreshold)
        }
    }
}
