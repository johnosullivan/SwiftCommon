

import Foundation

extension NSDictionary: DataType, WritableToFile {

    /// Returns a dictionary read from the given path.
    public class func readFromPath(path: Path) throws -> Self {
        guard let contents = self.init(contentsOfFile: path._safeRawValue) else {
            throw FileKitError.ReadFromFileFail(path: path)
        }
        return contents
    }

}
