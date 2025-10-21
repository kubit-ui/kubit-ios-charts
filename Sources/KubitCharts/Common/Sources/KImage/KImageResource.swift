/// Resource abstraction to be used in ``KImage``.
public protocol KImageResource {
    /// It compares this resource with another one to determine equality.
    ///
    /// - Parameter other: another image resource to compare with.
    /// - Returns: `true` if the resources are equivalent, `false` otherwise.
    func isEqual(to other: KImageResource) -> Bool
}

extension KImageResource {
    var type: KImageResourceType {
        if self is KImage.LocalResource {
            KImageResourceType.local
        } else if self is KImage.DataResource {
            KImageResourceType.data
        } else {
            KImageResourceType.unknown
        }
    }
}

enum KImageResourceType {
    case local
    case data
    case unknown
}
