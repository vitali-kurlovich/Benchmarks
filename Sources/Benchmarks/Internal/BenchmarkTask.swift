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

extension BenchmarkTask {
    func run() -> Duration {
        let clock = ContinuousClock()

        return clock.measure {
            let context = BenchmarkContext()
            task(context)
        }
    }
}
