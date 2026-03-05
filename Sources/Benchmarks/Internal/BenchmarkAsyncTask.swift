//
//  BenchmarkAsyncTask.swift
//  swift-benchmarks
//
//  Created by Vitali Kurlovich on 28.07.25.
//

struct BenchmarkAsyncTask {
    let id: Int
    let name: String

    let task: @Sendable (BenchmarkContext) async -> Void
}

@available(macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0, *)
extension BenchmarkAsyncTask {
    func run() async -> Duration {
        let clock = ContinuousClock()

        return await clock.measure {
            let context = BenchmarkContext()
            await task(context)
        }
    }
}
