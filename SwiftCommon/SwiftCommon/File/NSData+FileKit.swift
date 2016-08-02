

import Foundation

extension NSData: DataType, WritableToFile {

    /// Returns data read from the given path.
    public class func readFromPath(path: Path) throws -> Self {
        guard let contents = self.init(contentsOfFile: path._safeRawValue) else {
            throw FileKitError.ReadFromFileFail(path: path)
        }
        return contents
    }

    /// Returns data read from the given path using NSDataReadingOptions.
    public class func readFromPath(path: Path, options: NSDataReadingOptions) throws -> Self {
        do {
            return try self.init(contentsOfFile: path._safeRawValue, options: options)
        } catch {
            throw FileKitError.ReadFromFileFail(path: path)
        }
    }

}
