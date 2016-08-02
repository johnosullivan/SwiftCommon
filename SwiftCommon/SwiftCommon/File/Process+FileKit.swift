

extension Process {

    /// The working directory for the current process.
    public static var workingDirectory: Path {
        get {
            return Path.Current
        }
        set {
            Path.Current = newValue
        }
    }

}
