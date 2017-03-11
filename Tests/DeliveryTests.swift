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

    func testGenericNotificationsReceiving() {

        var receivedUser: User!
        var receivedInt: Int!
        var voidReceived = false

        NotificationCenter.default.subscribe(for: .testing, User.self) {
            receivedUser = $0
        }.add(to: _bag)

        NotificationCenter.default.subscribe(for: .testing, Int.self) {
            receivedInt = $0
        }.add(to: _bag)

        NotificationCenter.default.subscribe(for: .testing, Void.self) {
            voidReceived = true
        }.add(to: _bag)

        NotificationCenter.default.post(name: .testing, with: User(name: "Beast", age: 666))
        NotificationCenter.default.post(name: .testing, with: 10)
        NotificationCenter.default.post(name: .testing, with: ())

        XCTAssertEqual(receivedUser.name, "Beast", "User's name is not equal to Beast.")
        XCTAssertEqual(receivedUser.age, 666, "User's age is not equal to 666.")
        XCTAssertEqual(receivedInt, 10, "Int is not equal to 10.")
        XCTAssertTrue(voidReceived, "Void notification has not been received.")
    }

    func testUserInfo() {

        var userInfo: [AnyHashable: Any]?

        NotificationCenter.default.subscribe(for: .testing) {
            userInfo = $0
            }.add(to: _bag)

        NotificationCenter.default.post(
            name: .testing,
            object: nil,
            userInfo: [
                "name": "Beast",
                "age": 666
            ]
        )

        XCTAssertEqual((userInfo?["name"] as? String) ?? "", "Beast")
        XCTAssertEqual((userInfo?["age"] as? Int) ?? 0, 666)
    }

    func testTokenInvalidation() {

        let nonOptToken: ObservationToken
        var optToken: ObservationToken?

        var intReceived = false
        var voidReceived = false

        nonOptToken = NotificationCenter.default.subscribe(for: .testing, Int.self) { _ in
            intReceived = true
        }

        optToken = NotificationCenter.default.subscribe(for: .testing, Void.self) {
            voidReceived = true
        }

        _ = optToken // To supress warning
        nonOptToken.invalidate()
        optToken = nil

        NotificationCenter.default.post(name: .testing, with: 10)
        NotificationCenter.default.post(name: .testing, with: ())

        XCTAssertFalse(intReceived, "Int notification shouldn't be received.")
        XCTAssertFalse(voidReceived, "Void notification shouldn't be received.")
    }

    func testTokensBagInvalidation() {

        var intReceived = false
        var voidReceived = false

        NotificationCenter.default.subscribe(for: .testing, Int.self) { _ in
            intReceived = true
        }.add(to: _bag)

        NotificationCenter.default.subscribe(for: .testing, Void.self) {
            voidReceived = true
        }.add(to: _bag)

        _bag.invalidate()

        NotificationCenter.default.post(name: .testing, with: 10)
        NotificationCenter.default.post(name: .testing, with: ())

        XCTAssertFalse(intReceived, "Int notification shouldn't be received")
        XCTAssertFalse(voidReceived, "Void notification shouldn't be received")
    }
}
