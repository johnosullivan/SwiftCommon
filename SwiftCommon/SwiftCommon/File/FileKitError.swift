

import Foundation

/// An error that can be thrown by FileKit.
public enum FileKitError: ErrorType {

    // MARK: FileKitError

    /// The reason for why the error occured.
    public var message: String {
        switch self {
        case let FileDoesNotExist(path):
            return "File does not exist at \"\(path)\""
        case let ChangeDirectoryFail(fromPath, toPath):
            return "Could not change the directory from \"\(fromPath)\" to \"\(toPath)\""
        case let CreateSymlinkFail(fromPath, toPath):
            return "Could not create symlink from \"\(fromPath)\" to \"\(toPath)\""
        case let CreateHardlinkFail(fromPath, toPath):
            return "Could not create a hard link from \"\(fromPath)\" to \"\(toPath)\""
        case let CreateFileFail(path):
            return "Could not create file at \"\(path)\""
        case let CreateDirectoryFail(path):
            return "Could not create a directory at \"\(path)\""
        case let DeleteFileFail(path):
            return "Could not delete file at \"\(path)\""
        case let ReadFromFileFail(path):
            return "Could not read from file at \"\(path)\""
        case let WriteToFileFail(path):
            return "Could not write to file at \"\(path)\""
        case let MoveFileFail(fromPath, toPath):
            return "Could not move file at \"\(fromPath)\" to \"\(toPath)\""
        case let CopyFileFail(fromPath, toPath):
            return "Could not copy file from \"\(fromPath)\" to \"\(toPath)\""
        case let AttributesChangeFail(path):
            return "Could not change file attrubutes at \"\(path)\""
        }
    }

    /// A file does not exist.
    case FileDoesNotExist(path: Path)

    /// Could not change the current directory.
    case ChangeDirectoryFail(from: Path, to: Path)

    /// A symbolic link could not be created.
    case CreateSymlinkFail(from: Path, to: Path)

    /// A hard link could not be created.
    case CreateHardlinkFail(from: Path, to: Path)

    /// A file could not be created.
    case CreateFileFail(path: Path)

    /// A directory could not be created.
    case CreateDirectoryFail(path: Path)

    /// A file could not be deleted.
    case DeleteFileFail(path: Path)

    /// A file could not be read from.
    case ReadFromFileFail(path: Path)

    /// A file could not be written to.
    case WriteToFileFail(path: Path)

    /// A file could not be moved.
    case MoveFileFail(from: Path, to: Path)

    /// A file could not be copied.
    case CopyFileFail(from: Path, to: Path)

    /// One or many attributes could not be changed.
    case AttributesChangeFail(path: Path)
}

extension FileKitError: CustomStringConvertible {
    // MARK: - CustomStringConvertible
    /// A textual representation of `self`.
    public var description: String {
        return String(self.dynamicType) + "(" + message + ")"
    }

}
