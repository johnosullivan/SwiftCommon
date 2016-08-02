

import Foundation

#if os(OSX)

/// A filesystem event stream.
internal struct FileSystemEventStream: RawRepresentable {

    /// The raw FSEventStreamRef value of `self`.
    var rawValue: FSEventStreamRef

    /// Schedules the stream on the specified run loop.
    ///
    /// - Parameter runLoop: The run loop.
    /// - Parameter runLoopMode: The run loop mode.
    func scheduleWithRunLoop(runLoop: CFRunLoopRef, runLoopMode: CFStringRef) {
        FSEventStreamScheduleWithRunLoop(rawValue, runLoop, runLoopMode)
    }

    /// Invalidates the stream.
    func invalidate() {
        FSEventStreamInvalidate(rawValue)
    }

    /// Registers the stream.
    func start() {
        FSEventStreamStart(rawValue)
    }

    /// Unregisters the stream.
    func stop() {
        FSEventStreamStop(rawValue)
    }

    /// Removes the stream from the specified run loop.
    ///
    /// - Parameter runLoop: The run loop.
    /// - Parameter runLoopMode: The run loop mode.
    func unscheduleFromRunLoop(runLoop: CFRunLoopRef, runLoopMode: CFStringRef) {
        FSEventStreamUnscheduleFromRunLoop(rawValue, runLoop, runLoopMode)
    }

    /// Schedules the stream on the specified dispatch queue
    ///
    /// - Parameter queue: The queue to be run within.
    func setDispatchQueue(queue: dispatch_queue_t) {
        FSEventStreamSetDispatchQueue(rawValue, queue)
    }

    /// Decrements the FSEventStreamRef's refcount.
    func release() {
        FSEventStreamRelease(rawValue)
    }

    /// Asks the FS Events service to flush out any events that have occurred
    /// but have not yet been delivered, due to the latency parameter that was
    /// supplied when the stream was created. This flushing occurs
    /// asynchronously.
    func flushAsync() {
        FSEventStreamFlushAsync(rawValue)
    }

    /// Asks the FS Events service to flush out any events that have occurred
    /// but have not yet been delivered, due to the latency parameter that was
    /// supplied when the stream was created. This flushing occurs
    /// synchronously.
    func flushSync() {
        FSEventStreamFlushSync(rawValue)
    }

    /// Prints a description of the stream to stderr.
    func show() {
        FSEventStreamShow(rawValue)
    }

    /// The dev_t for a device-relative stream, otherwise 0.
    ///
    /// - Returns: The dev_t for a device-relative stream or 0.
    func deviceBeingWatched() -> dev_t {
        return FSEventStreamGetDeviceBeingWatched(rawValue)
    }

    /// The sinceWhen attribute of the stream.
    var lastEventId: FSEventStreamEventId {
        return FSEventStreamGetLatestEventId(rawValue)
    }
}

#endif
