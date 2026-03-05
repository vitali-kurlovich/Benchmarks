//
//  Statistics.swift
//
//  Created by Vitali Kurlovich on 30.03.25.
//

@available(macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0, *)
public struct Statistics: Hashable, Codable, Sendable {
    public let min: Duration
    public let max: Duration
    public let mean: Duration
}

@available(macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0, *)
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
