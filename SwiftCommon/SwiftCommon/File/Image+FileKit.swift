

#if os(OSX)
import Cocoa
#elseif os(iOS) || os(tvOS)
import UIKit
#else
import WatchKit
#endif

#if os(OSX)
/// The image type for the current platform.
public typealias Image = NSImage
#else
/// The image type for the current platform.
public typealias Image = UIImage
#endif

extension Image: DataType, WritableConvertible {

    /// Returns an image from the given path.
    ///
    /// - Parameter path: The path to be returned the image for.
    /// - Throws: FileKitError.ReadFromFileFail
    ///
    public class func readFromPath(path: Path) throws -> Self {
        guard let contents = self.init(contentsOfFile: path._safeRawValue) else {
            throw FileKitError.ReadFromFileFail(path: path)
        }
        return contents
    }

    /// Returns `TIFFRepresentation` on OS X and `UIImagePNGRepresentation` on
    /// iOS, watchOS, and tvOS.
    public var writable: NSData {
        #if os(OSX)
        return self.TIFFRepresentation ?? NSData()
        #else
        return UIImagePNGRepresentation(self) ?? NSData()
        #endif
    }

    /// Retrieves an image from a URL.
    public convenience init?(url: NSURL) {
        #if os(OSX)
            self.init(contentsOfURL: url)
        #else
            guard let data = NSData(contentsOfURL: url) else {
                return nil
            }
            self.init(data: data)
        #endif
    }

    /// Retrieves an image from a URL string.
    public convenience init?(urlString string: String) {
        guard let url = NSURL(string: string) else {
            return nil
        }
        self.init(url: url)
    }

}
