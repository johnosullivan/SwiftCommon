

import Foundation

extension NSArray: DataType, WritableToFile {

    /// Returns an array read from the given path.
    ///
    /// - Parameter path: The path an array to be read from.
    public class func readFromPath(path: Path) throws -> Self {
        guard let contents = self.init(contentsOfFile: path._safeRawValue) else {
            throw FileKitError.ReadFromFileFail(path: path)
        }
        return contents
    }

}
