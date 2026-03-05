//
//  Created by Vitali Kurlovich on 30.03.25.
//

@available(macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0, *)
public protocol BenchmarkExecuterProtocol {
    var name: String? { get }
    var repeatCount: Int { get }

    var warmingDuration: Duration { get }

    func start()
}

@available(macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0, *)
public final class BenchmarkExecuter: BenchmarkExecuterProtocol {
    public var name: String?
    public var repeatCount: Int
    public var warmingDuration: Duration

    public init(name: String? = nil,
                repeatCount: Int = 5,
                warmingDuration: Duration = .seconds(5))
    {
        self.name = name
        self.repeatCount = repeatCount
        self.warmingDuration = warmingDuration
    }

    private var tasks: [BenchmarkTask] = []
    private var tasksDurations: [[Duration]] = []

    private var reporters: [BenchmarkReporter] = [ProgressReporter(), WarmingReporter(), StatisticReporter()]
}

@available(macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0, *)
public extension BenchmarkExecuter {
    func start() {
        tasksDurations = tasks.map { _ in [] }
        warming(warmingDuration)

        for task in tasks {
            runTask(task)
        }

        var results: [(info: BenchmarkInfo, statistic: Statistics)] = []

        for task in tasks {
            let durations = tasksDurations[task.id]
            guard !durations.isEmpty else { continue }

            let info = BenchmarkInfo(task: task)
            let statistic = Statistics(durations)

            results.append((info: info, statistic: statistic))
        }

        reportFinishAll(results)
    }
}

@available(macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0, *)
public extension BenchmarkExecuter {
    func benchmark(name: String, task: @escaping (BenchmarkContext) -> Void) {
        let task = BenchmarkTask(id: tasks.endIndex, name: name, task: task)
        tasks.append(task)
    }

    func addReporter(_ reporter: BenchmarkReporter) {
        reporters.append(reporter)
    }
}

@available(macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0, *)
private extension BenchmarkExecuter {
    func runTask(_ task: BenchmarkTask) {
        reportBegin(task: task)

        var progress = 0.0
        let progressStep = 1.0 / Double(repeatCount > 0 ? repeatCount : 1)

        report(task: task, progress: progress)

        var count = repeatCount
        count -= 1

        let duration = task.run()
        tasksDurations[task.id].append(duration)

        progress += progressStep
        report(task: task, progress: progress)

        while count > 0 {
            count -= 1

            let duration = task.run()
            tasksDurations[task.id].append(duration)

            progress += progressStep
            report(task: task, progress: progress)
        }

        reportEnd(task: task, statistic: Statistics(tasksDurations[task.id]))
    }
}

@available(macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0, *)
private extension BenchmarkExecuter {
    func warming(_ duration: Duration) {
        var duration = duration

        let durationInSeconds = duration.components.seconds

        reportBeginWarming(info: .init(duration: duration))

        while duration > .zero {
            duration -= warmingIteration()

            let secondsLeft = duration.components.seconds
            let progress = 1.0 - Double(secondsLeft) / Double(durationInSeconds)

            reportWarmingProgress(info: .init(duration: duration), progress)
        }

        reportEndWarming()
    }

    func warmingIteration() -> Duration {
        var duration: Duration = .zero
        for task in tasks {
            duration += task.run()
        }
        return duration
    }
}

@available(macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0, *)
private extension BenchmarkExecuter {
    func reportBeginWarming(info: WarmingInfo) {
        for reporter in reporters {
            reporter.reportBeginWarming(info: info)
        }
    }

    func reportWarmingProgress(info: WarmingInfo, _ progress: Double) {
        for reporter in reporters {
            reporter.reportWarmingProgress(info: info, progress)
        }
    }

    func reportEndWarming() {
        for reporter in reporters {
            reporter.reportEndWarming()
        }
    }

    func reportBegin(task: BenchmarkTask) {
        let info = BenchmarkInfo(task: task)
        for reporter in reporters {
            reporter.reportBegin(info: info)
        }
    }

    func report(task: BenchmarkTask, progress: Double) {
        let info = BenchmarkInfo(task: task)
        for reporter in reporters {
            reporter.report(info: info, progress: progress)
        }
    }

    func reportEnd(task: BenchmarkTask, statistic: Statistics) {
        let info = BenchmarkInfo(task: task)
        for reporter in reporters {
            reporter.reportEnd(info: info, statistic: statistic)
        }
    }

    func reportFinishAll(_ results: [(info: BenchmarkInfo, statistic: Statistics)]) {
        for reporter in reporters {
            reporter.reportFinishAll(results)
        }
    }
}
