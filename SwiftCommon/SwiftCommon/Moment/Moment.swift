//
//  Moment.swift
//  SwiftCommon
//

import Foundation

public enum TimeUnit: String {
    case Years = "y"
    case Quarters = "Q"
    case Months = "M"
    case Weeks = "w"
    case Days = "d"
    case Hours = "H"
    case Minutes = "m"
    case Seconds = "s"
}

public func == (lhs: Moment, rhs: Moment) -> Bool {
    return lhs.isEqualTo(rhs)
}

public func != (lhs: Moment, rhs: Moment) -> Bool {
    return !lhs.isEqualTo(rhs)
}

public func ~= (lhs: Moment, rhs: Moment) -> Bool {
    return lhs.isCloseTo(rhs)
}

public func - (lhs: Moment, rhs: Moment) -> Duration {
    return lhs.intervalSince(rhs)
}

public func > (lhs: Moment, rhs: Moment) -> Bool {
    return lhs.intervalSince(rhs).interval > 0
}

public func < (lhs: Moment, rhs: Moment) -> Bool {
    return lhs.intervalSince(rhs).interval < 0
}

public func >= (lhs: Moment, rhs: Moment) -> Bool {
    return lhs.intervalSince(rhs).interval >= 0
}

public func <= (lhs: Moment, rhs: Moment) -> Bool {
    return lhs.intervalSince(rhs).interval <= 0
}

public func + (lhs: Moment, rhs: Duration) -> Moment {
    return lhs.add(rhs)
}

public func + (lhs: Duration, rhs: Moment) -> Moment {
    return rhs.add(lhs)
}

public func - (lhs: Moment, rhs: Duration) -> Moment {
    return lhs.subtract(rhs)
}

public func - (lhs: Duration, rhs: Moment) -> Moment {
    return rhs.subtract(lhs)
}

public func == (lhs: Duration, rhs: Duration) -> Bool {
    return lhs.isEqualTo(rhs)
}

public func + (lhs: Duration, rhs: Duration) -> Duration {
    return lhs.add(rhs)
}

public func - (lhs: Duration, rhs: Duration) -> Duration {
    return lhs.subtract(rhs)
}


class MomentBundle: NSObject { }

extension Moment {
    public func fromNow() -> String {
        let timeDiffDuration = moment(NSDate()).intervalSince(self)
        let deltaSeconds = Int(timeDiffDuration.seconds)
        
        var value: Int!
        
        if deltaSeconds < 5 {
            // Just Now
            return NSDateTimeAgoLocalizedStrings("Just now")
            
        } else if deltaSeconds < minuteInSeconds {
            // Seconds Ago
            return stringFromFormat("%%d %@seconds ago", withValue: deltaSeconds)
            
        } else if deltaSeconds < (minuteInSeconds * 2) {
            // A Minute Ago
            return NSDateTimeAgoLocalizedStrings("A minute ago")
            
        } else if deltaSeconds < hourInSeconds {
            // Minutes Ago
            return stringFromFormat("%%d %@minutes ago", withValue: deltaSeconds / minuteInSeconds)
            
        } else if deltaSeconds < (hourInSeconds * 2) {
            // An Hour Ago
            return NSDateTimeAgoLocalizedStrings("An hour ago")
            
        } else if deltaSeconds < dayInSeconds {
            // Hours Ago
            value = Int(floor(Float(deltaSeconds / hourInSeconds)))
            return stringFromFormat("%%d %@hours ago", withValue: value)
            
        } else if deltaSeconds < (dayInSeconds * 2) {
            // Yesterday
            return NSDateTimeAgoLocalizedStrings("Yesterday")
            
        } else if deltaSeconds < weekInSeconds {
            // Days Ago
            value = Int(floor(Float(deltaSeconds / dayInSeconds)))
            return stringFromFormat("%%d %@days ago", withValue: value)
            
        } else if deltaSeconds < (weekInSeconds * 2) {
            // Last Week
            return NSDateTimeAgoLocalizedStrings("Last week")
            
        } else if deltaSeconds < monthInSeconds {
            // Weeks Ago
            value = Int(floor(Float(deltaSeconds / weekInSeconds)))
            return stringFromFormat("%%d %@weeks ago", withValue: value)
            
        } else if deltaSeconds < (dayInSeconds * 61) {
            // Last month
            return NSDateTimeAgoLocalizedStrings("Last month")
            
        } else if deltaSeconds < yearInSeconds {
            // Month Ago
            value = Int(floor(Float(deltaSeconds / monthInSeconds)))
            return stringFromFormat("%%d %@months ago", withValue: value)
            
        } else if deltaSeconds < (yearInSeconds * 2) {
            // Last Year
            return NSDateTimeAgoLocalizedStrings("Last year")
        }
        
        // Years Ago
        value = Int(floor(Float(deltaSeconds / yearInSeconds)))
        return stringFromFormat("%%d %@years ago", withValue: value)
    }
    
    private func stringFromFormat(format: String, withValue value: Int) -> String {
        let localeFormat = String(format: format,
                                  getLocaleFormatUnderscoresWithValue(Double(value)))
        return String(format: NSDateTimeAgoLocalizedStrings(localeFormat), value)
    }
    
    private func NSDateTimeAgoLocalizedStrings(key: String) -> String {
        // get framework bundle
        guard let bundleIdentifier = NSBundle(forClass: MomentBundle.self).bundleIdentifier  else {
            return ""
        }
        
        guard let frameworkBundle = NSBundle(identifier: bundleIdentifier) else {
            return ""
        }
        
        guard let resourcePath = frameworkBundle.resourcePath else {
            return ""
        }
        
        let bundleName = "MomentFromNow.bundle"
        let path = NSURL(fileURLWithPath:resourcePath).URLByAppendingPathComponent(bundleName)
        guard let bundle = NSBundle(URL: path) else {
            return ""
        }
        
        let localeIdentifer = self.locale.localeIdentifier
        guard let languagePath = bundle.pathForResource(localeIdentifer, ofType: "lproj"),
            languageBundle = NSBundle(path: languagePath)
            else {
                return ""
        }
        
        return languageBundle.localizedStringForKey(key, value: "", table: "NSDateTimeAgo")
    }
    
    private func getLocaleFormatUnderscoresWithValue(value: Double) -> String {
        guard let localeCode = NSLocale.preferredLanguages().first else {
            return ""
        }
        
        if localeCode == "ru" {
            let XY = Int(floor(value)) % 100
            let Y = Int(floor(value)) % 10
            
            if Y == 0 || Y > 4 || (XY > 10 && XY < 15) {
                return ""
            }
            
            if Y > 1 && Y < 5 && (XY < 10 || XY > 20) {
                return "_"
            }
            
            if Y == 1 && XY != 11 {
                return "__"
            }
        }
        
        return ""
    }
}

public extension Int {
    var seconds: Duration {
        return Duration(value: self)
    }
    
    var minutes: Duration {
        return Duration(value: self * 60)
    }
    
    var hours: Duration {
        return Duration(value: self * 3600)
    }
    
    var days: Duration {
        return Duration(value: self * 86400)
    }
    
    var months: Duration {
        return Duration(value: self * 2592000)
    }
    
    var quarters: Duration {
        return Duration(value: self * 7776000)
    }
    
    var years: Duration {
        return Duration(value: self * 31536000)
    }
}

public struct Duration: Equatable {
    let interval: NSTimeInterval
    
    public init(value: NSTimeInterval) {
        self.interval = value
    }
    
    public init(value: Int) {
        self.interval = NSTimeInterval(value)
    }
    
    public var years: Double {
        return interval / 31536000 // 365 days
    }
    
    public var quarters: Double {
        return interval / 7776000 // 3 months
    }
    
    public var months: Double {
        return interval / 2592000 // 30 days
    }
    
    public var days: Double {
        return interval / 86400 // 24 hours
    }
    
    public var hours: Double {
        return interval / 3600 // 60 minutes
    }
    
    public var minutes: Double {
        return interval / 60
    }
    
    public var seconds: Double {
        return interval
    }
    
    public func ago() -> Moment {
        return moment().subtract(self)
    }
    
    public func add(duration: Duration) -> Duration {
        return Duration(value: self.interval + duration.interval)
    }
    
    public func subtract(duration: Duration) -> Duration {
        return Duration(value: self.interval - duration.interval)
    }
    
    public func isEqualTo(duration: Duration) -> Bool {
        return self.interval == duration.interval
    }
}

extension Duration: CustomStringConvertible {
    public var description: String {
        let formatter = NSDateComponentsFormatter()
        formatter.calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)
        formatter.calendar?.timeZone = NSTimeZone(abbreviation: "UTC")!
        formatter.allowedUnits = [.Year, .Month, .WeekOfMonth, .Day, .Hour, .Minute, .Second]
        
        let referenceDate = NSDate(timeIntervalSinceReferenceDate: 0)
        let intervalDate = NSDate(timeInterval: self.interval, sinceDate: referenceDate)
        return formatter.stringFromDate(referenceDate, toDate: intervalDate)!
    }
}

public func moment(timeZone: NSTimeZone = NSTimeZone.defaultTimeZone(),
                   locale: NSLocale = NSLocale.autoupdatingCurrentLocale()) -> Moment {
    return Moment(timeZone: timeZone, locale: locale)
}

public func utc() -> Moment {
    let zone = NSTimeZone(abbreviation: "UTC")!
    return moment(zone)
}

public func moment(stringDate: String,
                   timeZone: NSTimeZone = NSTimeZone.defaultTimeZone(),
                   locale: NSLocale = NSLocale.autoupdatingCurrentLocale()) -> Moment? {

    let formatter = NSDateFormatter()
    formatter.timeZone = timeZone
    formatter.locale = locale
    let isoFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"

    // The contents of the array below are borrowed
    // and adapted from the source code of Moment.js
    // https://github.com/moment/moment/blob/develop/moment.js
    let formats = [
        isoFormat,
        "yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'",
        "yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSS'Z'",
        "yyyy-MM-dd'T'HH:mm:ss.SSSZ",
        "yyyy-MM-dd",
        "h:mm:ss A",
        "h:mm A",
        "MM/dd/yyyy",
        "MMMM d, yyyy",
        "MMMM d, yyyy LT",
        "dddd, MMMM D, yyyy LT",
        "yyyyyy-MM-dd",
        "yyyy-MM-dd",
        "GGGG-[W]WW-E",
        "GGGG-[W]WW",
        "yyyy-ddd",
        "HH:mm:ss.SSSS",
        "HH:mm:ss",
        "HH:mm",
        "HH"
    ]

    for format in formats {
        formatter.dateFormat = format

        if let date = formatter.dateFromString(stringDate) {
            return Moment(date: date, timeZone: timeZone, locale: locale)
        }
    }
    return nil
}

public func moment(stringDate: String, dateFormat: String,
                   timeZone: NSTimeZone = NSTimeZone.defaultTimeZone(),
                   locale: NSLocale = NSLocale.autoupdatingCurrentLocale()) -> Moment? {
    let formatter = NSDateFormatter()
    formatter.dateFormat = dateFormat
    formatter.timeZone = timeZone
    formatter.locale = locale
    if let date = formatter.dateFromString(stringDate) {
        return Moment(date: date, timeZone: timeZone, locale: locale)
    }
    return nil
}

public func moment(params: [Int], timeZone: NSTimeZone = NSTimeZone.defaultTimeZone(),
                   locale: NSLocale = NSLocale.autoupdatingCurrentLocale()) -> Moment? {
    if params.count > 0 {
        let calendar = NSCalendar.currentCalendar()
        calendar.timeZone = timeZone
        let components = NSDateComponents()
        components.year = params[0]

        if params.count > 1 {
            components.month = params[1]
            if params.count > 2 {
                components.day = params[2]
                if params.count > 3 {
                    components.hour = params[3]
                    if params.count > 4 {
                        components.minute = params[4]
                        if params.count > 5 {
                            components.second = params[5]
                        }
                    }
                }
            }
        }

        if let date = calendar.dateFromComponents(components) {
            return moment(date, timeZone: timeZone, locale: locale)
        }
    }
    return nil
}

public func moment(dict: [String: Int], timeZone: NSTimeZone = NSTimeZone.defaultTimeZone(),
                   locale: NSLocale = NSLocale.autoupdatingCurrentLocale()) -> Moment? {
    if dict.count > 0 {
        var params = [Int]()
        if let year = dict["year"] {
            params.append(year)
        }
        if let month = dict["month"] {
            params.append(month)
        }
        if let day = dict["day"] {
            params.append(day)
        }
        if let hour = dict["hour"] {
            params.append(hour)
        }
        if let minute = dict["minute"] {
            params.append(minute)
        }
        if let second = dict["second"] {
            params.append(second)
        }
        return moment(params, timeZone: timeZone, locale: locale)
    }
    return nil
}

public func moment(milliseconds: Int) -> Moment {
    return moment(NSTimeInterval(milliseconds / 1000))
}

public func moment(seconds: NSTimeInterval) -> Moment {
    let interval = NSTimeInterval(seconds)
    let date = NSDate(timeIntervalSince1970: interval)
    return Moment(date: date)
}

public func moment(date: NSDate, timeZone: NSTimeZone = NSTimeZone.defaultTimeZone(),
                   locale: NSLocale = NSLocale.autoupdatingCurrentLocale()) -> Moment {
    return Moment(date: date, timeZone: timeZone, locale: locale)
}

public func moment(moment: Moment) -> Moment {
    let copy = (moment.date.copy() as? NSDate)!
    let timeZone = (moment.timeZone.copy() as? NSTimeZone)!
    let locale = (moment.locale.copy() as? NSLocale)!
    return Moment(date: copy, timeZone: timeZone, locale: locale)
}

public func past() -> Moment {
    return Moment(date: NSDate.distantPast() )
}

public func future() -> Moment {
    return Moment(date: NSDate.distantFuture() )
}

public func since(past: Moment) -> Duration {
    return moment().intervalSince(past)
}

public func maximum(moments: Moment...) -> Moment? {
    if moments.count > 0 {
        var max: Moment = moments[0]
        for moment in moments {
            if moment > max {
                max = moment
            }
        }
        return max
    }
    return nil
}

public func minimum(moments: Moment...) -> Moment? {
    if moments.count > 0 {
        var min: Moment = moments[0]
        for moment in moments {
            if moment < min {
                min = moment
            }
        }
        return min
    }
    return nil
}

public struct Moment: Comparable {
    public let minuteInSeconds = 60
    public let hourInSeconds = 3600
    public let dayInSeconds = 86400
    public let weekInSeconds = 604800
    public let monthInSeconds = 2592000
    public let yearInSeconds = 31536000

    public let date: NSDate
    public let timeZone: NSTimeZone
    public let locale: NSLocale

    init(date: NSDate = NSDate(), timeZone: NSTimeZone = NSTimeZone.defaultTimeZone(),
         locale: NSLocale = NSLocale.autoupdatingCurrentLocale()) {
        self.date = date
        self.timeZone = timeZone
        self.locale = locale
    }

    /// Returns the year of the current instance.
    public var year: Int {
        let cal = NSCalendar.currentCalendar()
        cal.timeZone = timeZone
        cal.locale = locale
        let components = cal.components(.Year, fromDate: date)
        return components.year
    }

    /// Returns the month (1-12) of the current instance.
    public var month: Int {
        let cal = NSCalendar.currentCalendar()
        cal.timeZone = timeZone
        cal.locale = locale
        let components = cal.components(.Month, fromDate: date)
        return components.month
    }

    /// Returns the name of the month of the current instance, in the current locale.
    public var monthName: String {
        let formatter = NSDateFormatter()
        formatter.locale = locale
        return formatter.monthSymbols[month - 1]
    }

    public var day: Int {
        let cal = NSCalendar.currentCalendar()
        cal.timeZone = timeZone
        cal.locale = locale
        let components = cal.components(.Day, fromDate: date)
        return components.day
    }

    public var hour: Int {
        let cal = NSCalendar.currentCalendar()
        cal.timeZone = timeZone
        cal.locale = locale
        let components = cal.components(.Hour, fromDate: date)
        return components.hour
    }

    public var minute: Int {
        let cal = NSCalendar.currentCalendar()
        cal.timeZone = timeZone
        cal.locale = locale
        let components = cal.components(.Minute, fromDate: date)
        return components.minute
    }

    public var second: Int {
        let cal = NSCalendar.currentCalendar()
        cal.timeZone = timeZone
        cal.locale = locale
        let components = cal.components(.Second, fromDate: date)
        return components.second
    }

    public var weekday: Int {
        let cal = NSCalendar.currentCalendar()
        cal.timeZone = timeZone
        cal.locale = locale
        let components = cal.components(.Weekday, fromDate: date)
        return components.weekday
    }

    public var weekdayName: String {
        let formatter = NSDateFormatter()
        formatter.locale = locale
        formatter.dateFormat = "EEEE"
        formatter.timeZone = timeZone
        return formatter.stringFromDate(date)
    }

    public var weekdayOrdinal: Int {
        let cal = NSCalendar.currentCalendar()
        cal.locale = locale
        cal.timeZone = timeZone
        let components = cal.components(.WeekdayOrdinal, fromDate: date)
        return components.weekdayOrdinal
    }

    public var weekOfYear: Int {
        let cal = NSCalendar.currentCalendar()
        cal.locale = locale
        cal.timeZone = timeZone
        let components = cal.components(.WeekOfYear, fromDate: date)
        return components.weekOfYear
    }

    public var quarter: Int {
        let cal = NSCalendar.currentCalendar()
        cal.locale = locale
        cal.timeZone = timeZone
        let components = cal.components(.Quarter, fromDate: date)
        return components.quarter
    }

    // Methods

    public func get(unit: TimeUnit) -> Int? {
        switch unit {
        case .Seconds:
            return second
        case .Minutes:
            return minute
        case .Hours:
            return hour
        case .Days:
            return day
        case .Weeks:
            return weekOfYear
        case .Months:
            return month
        case .Quarters:
            return quarter
        case .Years:
            return year
        }
    }

    public func get(unitName: String) -> Int? {
        if let unit = TimeUnit(rawValue: unitName) {
            return get(unit)
        }
        return nil
    }

    public func format(dateFormat: String = "yyyy-MM-dd HH:mm:ss ZZZZ") -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = dateFormat
        formatter.timeZone = timeZone
        formatter.locale = locale
        return formatter.stringFromDate(date)
    }

    public func isEqualTo(moment: Moment) -> Bool {
        return date.isEqualToDate(moment.date)
    }

    public func intervalSince(moment: Moment) -> Duration {
        let interval = date.timeIntervalSinceDate(moment.date)
        return Duration(value: interval)
    }

    public func add(value: Int, _ unit: TimeUnit) -> Moment {
        let components = NSDateComponents()
        switch unit {
        case .Years:
            components.year = value
        case .Quarters:
            components.month = 3 * value
        case .Months:
            components.month = value
        case .Weeks:
            components.day = 7 * value
        case .Days:
            components.day = value
        case .Hours:
            components.hour = value
        case .Minutes:
            components.minute = value
        case .Seconds:
            components.second = value
        }
        let cal = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        cal.timeZone = timeZone
        cal.locale = locale
        if let newDate = cal.dateByAddingComponents(components, toDate: date,
                                                    options: NSCalendarOptions.init(rawValue: 0)) {
          return Moment(date: newDate)
        }
        return self
    }

    public func add(value: NSTimeInterval, _ unit: TimeUnit) -> Moment {
        let seconds = convert(value, unit)
        let interval = NSTimeInterval(seconds)
        let newDate = date.dateByAddingTimeInterval(interval)
        return Moment(date: newDate)
    }

    public func add(value: Int, _ unitName: String) -> Moment {
        if let unit = TimeUnit(rawValue: unitName) {
            return add(value, unit)
        }
        return self
    }

    public func add(duration: Duration) -> Moment {
        return add(duration.interval, .Seconds)
    }

    public func subtract(value: NSTimeInterval, _ unit: TimeUnit) -> Moment {
        return add(-value, unit)
    }

    public func subtract(value: Int, _ unit: TimeUnit) -> Moment {
        return add(-value, unit)
    }

    public func subtract(value: Int, _ unitName: String) -> Moment {
        if let unit = TimeUnit(rawValue: unitName) {
            return subtract(value, unit)
        }
        return self
    }

    public func subtract(duration: Duration) -> Moment {
        return subtract(duration.interval, .Seconds)
    }

    public func isCloseTo(moment: Moment, precision: NSTimeInterval = 300) -> Bool {
        // "Being close" is measured using a precision argument
        // which is initialized a 300 seconds, or 5 minutes.
        let delta = intervalSince(moment)
        return abs(delta.interval) < precision
    }

    public func startOf(unit: TimeUnit) -> Moment {
        let cal = NSCalendar.currentCalendar()
        var newDate: NSDate?
        let components = cal.components([.Year, .Month, .Weekday, .Day, .Hour, .Minute, .Second],
                                        fromDate: date)
        switch unit {
        case .Seconds:
            return self
        case .Years:
            components.month = 1
            fallthrough
        case .Quarters, .Months, .Weeks:
            if unit == .Weeks {
                components.day -= (components.weekday - 2)
            } else {
                components.day = 1
            }
            fallthrough
        case .Days:
            components.hour = 0
            fallthrough
        case .Hours:
            components.minute = 0
            fallthrough
        case .Minutes:
            components.second = 0
        }
        newDate = cal.dateFromComponents(components)
        return newDate == nil ? self : Moment(date: newDate!)
    }

    public func startOf(unitName: String) -> Moment {
        if let unit = TimeUnit(rawValue: unitName) {
            return startOf(unit)
        }
        return self
    }

    public func endOf(unit: TimeUnit) -> Moment {
        return startOf(unit).add(1, unit).subtract(1.seconds)
    }

    public func endOf(unitName: String) -> Moment {
        if let unit = TimeUnit(rawValue: unitName) {
            return endOf(unit)
        }
        return self
    }

    public func epoch() -> NSTimeInterval {
        return date.timeIntervalSince1970
    }

    // Private methods

    func convert(value: Double, _ unit: TimeUnit) -> Double {
        switch unit {
        case .Seconds:
            return value
        case .Minutes:
            return value * 60
        case .Hours:
            return value * 3600 // 60 minutes
        case .Days:
            return value * 86400 // 24 hours
        case .Weeks:
            return value * 605800 // 7 days
        case .Months:
            return value * 2592000 // 30 days
        case .Quarters:
            return value * 7776000 // 3 months
        case .Years:
            return value * 31536000 // 365 days
        }
    }
}

extension Moment: CustomStringConvertible {
    public var description: String {
        return format()
    }
}

extension Moment: CustomDebugStringConvertible {
    public var debugDescription: String {
        return description
    }
}
