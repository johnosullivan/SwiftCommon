
import Foundation

/// An enumerator for the contents of a directory that returns the paths of all
/// files and directories contained within that directory.
public struct DirectoryEnumerator: GeneratorType {

    private let _path: Path, _enumerator: NSDirectoryEnumerator?

    /// Creates a directory enumerator for the given path.
    ///
    /// - Parameter path: The path a directory enumerator to be created for.
    public init(path: Path) {
        _path = path
        _enumerator = NSFileManager().enumeratorAtPath(path._safeRawValue)
    }

    /// Returns the next path in the enumeration.
    public func next() -> Path? {
        guard let next = _enumerator?.nextObject() as? String else {
            return nil
        }
        return _path + next
    }

    /// Skip recursion into the most recently obtained subdirectory.
    public func skipDescendants() {
        _enumerator?.skipDescendants()
    }
}
