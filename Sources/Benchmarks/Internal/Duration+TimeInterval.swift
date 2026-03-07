//
//  Created by Vitali Kurlovich on 7.03.26.
//

import Foundation

@available(macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0, *)
extension Duration {
    var timeInterval: TimeInterval {
        TimeInterval(components.seconds) + TimeInterval(millisecondsComponent) / 1000.0
    }

    var millisecondsComponent: Int64 {
        components.attoseconds / 1_000_000_000_000_000
    }
}
