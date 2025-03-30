//
//  ProgressReporter.swift
//
//  Created by Vitali Kurlovich on 30.03.25.
//

import class ConsoleKit.ActivityIndicator
import struct ConsoleKit.ProgressBar
import class ConsoleKit.Terminal

final class ProgressReporter: BenchmarkReporter {
    let console = Terminal()
    lazy var progressBar = console.progressBar(title: "Progress...")

    override func reportBegin(info: BenchmarkInfo) {
        progressBar = console.progressBar(title: info.name)
        progressBar.start()
    }

    override func report(info _: BenchmarkInfo, progress: Double) {
        progressBar.activity.currentProgress = progress
    }

    override func reportEnd(info _: BenchmarkInfo, statistic _: Statistics) {
        progressBar.succeed()
    }
}
