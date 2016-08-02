

import Foundation

/// Allows String to be used as a DataType.
extension String: DataType {

    /// Creates a string from a path.
    public static func readFromPath(path: Path) throws -> String {
        let possibleContents = try? NSString(
            contentsOfFile: path._safeRawValue,
            encoding: NSUTF8StringEncoding)
        guard let contents = possibleContents else {
            throw FileKitError.ReadFromFileFail(path: path)
        }
        return contents as String
    }

    /// Writes the string to a path atomically.
    ///
    /// - Parameter path: The path being written to.
    ///
    public func writeToPath(path: Path) throws {
        try writeToPath(path, atomically: true)
    }

    /// Writes the string to a path with `NSUTF8StringEncoding` encoding.
    ///
    /// - Parameter path: The path being written to.
    /// - Parameter useAuxiliaryFile: If `true`, the data is written to an
    ///                               auxiliary file that is then renamed to the
    ///                               file. If `false`, the data is written to
    ///                               the file directly.
    ///
    public func writeToPath(path: Path, atomically useAuxiliaryFile: Bool) throws {
        do {
            try self.writeToFile(path._safeRawValue,
                atomically: useAuxiliaryFile,
                encoding: NSUTF8StringEncoding)
        } catch {
            throw FileKitError.WriteToFileFail(path: path)
        }
    }

}
