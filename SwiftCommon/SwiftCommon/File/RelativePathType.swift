

import Foundation

/// The type attribute for a relative path.
public enum RelativePathType: String {

    /// path like "dir/path".
    case Normal

    /// path like "." and "".
    case Current

    /// path like "../path".
    case Ancestor

    /// path like "..".
    case Parent

    /// path like "/path".
    case Absolute

}
