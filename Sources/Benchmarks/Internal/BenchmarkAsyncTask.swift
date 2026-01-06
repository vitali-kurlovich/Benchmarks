//
//  BenchmarkAsyncTask.swift
//  swift-benchmarks
//
//  Created by Vitali Kurlovich on 28.07.25.
//

struct BenchmarkAsyncTask {
    let id: Int
    let name: String

    let task: (BenchmarkContext) async -> Void
}

extension BenchmarkAsyncTask {
    func run() async -> Duration {
        let clock = ContinuousClock()

        return await clock.measure {
            let context = BenchmarkContext()
            await task(context)
        }
    }
}
