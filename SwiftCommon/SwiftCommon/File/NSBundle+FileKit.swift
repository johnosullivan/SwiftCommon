
import Foundation

extension NSBundle {

    /// Returns an NSBundle for the given directory path.
    public convenience init?(path: Path) {
        self.init(path: path.absolute.rawValue)
    }

}
