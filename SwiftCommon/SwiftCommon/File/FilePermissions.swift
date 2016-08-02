

import Foundation

/// The permissions of a file.
public struct FilePermissions: OptionSetType, CustomStringConvertible {

    /// The file can be read from.
    public static let Read = FilePermissions(rawValue: 1)

    /// The file can be written to.
    public static let Write = FilePermissions(rawValue: 2)

    /// The file can be executed.
    public static let Execute = FilePermissions(rawValue: 4)

    /// The raw integer value of `self`.
    public let rawValue: Int

    /// A textual representation of `self`.
    public var description: String {
        var description = ""
        for permission in [.Read, .Write, .Execute] as [FilePermissions] {
            if self.contains(permission) {
                description += !description.isEmpty ? ", " : ""
                if permission == .Read {
                    description += "Read"
                } else if permission == .Write {
                    description += "Write"
                } else if permission == .Execute {
                    description += "Execute"
                }
            }
        }
        return String(self.dynamicType) + "[" + description + "]"
    }

    /// Creates a set of file permissions.
    ///
    /// - Parameter rawValue: The raw value to initialize from.
    ///
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    /// Creates a set of permissions for the file at `path`.
    ///
    /// - Parameter path: The path to the file to create a set of persmissions for.
    ///
    public init(forPath path: Path) {
        var permissions = FilePermissions(rawValue: 0)
        if path.isReadable { permissions.unionInPlace(.Read) }
        if path.isWritable { permissions.unionInPlace(.Write) }
        if path.isExecutable { permissions.unionInPlace(.Execute) }
        self = permissions
    }

    /// Creates a set of permissions for `file`.
    ///
    /// - Parameter file: The file to create a set of persmissions for.
    public init<Data: DataType>(forFile file: File<Data>) {
        self.init(forPath: file.path)
    }

}
