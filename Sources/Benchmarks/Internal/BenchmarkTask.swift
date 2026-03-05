//
//  BenchmarkTask.swift
//  Benchmarks
//
//  Created by Vitali Kurlovich on 30.03.25.
//

struct BenchmarkTask {
    let id: Int
    let name: String

    let task: (BenchmarkContext) -> Void
}

@available(macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0, *)
extension BenchmarkTask {
    func run() -> Duration {
        let clock = ContinuousClock()

        return clock.measure {
            let context = BenchmarkContext()
            task(context)
        }
    }
}
