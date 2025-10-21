public import SwiftUI

/// This extension is used for localResource.
public extension KImage {
    /// Local image resource.
    struct LocalResource: KImageResource {
        /// Name of the local asset.
        public var name: String
        /// Bundle where the asset is located.
        public var bundle: Bundle?

        /// LocalResource init.
        /// - Parameters:
        ///   - name: name of the asset.
        ///   - bundle: bundle where the asset is located.
        public init(name: String, bundle: Bundle? = nil) {
            self.name = name
            self.bundle = bundle
        }

        /// It compares this resource with another one to determine equality.
        ///
        /// - Parameter other: another image resource to compare with.
        /// - Returns: `true` if the resources are equivalent, `false` otherwise.
        public func isEqual(to other: KImageResource) -> Bool {
            guard let other = other as? LocalResource else {
                return false
            }
            return name == other.name && bundle == other.bundle
        }
    }
}
