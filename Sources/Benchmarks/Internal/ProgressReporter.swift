//
//  ProgressReporter.swift
//
//  Created by Vitali Kurlovich on 30.03.25.
//

import ConsoleKit

@available(macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0, *)
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
