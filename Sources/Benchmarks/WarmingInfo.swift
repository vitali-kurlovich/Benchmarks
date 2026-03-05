//
//  WarmingInfo.swift
//
//  Created by Vitali Kurlovich on 30.03.25.
//

@available(macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0, *)
public struct WarmingInfo: Hashable, Codable {
    public let duration: Duration
}
