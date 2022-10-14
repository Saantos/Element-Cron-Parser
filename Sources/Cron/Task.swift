//
//  Task.swift
//  
//
//  Created by Fernando Santos on 13/10/2022.
//

import Foundation

struct Task {
    let minute: TaskValue
    let hour: TaskValue
    let name: String
    
    /// Apologies for the mess but all i could do within the allocated time
    /// here we are checking for all the scenarios for the simulated time against
    /// the task run time
    func nextRunTime(for time: Date) -> String {
        let today = "today"
        let tomorrow = "tomorrow"
        
        let simulatedHour = getHour(from: time)
        let simulatedMinute = getMinute(from: time)
        
        if case .asterisk = minute {
            if case .asterisk = hour {
                return "\(simulatedHour):\(formatMinutes(simulatedMinute)) \(today) \(name)"
            }
            
            if case .value(let hour) = hour {
                if simulatedHour > hour, hour == 23 {
                    return "00:\(formatMinutes(simulatedMinute)) \(tomorrow) \(name)"
                } else if simulatedHour > hour {
                    return "\(hour):\(formatMinutes(simulatedMinute)) \(tomorrow) \(name)"
                } else {
                    return "\(hour):\(formatMinutes(simulatedMinute)) \(today) \(name)"
                }
            }
        }
        
        if case .value(let minute) = minute {
            if case .asterisk = hour {
                if simulatedMinute > minute, simulatedHour == 23 {
                    return "00:\(formatMinutes(minute)) \(tomorrow) \(name)"
                } else if simulatedMinute > minute {
                    return "\(simulatedHour + 1):\(formatMinutes(minute)) \(today) \(name)"
                } else {
                    return "\(simulatedHour):\(formatMinutes(minute)) \(today) \(name)"
                }
            }
            
            if case .value(let hour) = hour {
                if simulatedHour > hour {
                    return "\(hour):\(formatMinutes(minute)) \(tomorrow) \(name)"
                } else if simulatedHour == hour && simulatedMinute > minute {
                    return "\(hour):\(formatMinutes(minute)) \(tomorrow) \(name)"
                } else {
                    return "\(hour):\(formatMinutes(minute)) \(today) \(name)"
                }
            }
        }
        
        // Couldn't think of anymore scenarios
        // this will stop it erroring out and breaking any randomized test
        // scenarios i've not thought of
        return ""
    }
}

private extension Task {
    private func getHour(from date: Date) -> Int {
        let calendar = Calendar.current
        return calendar.component(.hour, from: date)
    }
    
    private func getMinute(from date: Date) -> Int {
        let calendar = Calendar.current
        return calendar.component(.minute, from: date)
    }
    
    private func formatMinutes(_ minute: Int) -> String {
        if minute >= 0, minute < 10 {
            return "0\(minute)"
        }
        return "\(minute)"
    }
}


enum TaskValue {
    case asterisk
    case value(timeElement: Int)
    
    public static func convertToValue(_ value: String) -> Self {
        guard !value.isEmpty else { fatalError("Missing Task Value") }
        
        if value == "*" { return .asterisk }
        if value.rangeOfCharacter(from: .decimalDigits) != nil {
            if let convertedTimeElement = Int(value) {
                return .value(timeElement: convertedTimeElement)
            }
        }
        fatalError("Unknown command value")
    }
}
