import XCTest
import class Foundation.Bundle
@testable import Cron

final class CronJobTests: XCTestCase {
    
    func test_addTask() {
        let simulatedTime = createTestDateTime(simulatedTime: "16:10")
        var sut = CronJob(simulatedTime: simulatedTime)
        
        let task = Task(minute: TaskValue.convertToValue("45"), hour: TaskValue.convertToValue("*"), name: "/bin/run_me_hourly")
        
        XCTAssertEqual(sut.tasks.count, 0)
        
        sut.addTask(task)
        
        XCTAssertEqual(sut.tasks.count, 1)
    }
    
    func test_noTasksAdded_output() {
        let simulatedTime = createTestDateTime(simulatedTime: "16:10")
        let sut = CronJob(simulatedTime: simulatedTime)
        
        XCTAssertEqual(sut.tasks.count, 0)
        
        let expectedOutput = "No tasks to run for this job"
        
        XCTAssertEqual(sut.description, expectedOutput)
    }
    
    func test_jobOutput() {
        let simulatedTime = createTestDateTime(simulatedTime: "16:10")
        var sut = CronJob(simulatedTime: simulatedTime)
        
        let task = Task(minute: TaskValue.convertToValue("45"), hour: TaskValue.convertToValue("*"), name: "/bin/run_me_hourly")
                
        sut.addTask(task)
        
        let expectedOutput = "\n16:45 today /bin/run_me_hourly"
        
        XCTAssertEqual(sut.description, expectedOutput)
    }
}

/// helper for creating simulated time date object
func createTestDateTime(simulatedTime: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    
    return dateFormatter.date(from: simulatedTime)!
}
