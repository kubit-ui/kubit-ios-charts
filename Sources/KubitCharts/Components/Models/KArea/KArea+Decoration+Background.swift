// swiftlint:disable:this file_name
public import SwiftUI

/// This extension provides decoration for the component.
public extension KArea.Decoration {
    /// Background configuration for the model.
    struct Background: Equatable {
        let type: BackgroundType

        enum BackgroundType: Equatable {
            case plain(color: Color)
            case linearGradient(_ gradient: Gradient, startPoint: UnitPoint, endPoint: UnitPoint)
            case radialGradient(_ gradient: Gradient, center: UnitPoint, startRadius: CGFloat, endRadius: CGFloat)
        }

        /// It creates a plain background with the specified color.
        /// - Parameter color: the color for the background.
        /// - Returns: a``Background`` instance with a plain color.
        public static func plain(color: Color) -> Background {
            Background(type: .plain(color: color))
        }

        /// It creates a linear gradient background with the specified parameters.
        /// - Parameters:
        ///   - gradient: the gradient to fill the background.
        ///   - startPoint: the starting point of the gradient. `.top` by default.
        ///   - endPoint: the ending point of the gradient. `.bottom` by default.
        /// - Returns: a ``Background`` instance with a linear gradient.
        public static func linearGradient(_ gradient: Gradient,
                                          startPoint: UnitPoint = .top,
                                          endPoint: UnitPoint = .bottom) -> Background {
            Background(type: .linearGradient(gradient, startPoint: startPoint, endPoint: endPoint))
        }

        /// It creates a radial gradient background with the specified parameters.
        /// - Parameters:
        ///   - gradient: the gradient to fill the background.
        ///   - center: the center point of the gradient. `.center` by default.
        ///   - startRadius: the initial radius of the radial gradient.
        ///   - endRadius: the final radius of the radial gradient.
        /// - Returns: a ``Background`` instance with a radial gradient.
        public static func radialGradient(_ gradient: Gradient,
                                          center: UnitPoint = .center,
                                          startRadius: CGFloat,
                                          endRadius: CGFloat) -> Background {
            Background(type: .radialGradient(gradient, center: center, startRadius: startRadius, endRadius: endRadius))
        }
    }
}
