//
//  WarmingReporter.swift
//  Benchmarks
//
//  Created by Vitali Kurlovich on 30.03.25.
//

import ConsoleKit

final class WarmingReporter: BenchmarkReporter {
    let console = Terminal()
    lazy var progressBar = console.progressBar(title: "Warming...")

    override func reportBeginWarming(info _: WarmingInfo) {
        print("Start warming")
        progressBar.start()
    }

    override func reportWarmingProgress(info _: WarmingInfo, _ progress: Double) {
        progressBar.activity.currentProgress = progress
    }

    override func reportEndWarming() {
        progressBar.succeed()
    }
}
