

import Foundation

/// A representation of a filesystem data file.
///
/// The data type is NSData.
public typealias DataFile = File<NSData>

extension File where Data: NSData {

    /// Reads the file and returns its data.
    /// - Parameter options: A mask that specifies write options
    ///                      described in `NSDataReadingOptions`.
    ///
    /// - Throws: `FileKitError.ReadFromFileFail`
    /// - Returns: The data read from file.
    public func read(options: NSDataReadingOptions) throws -> Data {
        return try Data.readFromPath(path, options: options)
    }

    /// Writes data to the file.
    ///
    /// - Parameter data: The data to be written to the file.
    /// - Parameter options: A mask that specifies write options
    ///                      described in `NSDataWritingOptions`.
    ///
    /// - Throws: `FileKitError.WriteToFileFail`
    ///
    public func write(data: Data, options: NSDataWritingOptions) throws {
        do {
            try data.writeToFile(self.path._safeRawValue, options: options)
        } catch {
            throw FileKitError.WriteToFileFail(path: path)
        }
    }

}
