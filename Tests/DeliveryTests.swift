//
//  DeliveryTests.swift
//
//  Copyright (c) 2016 Aleksei Zaikin
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

@testable import Delivery
import XCTest

class DeliveryTests: XCTestCase {

    private var _bag = TokensBag()

    override func tearDown() {
        super.tearDown()
        _bag.invalidate()
    }

    func testNotificationsReceiving() {
        
        NotificationCenter.default.subscribe(for: .testing, User.self) {
            XCTAssertEqual($0.name, "Beast")
            XCTAssertEqual($0.age, 666)
        }.add(to: _bag)

        NotificationCenter.default.subscribe(for: .testing, Int.self) {
            XCTAssertEqual($0, 10)
        }.add(to: _bag)

        NotificationCenter.default.post(name: .testing, with: User(name: "Beast", age: 666))
        NotificationCenter.default.post(name: .testing, with: 10)
    }

    func testTokenInvalidation() {
        let token = NotificationCenter.default.subscribe(for: .testing, Int.self) { _ in
            XCTFail("You shouldn't be here!")
        }
        token.invalidate()
        NotificationCenter.default.post(name: .testing, with: 10)
    }
}
