//
//  Number+.swift
//  TiTech
//
//  Created by Apple on 9/7/24.
//

import Foundation
import UIKit

extension Numeric where Self: BinaryInteger {
    var doubleValue: Double {
        return Double(self)
    }

    var intValue: Int {
        return Int(self)
    }
}

// MARK: indexes of all duplicate elements
extension Array where Element: BinaryInteger {
    func allIndex(of i: Int) -> [Int]? {
        var ret = [Int]()
        for (idx, item) in self.enumerated() {
            if item == i {
                ret.append(idx)
            }
        }
        return ret
    }
}


// MARK: - Double
extension Double {
    func toTimeString(_ isFullFormat: Bool = false) -> String {
        let seconds = Int(self)
        let hour = seconds / 3600
        let minute = (seconds % 3600) / 60
        let second = ((seconds % 3600) % 60)
        if isFullFormat {
            return String(format: "%02d:%02d:%02d", hour, minute, second)
        }
        if hour == 0 {
            return String(format: "%02d:%02d", minute, second)
        }
        return String(format: "%d:%02d:%02d", hour, minute, second)
    }
    
    func toFullTimeString() -> String {
        let seconds = Int(self)
        let hour = seconds / 3600
        let minute = (seconds % 3600) / 60
        let second = ((seconds % 3600) % 60)
        
        if hour == 0 {
            if minute == 0 {
                return String(format: "%02d giây", second)
                
            } else {
                if second == 0 {
                    return String(format: "%02d phút", minute)
                    
                } else {
                    return String(format: "%02d phút %02d giây", minute, second)
                }
            }
            
        } else {
            return String(format: "%d giờ %02d phút %02d giây", hour, minute, second)
        }
    }
    
    func toHourMinuteString() -> String {
        let seconds = Int(self)
        let hour = seconds / 3600
        let minute = (seconds % 3600) / 60
        if hour == 0 {
            return String(format: "%02d phút", minute)
        }
        return String(format: "%d giờ %02d phút", hour, minute)
    }
    
    func toHHMMString() -> String {
        let seconds = Int(self)
        let hour = seconds / 3600
        let minute = (seconds % 3600) / 60
        return String(format: "%02d:%02d", hour, minute)
    }
    
    func getMinute() -> Int {
        let seconds = Int(self)
        let minute = (seconds % 3600) / 60
        return minute
    }
    
    var intValue: Int {
        return Int(self)
    }
    
    var stringValue: String {
        let numberFormater = NumberFormatter()
        numberFormater.numberStyle = .decimal
        numberFormater.maximumFractionDigits = 1
        numberFormater.minimumFractionDigits = 0
        return numberFormater.string(from: NSNumber(value: self)) ?? ""
    }
    
    func toKilometers() -> String {
        let meter = self
        let KM = meter / 1000
        let roundDouble = KM.rounded(toPlaces: 2)
        return "\(roundDouble) Km"
    }
    
    func toString() -> String {
        return String(self.rounded(toPlaces: 2))
    }
    
//    func toString() -> String {
//        let numberFormater = NumberFormatter()
//        numberFormater.minimumFractionDigits = 0
//        numberFormater.maximumFractionDigits = 2
//        numberFormater.decimalSeparator = "."
//        return numberFormater.string(from: self as NSNumber)!
//    }
}

// MARK: - Float
extension Float {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places: Int) -> Float {
        let divisor = pow(10.0, Float(places))
        return (self * divisor).rounded() / divisor
    }
    
    func toString() -> String {
        let value = (self * 10).rounded(.toNearestOrAwayFromZero)
        return String(format: "%.1f", value / 10)

    }
    var intValue: Int {
        return Int(self)
    }
}

// MARK: - CGFloat
extension CGFloat {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places: Int) -> CGFloat {
        let divisor = pow(10.0, CGFloat(places))
        return (self * divisor).rounded() / divisor
    }
}

// MARK: - Double
extension Double {
    var asString: String {
        return String(self)
    }
    
    /// Rounds the double to decimal places value
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    func secondsToHoursMinutesSeconds() -> (Int?, Int?, Int?) {
        let hrs = self / 3600
        let mins = (self.truncatingRemainder(dividingBy: 3600)) / 60
        let seconds = (self.truncatingRemainder(dividingBy: 3600)).truncatingRemainder(dividingBy: 60)
        return (Int(hrs) > 0 ? Int(hrs) : nil, Int(mins) > 0 ? Int(mins) : nil, Int(seconds) > 0 ? Int(seconds) : nil)
    }

    func getTimeString () -> String {
        let time = self.secondsToHoursMinutesSeconds()

        let hrTitle = "giờ"
        let minTitle = "phút"
        let secTitle = "giây"
        
        switch time {
        case (nil, let m?, let s?):
            return "\(m) \(minTitle) \(s) \(secTitle)"
        case (nil, let m?, nil):
            return "\(m) \(minTitle)"
        case (let h?, nil, nil):
            return "\(h) \(hrTitle)"
        case (nil, nil, let s?):
            return "\(s) \(secTitle)"
        case (let h?, nil, let s?):
            return "\(h) \(hrTitle) \(s) \(secTitle)"
        case (let h?, let m?, nil):
            return "\(h) \(hrTitle) \(m) \(minTitle)"
        case (let h?, let m?, let s?):
            return "\(h) \(hrTitle) \(m) \(minTitle) \(s) \(secTitle)"
        default:
            return "00:00" //"n/a"
        }
    }
}

// MARK: - Int
extension Int {
    func formatNumber() -> String {
        let formater = NumberFormatter()
        formater.groupingSeparator = "."
        formater.numberStyle = .decimal
        return formater.string(from: NSNumber(value: self))!
    }
    
    func toStringWithCommas() -> String? {
        let numberFormater = NumberFormatter()
        numberFormater.numberStyle = .decimal
        return numberFormater.string(from: NSNumber(value: self))
    }
    
    var cgFloatValue: CGFloat {
        return CGFloat(self)
    }

    var doubleValue: Double {
        return Double(self)
    }
    
//    var asTimeFormat: String {
//        let value = TimeInterval(self)
//        return value.asTimeFormat
//    }
    
//    var asTimeFormatFull: String {
//        let (h, m, s) = Utils.shared.secondsToHoursMinutesSeconds(seconds: self)
//        return String(format: "%02d:%02d:%02d", h, m, s)
//    }
    
    var asString: String {
        return String(self)
    }
    
    func secondsToHoursMinutesSeconds() -> (Int, Int, Int) {
        let seconds = self
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    func toHoursMinutesSeconds() -> String {
        let (h, m, s) = self.secondsToHoursMinutesSeconds()
        return "\(h):\(m):\(s)"
    }
    
    func toHoursMinute() -> String {
        let (h, m, _) = self.secondsToHoursMinutesSeconds()
        return "\(h):\(m)"
    }
    
    var asTimeSecond: Int? {
        return self * 60
    }
}

// MARK: - CGFloat
extension CGFloat {
    var intValue: Int {
        return Int(self)
    }
}

extension CGFloat {
    var doubleValue: Double {
        return Double(self)
    }
}

