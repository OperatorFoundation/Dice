import XCTest

@testable import Dice
import SwiftHexTools

final class DiceTests: XCTestCase {
    func testExample() throws
    {
        let result = Data(randomWithLength: 10)
        print(result.hex)
    }
}
