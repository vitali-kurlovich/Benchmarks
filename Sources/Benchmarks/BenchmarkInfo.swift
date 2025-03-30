//
//  BenchmarkInfo.swift
//
//  Created by Vitali Kurlovich on 30.03.25.
//

public struct BenchmarkInfo {
    public let name: String

    init(name: String) {
        self.name = name
    }
}

extension BenchmarkInfo {
    init(task: BenchmarkTask) {
        self.init(name: task.name)
    }
}
