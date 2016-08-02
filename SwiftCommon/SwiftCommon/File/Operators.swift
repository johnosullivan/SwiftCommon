import Foundation

// MARK: - File

/// Returns `true` if both files' paths are the same.
@warn_unused_result
public func ==<Data: DataType>(lhs: File<Data>, rhs: File<Data>) -> Bool {
    return lhs.path == rhs.path
}

/// Returns `true` if `lhs` is smaller than `rhs` in size.
@warn_unused_result
public func < <Data: DataType>(lhs: File<Data>, rhs: File<Data>) -> Bool {
    return lhs.size < rhs.size
}

infix operator |> {}

/// Writes data to a file.
///
/// - Throws: `FileKitError.WriteToFileFail`
///
public func |> <Data: DataType>(data: Data, file: File<Data>) throws {
    try file.write(data)
}



// MARK: - Path

/// Returns `true` if the standardized form of one path equals that of another
/// path.
@warn_unused_result
public func == (lhs: Path, rhs: Path) -> Bool {
    if lhs.isAbsolute || rhs.isAbsolute {
        return lhs.absolute.rawValue == rhs.absolute.rawValue
    }
    return lhs.standardRawValueWithTilde == rhs.standardRawValueWithTilde
}

/// Returns `true` if the standardized form of one path not equals that of another
/// path.
@warn_unused_result
public func != (lhs: Path, rhs: Path) -> Bool {
    return !(lhs == rhs)
}

/// Concatenates two `Path` instances and returns the result.
///
/// ```swift
/// let systemLibrary: Path = "/System/Library"
/// print(systemLib + "Fonts")  // "/System/Library/Fonts"
/// ```
///
@warn_unused_result
public func + (lhs: Path, rhs: Path) -> Path {
    if lhs.rawValue.isEmpty || lhs.rawValue == "." { return rhs }
    if rhs.rawValue.isEmpty || rhs.rawValue == "." { return lhs }
    switch (lhs.rawValue.hasSuffix(Path.separator), rhs.rawValue.hasPrefix(Path.separator)) {
    case (true, true):
        let rhsRawValue = rhs.rawValue.substringFromIndex(rhs.rawValue.startIndex.successor())
        return Path("\(lhs.rawValue)\(rhsRawValue)")
    case (false, false):
        return Path("\(lhs.rawValue)\(Path.separator)\(rhs.rawValue)")
    default:
        return Path("\(lhs.rawValue)\(rhs.rawValue)")
    }
}

/// Converts a `String` to a `Path` and returns the concatenated result.
@warn_unused_result
public func + (lhs: String, rhs: Path) -> Path {
    return Path(lhs) + rhs
}

/// Converts a `String` to a `Path` and returns the concatenated result.
@warn_unused_result
public func + (lhs: Path, rhs: String) -> Path {
    return lhs + Path(rhs)
}

/// Appends the right path to the left path.
public func += (inout lhs: Path, rhs: Path) {
    lhs = lhs + rhs
}

/// Appends the path value of the String to the left path.
public func += (inout lhs: Path, rhs: String) {
    lhs = lhs + rhs
}


/// Concatenates two `Path` instances and returns the result.
@warn_unused_result
public func / (lhs: Path, rhs: Path) -> Path {
    return lhs + rhs
}

/// Converts a `String` to a `Path` and returns the concatenated result.
@warn_unused_result
public func / (lhs: Path, rhs: String) -> Path {
    return lhs + rhs
}

/// Converts a `String` to a `Path` and returns the concatenated result.
@warn_unused_result
public func / (lhs: String, rhs: Path) -> Path {
    return lhs + rhs
}

/// Appends the right path to the left path.
public func /= (inout lhs: Path, rhs: Path) {
    lhs += rhs
}

/// Appends the path value of the String to the left path.
public func /= (inout lhs: Path, rhs: String) {
    lhs += rhs
}

infix operator <^> {
associativity left
}

/// Returns the common ancestor between the two paths.
@warn_unused_result
public func <^> (lhs: Path, rhs: Path) -> Path {
    return lhs.commonAncestor(rhs)
}

infix operator </> {}

/// Runs `closure` with the path as its current working directory.
public func </> (path: Path, @noescape closure: () throws -> ()) rethrows {
    try path.changeDirectory(closure)
}

infix operator ->> {}

/// Moves the file at the left path to a path.
///
/// Throws an error if the file at the left path could not be moved or if a file
/// already exists at the right path.
///
/// - Throws: `FileKitError.FileDoesNotExist`, `FileKitError.MoveFileFail`
///
public func ->> (lhs: Path, rhs: Path) throws {
    try lhs.moveFileToPath(rhs)
}

/// Moves a file to a path.
///
/// Throws an error if the file could not be moved or if a file already
/// exists at the destination path.
///
/// - Throws: `FileKitError.FileDoesNotExist`, `FileKitError.MoveFileFail`
///
public func ->> <Data: DataType>(lhs: File<Data>, rhs: Path) throws {
    try lhs.moveToPath(rhs)
}

infix operator ->! {}

/// Forcibly moves the file at the left path to the right path.
///
/// - Warning: If a file at the right path already exists, it will be deleted.
///
/// - Throws:
///     `FileKitError.DeleteFileFail`,
///     `FileKitError.FileDoesNotExist`,
///     `FileKitError.CreateSymlinkFail`
///
public func ->! (lhs: Path, rhs: Path) throws {
    if rhs.isAny {
        try rhs.deleteFile()
    }
    try lhs ->> rhs
}

/// Forcibly moves a file to a path.
///
/// - Warning: If a file at the right path already exists, it will be deleted.
///
/// - Throws:
///     `FileKitError.DeleteFileFail`,
///     `FileKitError.FileDoesNotExist`,
///     `FileKitError.CreateSymlinkFail`
///
public func ->! <Data: DataType>(lhs: File<Data>, rhs: Path) throws {
    if rhs.isAny {
        try rhs.deleteFile()
    }
    try lhs ->> rhs
}


infix operator +>> {}

/// Copies the file at the left path to the right path.
///
/// Throws an error if the file at the left path could not be copied or if a file
/// already exists at the right path.
///
/// - Throws: `FileKitError.FileDoesNotExist`, `FileKitError.CopyFileFail`
///
public func +>> (lhs: Path, rhs: Path) throws {
    try lhs.copyFileToPath(rhs)
}

/// Copies a file to a path.
///
/// Throws an error if the file could not be copied or if a file already
/// exists at the destination path.
///
/// - Throws: `FileKitError.FileDoesNotExist`, `FileKitError.CopyFileFail`
///
public func +>> <Data: DataType>(lhs: File<Data>, rhs: Path) throws {
    try lhs.copyToPath(rhs)
}

infix operator +>! {}

/// Forcibly copies the file at the left path to the right path.
///
/// - Warning: If a file at the right path already exists, it will be deleted.
///
/// - Throws:
///     `FileKitError.DeleteFileFail`,
///     `FileKitError.FileDoesNotExist`,
///     `FileKitError.CreateSymlinkFail`
///
public func +>! (lhs: Path, rhs: Path) throws {
    if rhs.isAny {
        try rhs.deleteFile()
    }
    try lhs +>> rhs
}

/// Forcibly copies a file to a path.
///
/// - Warning: If a file at the right path already exists, it will be deleted.
///
/// - Throws:
///     `FileKitError.DeleteFileFail`,
///     `FileKitError.FileDoesNotExist`,
///     `FileKitError.CreateSymlinkFail`
///
public func +>! <Data: DataType>(lhs: File<Data>, rhs: Path) throws {
    if rhs.isAny {
        try rhs.deleteFile()
    }
    try lhs +>> rhs
}

infix operator =>> {}

/// Creates a symlink of the left path at the right path.
///
/// If the symbolic link path already exists and _is not_ a directory, an
/// error will be thrown and a link will not be created.
///
/// If the symbolic link path already exists and _is_ a directory, the link
/// will be made to a file in that directory.
///
/// - Throws:
///     `FileKitError.FileDoesNotExist`,
///     `FileKitError.CreateSymlinkFail`
///
public func =>> (lhs: Path, rhs: Path) throws {
    try lhs.symlinkFileToPath(rhs)
}

/// Symlinks a file to a path.
///
/// If the path already exists and _is not_ a directory, an error will be
/// thrown and a link will not be created.
///
/// If the path already exists and _is_ a directory, the link will be made
/// to the file in that directory.
///
/// - Throws: `FileKitError.FileDoesNotExist`, `FileKitError.CreateSymlinkFail`
///
public func =>> <Data: DataType>(lhs: File<Data>, rhs: Path) throws {
    try lhs.symlinkToPath(rhs)
}

infix operator =>! {}

/// Forcibly creates a symlink of the left path at the right path by deleting
/// anything at the right path before creating the symlink.
///
/// - Warning: If the symbolic link path already exists, it will be deleted.
///
/// - Throws:
///     `FileKitError.DeleteFileFail`,
///     `FileKitError.FileDoesNotExist`,
///     `FileKitError.CreateSymlinkFail`
///
public func =>! (lhs: Path, rhs: Path) throws {
    //    guard lhs.exists else {
    //        throw FileKitError.FileDoesNotExist(path: lhs)
    //    }

    let linkPath = rhs.isDirectory ? rhs + lhs.fileName : rhs
    if linkPath.isAny { try linkPath.deleteFile() }

    try lhs =>> rhs
}

/// Forcibly creates a symlink of a file at a path by deleting anything at the
/// path before creating the symlink.
///
/// - Warning: If the path already exists, it will be deleted.
///
/// - Throws:
///     `FileKitError.DeleteFileFail`,
///     `FileKitError.FileDoesNotExist`,
///     `FileKitError.CreateSymlinkFail`
///
public func =>! <Data: DataType>(lhs: File<Data>, rhs: Path) throws {
    try lhs.path =>! rhs
}

postfix operator % {}

/// Returns the standardized version of the path.
@warn_unused_result
public postfix func % (path: Path) -> Path {
    return path.standardized
}

postfix operator * {}

/// Returns the resolved version of the path.
@warn_unused_result
public postfix func * (path: Path) -> Path {
    return path.resolved
}


postfix operator ^ {}

/// Returns the path's parent path.
@warn_unused_result
public postfix func ^ (path: Path) -> Path {
    return path.parent
}
