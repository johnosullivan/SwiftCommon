

import Foundation

extension NSString {

    /// Returns an NSString object initialized by copying the characters from
    /// the raw value of a given path.
    public convenience init(path: Path) {
        self.init(string: path.rawValue)
    }

}
