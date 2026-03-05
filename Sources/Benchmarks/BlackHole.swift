//
//  BlackHole.swift
//  swift-benchmarks
//
//  Created by Vitali Kurlovich on 5.03.26.
//

@_optimize(none)
public func blackHole<T>(_: T) {}

public extension BenchmarkContext {
    @available(*, deprecated, message: "use blackHole without context")
    @_optimize(none)
    func blackHole<T>(_: T) {}
}
