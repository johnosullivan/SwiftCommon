

import Foundation

/// The type attribute for a file at a path.
public enum FileType: String {

    /// The file is a directory.
    case Directory

    /// The file is a regular file.
    case Regular

    /// The file is a symbolic link.
    case SymbolicLink

    /// The file is a socket.
    case Socket

    /// The file is a characer special file.
    case CharacterSpecial

    /// The file is a block special file.
    case BlockSpecial

    /// The type of the file is unknown.
    case Unknown

    /// Creates a FileType from an `NSFileType` attribute.
    ///
    /// - Parameter rawValue: The raw value to create from.
    public init?(rawValue: String) {
        switch rawValue {
        case NSFileTypeDirectory:
            self = Directory
        case NSFileTypeRegular:
            self = Regular
        case NSFileTypeSymbolicLink:
            self = SymbolicLink
        case NSFileTypeSocket:
            self = Socket
        case NSFileTypeCharacterSpecial:
            self = CharacterSpecial
        case NSFileTypeBlockSpecial:
            self = BlockSpecial
        case NSFileTypeUnknown:
            self = Unknown
        default:
            return nil
        }
    }

    /// The `NSFileType` attribute for `self`.
    public var rawValue: String {
        switch self {
        case .Directory:
            return NSFileTypeDirectory
        case .Regular:
            return NSFileTypeRegular
        case .SymbolicLink:
            return NSFileTypeSymbolicLink
        case .Socket:
            return NSFileTypeSocket
        case .CharacterSpecial:
            return NSFileTypeCharacterSpecial
        case .BlockSpecial:
            return NSFileTypeBlockSpecial
        case .Unknown:
            return NSFileTypeUnknown
        }
    }

}
