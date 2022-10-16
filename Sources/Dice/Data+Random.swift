//
//  Data+Random.swift
//  
//
//  Created by Dr. Brandon Wiley on 10/10/22.
//

import Foundation

#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
public struct SecRandomNumberGenerator: RandomNumberGenerator {
    public func next() -> UInt64 {
        let size = MemoryLayout<UInt64>.size
        var data = Data(count: size)
        return data.withUnsafeMutableBytes {
            guard 0 == SecRandomCopyBytes(kSecRandomDefault, size, $0.baseAddress!) else { fatalError() }
            return $0.load(as: UInt64.self)
        }
    }
}
#else
public struct SecRandomNumberGenerator: RandomNumberGenerator {
    public func next() -> UInt64 {
        return UInt64.random(in: 0...UInt64.max)
    }
}
#endif

public extension Data
{
    /// Returns cryptographically secure random data.
    ///
    /// - Parameter length: Length of the data in bytes.
    /// - Returns: Generated data of the specified length.
    init(randomWithLength length: Int)
    {
        var randomNumberGenerator = SecRandomNumberGenerator()
        self = Data((0 ..< length).map { _ in UInt8.random(in: UInt8.min ... UInt8.max, using: &randomNumberGenerator) })
    }
}
