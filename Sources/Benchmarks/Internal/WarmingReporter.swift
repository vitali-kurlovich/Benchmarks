//
//  WarmingReporter.swift
//
//  Created by Vitali Kurlovich on 30.03.25.
//

import class ConsoleKit.ActivityIndicator
import struct ConsoleKit.ProgressBar
import class ConsoleKit.Terminal

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
