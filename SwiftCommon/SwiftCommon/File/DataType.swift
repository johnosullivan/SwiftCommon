
import Foundation

/// A type that can be used to read from and write to File instances.
public typealias DataType = protocol<Readable, Writable>



/// A type that can be used to read from File instances.
public protocol Readable {

    /// Creates `Self` from the contents of a Path.
    ///
    /// - Parameter path: The path being read from.
    ///
    static func readFromPath(path: Path) throws -> Self

}

extension Readable {

    /// Initializes `self` from the contents of a Path.
    ///
    /// - Parameter path: The path being read from.
    ///
    public init(contentsOfPath path: Path) throws { // swiftlint:disable:this valid_docs
        self = try Self.readFromPath(path)
    }

}



/// A type that can be used to write to File instances.
public protocol Writable {

    /// Writes `self` to a Path.
    func writeToPath(path: Path) throws

    /// Writes `self` to a Path.
    ///
    /// - Parameter path: The path being written to.
    /// - Parameter useAuxiliaryFile: If `true`, the data is written to an
    ///                               auxiliary file that is then renamed to the
    ///                               file. If `false`, the data is written to
    ///                               the file directly.
    ///
    func writeToPath(path: Path, atomically useAuxiliaryFile: Bool) throws

}

extension Writable {

    /// Writes `self` to a Path atomically.
    ///
    /// - Parameter path: The path being written to.
    ///
    public func writeToPath(path: Path) throws { // swiftlint:disable:this valid_docs
        try writeToPath(path, atomically: true)
    }

}

/// A type that can be used to write to a String file path.
public protocol WritableToFile: Writable {

    /// Writes `self` to a String path.
    ///
    /// - Parameter path: The path being written to.
    /// - Parameter useAuxiliaryFile: If `true`, the data is written to an
    ///                               auxiliary file that is then renamed to the
    ///                               file. If `false`, the data is written to
    ///                               the file directly.
    ///
    /// - Returns: `true` if the writing completed successfully, or `false` if
    ///            the writing failed.
    ///
    func writeToFile(path: String, atomically useAuxiliaryFile: Bool) -> Bool

}



extension WritableToFile {

    /// Writes `self` to a Path.
    ///
    /// - Parameter path: The path being written to.
    /// - Parameter useAuxiliaryFile: If `true`, the data is written to an
    ///                               auxiliary file that is then renamed to the
    ///                               file. If `false`, the data is written to
    ///                               the file directly.
    ///
    /// - Throws: `FileKitError.WriteToFileFail`
    ///
    public func writeToPath(path: Path, atomically useAuxiliaryFile: Bool) throws {
        guard writeToFile(path._safeRawValue, atomically: useAuxiliaryFile) else {
            throw FileKitError.WriteToFileFail(path: path)
        }
    }

}



/// A type that can be converted to a Writable.
public protocol WritableConvertible: Writable {

    /// The type that allows `Self` to be `Writable`.
    associatedtype WritableType: Writable

    /// Allows `self` to be written to a path.
    var writable: WritableType { get }

}

extension WritableConvertible {

    /// Writes `self` to a Path.
    ///
    /// - Parameter path: The path being written to.
    /// - Parameter useAuxiliaryFile: If `true`, the data is written to an
    ///                               auxiliary file that is then renamed to the
    ///                               file. If `false`, the data is written to
    ///                               the file directly.
    ///
    /// - Throws:
    ///     `FileKitError.WriteToFileFail`,
    ///     `FileKitError.WritableConvertiblePropertyNil`
    ///
    public func writeToPath(path: Path, atomically useAuxiliaryFile: Bool) throws {
        try writable.writeToPath(path, atomically: useAuxiliaryFile)
    }

}
