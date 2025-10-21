public import SwiftUI

/// This extension is used for dataResource.
public extension KImage {
    /// Resource from raw data.
    struct DataResource: KImageResource, Equatable {
        /// Raw data with the content of the image.
        public var data: Data
        /// DataResource init.
        /// 
        /// - Parameter data: raw data with the content of the image.
        public init(data: Data) {
            self.data = data
        }

        /// It compares this resource with another one to determine equality.
        ///
        /// - Parameter other: another image resource to compare with.
        /// - Returns: `true` if the resources are equivalent, `false` otherwise.
        public func isEqual(to other: KImageResource) -> Bool {
            guard let other = other as? DataResource else {
                return false
            }
            return data == other.data
        }
    }
}
