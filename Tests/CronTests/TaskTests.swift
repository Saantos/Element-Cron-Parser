//
//  TaskTests.swift
//  
//
//  Created by Fernando Santos on 13/10/2022.
//

import XCTest
@testable import Cron

class TaskTests: XCTestCase {
    
    // MARK: Run daily
    
    func test_daily_today() {
        let simulatedTime = createTestDateTime(simulatedTime: "12:30")
        let sut = createTask(minute: "10", hour: "18", name: "/bin/run_me_daily_today")
        let output = sut.nextRunTime(for: simulatedTime)
        let expectedOutput = "18:10 today /bin/run_me_daily_today"
        
        XCTAssertEqual(output, expectedOutput)
    }

    func test_daily_tomorrow() {
        let simulatedTime = createTestDateTime(simulatedTime: "17:00")
        let sut = createTask(minute: "34", hour: "05", name: "/bin/run_me_daily_tomorrow")
        let output = sut.nextRunTime(for: simulatedTime)
        let expectedOutput = "5:34 tomorrow /bin/run_me_daily_tomorrow"
        
        XCTAssertEqual(output, expectedOutput)
    }
    
    // MARK: Run sixty times tests
    func test_runSixtyTimes_today() {
        let simulatedTime = createTestDateTime(simulatedTime: "12:30")
        let sut = createTask(minute: "*", hour: "18", name: "/bin/run_me_sixty_times")
        let output = sut.nextRunTime(for: simulatedTime)
        let expectedOutput = "18:30 today /bin/run_me_sixty_times"
        
        XCTAssertEqual(output, expectedOutput)
    }

    func test_runSixtyTimes_tomorrow() {
        let simulatedTime = createTestDateTime(simulatedTime: "23:30")
        let sut = createTask(minute: "*", hour: "05", name: "/bin/run_me_sixty_times")
        let output = sut.nextRunTime(for: simulatedTime)
        let expectedOutput = "5:30 tomorrow /bin/run_me_sixty_times"
        
        XCTAssertEqual(output, expectedOutput)
    }
    
    // MARK: Run hourly tests
    
    func test_runHourly_today() {
        let simulatedTime = createTestDateTime(simulatedTime: "12:30")
        let sut = createTask(minute: "20", hour: "*", name: "/bin/run_me_hourly")
        let output = sut.nextRunTime(for: simulatedTime)
        let expectedOutput = "13:20 today /bin/run_me_hourly"
        
        XCTAssertEqual(output, expectedOutput)
    }

    func test_runHourly_tomorrow() {
        let simulatedTime = createTestDateTime(simulatedTime: "23:30")
        let sut = createTask(minute: "20", hour: "*", name: "/bin/run_me_hourly")
        let output = sut.nextRunTime(for: simulatedTime)
        let expectedOutput = "00:20 tomorrow /bin/run_me_hourly"
        
        XCTAssertEqual(output, expectedOutput)
    }

    // MARK: Same hour tests
    
    func test_sameHour_today() {
        let simulatedTime = createTestDateTime(simulatedTime: "18:30")
        let sut = createTask(minute: "56", hour: "18", name: "/bin/run_me_today")
        let output = sut.nextRunTime(for: simulatedTime)
        let expectedOutput = "18:56 today /bin/run_me_today"
        
        XCTAssertEqual(output, expectedOutput)
    }
    
    func test_sameHour_tomorrow() {
        let simulatedTime = createTestDateTime(simulatedTime: "20:30")
        let sut = createTask(minute: "20", hour: "20", name: "/bin/run_me_tomorrow")
        let output = sut.nextRunTime(for: simulatedTime)
        let expectedOutput = "20:20 tomorrow /bin/run_me_tomorrow"
        
        XCTAssertEqual(output, expectedOutput)
    }
}

fileprivate extension TaskTests {
    
    /// helper function to easily create tasks by passing in the relevant parameters
    func createTask(minute: String, hour: String, name: String) -> Task {
        let minuteValue = TaskValue.convertToValue(minute)
        let hourValue = TaskValue.convertToValue(hour)
        
        return Task(minute: minuteValue, hour: hourValue, name: name)
    }
}
