//
//  File.swift
//  
//
//  Created by Fernando Santos on 13/10/2022.
//

import Foundation

struct CronJob: CustomStringConvertible {
    
    private(set) var tasks = [Task]()
    let simulatedTime: Date
    
    mutating func addTask(_ task: Task) {
        tasks.append(task)
    }
    
    // conformance to CustomStringConvertible
    // loops through the array of tasks and builds
    // an output string
    var description: String {
        var output = ""
        
        if tasks.count < 1 {
            return "No tasks to run for this job"
        }
        
        for task in tasks {
            output += "\n"
            output += task.nextRunTime(for: simulatedTime)
            
        }
        return output
    }
}
