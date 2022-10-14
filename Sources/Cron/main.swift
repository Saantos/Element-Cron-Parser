import ArgumentParser
import Foundation

struct Cron: ParsableCommand {
    /// Argument: Simulated time in the format of HH:mm
    /// help: info to tell consumer what should be passed in when --help is run on command
    @Argument(help: "Simulated time that should be in the format of HH:mm")
    var simulatedTimeString: String
        
    func run() {
        let simulatedTime = convertTimeToDate(from: simulatedTimeString)
        let job = createJobFromStandardInput(time: simulatedTime)
        print(job)
    }
    
    /// Create CronJob by creating CronTasks by reading standard input and adding to Job
    /// return job
    private func createJobFromStandardInput(time: Date) -> CronJob {
        var job = CronJob(simulatedTime: time)
        
        while let input = readLine() {
            let components = input.components(separatedBy: .whitespaces)
            let t = Task(minute: TaskValue.convertToValue(components[0]) , hour: TaskValue.convertToValue(components[1]), name: components[2])
            job.addTask(t)
        }
        
        return job
    }
    
    // Converts the simulated time passed in via an argument
    // tries to format the time string to the expected format
    private func convertTimeToDate(from time: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        guard let date = dateFormatter.date(from: time) else {
            fatalError("Simulated time is invalid.")
        }
    
        return date
    }
}

Cron.main()
