public import Foundation

/// This extension provides accessibility for the component.
public extension KCustomBackground {
    /// Custom background source.
    struct Source: Equatable {
        let type: SourceType

        enum SourceType: Equatable {
            case local(name: String, bundle: Bundle?)
            case remote(url: URL?)
        }

        /// It creates a local image background source with the specified image name and bundle.
        /// - Parameters:
        ///   - name: the name of the image.
        ///   - bundle: the bundle where the image is located.
        /// - Returns: a ``Source`` instance representing a local image background.
        public static func local(name: String, bundle: Bundle?) -> Source {
            Source(type: .local(name: name, bundle: bundle))
        }

        /// It creates a remote image background source with the specified URL.
        /// - Parameter url: the URL where the image is located.
        /// - Returns: a ``Source`` instance that represents a remote image background.
        public static func remote(url: URL?) -> Source {
            Source(type: .remote(url: url))
        }
    }
}
