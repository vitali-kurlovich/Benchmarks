//
//  Created by Vitali Kurlovich on 5.03.26.
//

import ArgumentParser
import Benchmarks

@main
struct BenchmarkCLI: ParsableCommand {
    @Argument(help: "The phrase to repeat.")
    var `repeat`: Int = 5

    mutating func run() throws {
        if #available(macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0, *) {
            runBenchmark()
        } else {
            print("Cannot be run on this os version.")
        }
    }
}

extension BenchmarkCLI {
    @available(macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0, *)
    func runBenchmark() {
        let benchmark = BenchmarkExecuter(repeatCount: self.repeat)

        let count = 100_000_000

        benchmark.benchmark(name: "Append \(count)") { _ in
            var array: [Int] = []
            for index in 0 ..< count {
                array.append(index)
            }

            blackHole(array.last)
        }

        benchmark.benchmark(name: "Append \(count) reserveCapacity") { _ in
            var array: [Int] = []
            array.reserveCapacity(count)
            for index in 0 ..< count {
                array.append(index)
            }

            blackHole(array.last)
        }

        benchmark.start()
    }
}
