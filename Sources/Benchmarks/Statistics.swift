//
//  Statistics.swift
//  Benchmarks
//
//  Created by Vitali Kurlovich on 30.03.25.
//

import Foundation

public struct Statistics {
    public let min: Duration
    public let max: Duration
    public let mean: Duration
}

extension Statistics {
    init(_ durations: [Duration]) {
        assert(!durations.isEmpty)

        let min = durations.min()!
        let max = durations.max()!
        let sum = durations.reduce(.seconds(0)) { $0 + $1 }
        let mean = sum / durations.count

        self.init(min: min, max: max, mean: mean)
    }
}
