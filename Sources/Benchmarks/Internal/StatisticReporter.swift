//
//  StatisticReporter.swift
//
//  Created by Vitali Kurlovich on 30.03.25.
//

import struct CLITable.CLITable

@available(macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0, *)
final class StatisticReporter: BenchmarkReporter {
    override func reportFinishAll(_ results: [(info: BenchmarkInfo, statistic: Statistics)]) {
        guard !results.isEmpty else { return }

        var table = CLITable(headers: ["Name", "Min", "Max", "Mean"])
        for result in results {
            let info = result.info
            let statistic = result.statistic

            table.addRow([info.name, "\(statistic.min)", "\(statistic.max)", "\(statistic.mean)"])
        }

        table.showTable()
    }
}
