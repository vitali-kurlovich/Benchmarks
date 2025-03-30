//
//  BenchmarkContext.swift
//
//  Created by Vitali Kurlovich on 30.03.25.
//

public struct BenchmarkContext {
    @_optimize(none)
    public func blackHole<T>(_: T) {}
}
