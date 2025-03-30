//
//  BenchmarkTask.swift
//  Benchmarks
//
//  Created by Vitali Kurlovich on 30.03.25.
//

import struct Foundation.Duration

struct BenchmarkTask {
    let id: Int
    let name: String

    let task: (BenchmarkContext) -> Void
}

extension BenchmarkTask {
    func run() -> Duration {
        let context = BenchmarkContext()
        let clock = ContinuousClock()

        return clock.measure {
            task(context)
        }
    }
}
