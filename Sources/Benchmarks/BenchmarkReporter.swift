//
//  BenchmarkReporter.swift
//
//  Created by Vitali Kurlovich on 30.03.25.
//

@available(macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0, *)
open class BenchmarkReporter {
    open func reportBeginWarming(info _: WarmingInfo) {}
    open func reportWarmingProgress(info _: WarmingInfo, _: Double) {}
    open func reportEndWarming() {}

    open func reportBegin(info _: BenchmarkInfo) {}
    open func report(info _: BenchmarkInfo, progress _: Double) {}
    open func reportEnd(info _: BenchmarkInfo, statistic _: Statistics) {}

    open func reportFinishAll(_: [(info: BenchmarkInfo, statistic: Statistics)]) {}
}
