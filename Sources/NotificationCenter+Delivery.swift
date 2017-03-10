//
//  NotificationCenter+Delivery.swift
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

import Foundation

public extension NotificationCenter {

#if DECLARE_STATIC

    /// Creates notification with a given name, sender and strongly typed object
    /// and posts it to the receiver.
    ///
    /// - Parameters:
    ///   - name: The name of the notification.
    ///   - fromObject: The object posting notification.
    ///   - withObject: The object will be passed with notification.
    public static func post<T>(name: Notification.Name, from fromObject: Any? = nil, with withObject: T) {
        NotificationCenter.default.post(name: name, object: fromObject, userInfo: ["\(T.self)": withObject])
    }

    /// Adds an observer to the receiver's dispatch table.
    ///
    /// - Parameters:
    ///   - name: The name of notification.
    ///   - type: Type of expected object in notification's `userInfo`.
    ///   - object: The object whose notifications the observer wants to receive.
    ///   - queue: The operation queue to which block should be added.
    ///   - block: The block to be executed when the notification is received and object's type matches with expected one.
    /// - Returns: An `ObservationToken`.
    public static func subscribe<T>(
        for name: Notification.Name,
        _ type: T.Type,
        from object: Any? = nil,
        on queue: OperationQueue? = nil,
        using block: @escaping (T) -> Void
    ) -> ObservationToken {
        let token = NotificationCenter.default.addObserver(forName: name, object: object, queue: queue) {
            if let object = $0.userInfo?["\(T.self)"] as? T {
                block(object)
            }
        }
        return ObservationToken(token: token)
    }

    /// Adds an observer to the receiver's dispatch table.
    ///
    /// - Parameters:
    ///   - name: The name of notification.
    ///   - type: Type of expected object in notification's `userInfo`.
    ///   - object: The object whose notifications the observer wants to receive.
    ///   - queue: The operation queue to which block should be added.
    ///   - block: The block to be executed with `Notification`'s `userInfo` when the notification is received.
    /// - Returns: An `ObservationToken`.
    public static func subscribe(
        for name: Notification.Name,
        from object: Any? = nil,
        on queue: OperationQueue? = nil,
        using block: @escaping ([AnyHashable: Any]?) -> Void
    ) -> ObservationToken {
        let token = NotificationCenter.default.addObserver(forName: name, object: object, queue: queue) {
            block($0.userInfo)
        }
        return ObservationToken(token: token)
    }


#else
    
    /// Creates notification with a given name, sender and strongly typed object
    /// and posts it to the receiver.
    ///
    /// - Parameters:
    ///   - name: The name of the notification.
    ///   - fromObject: The object posting notification.
    ///   - withObject: The object will be passed with notification.
    public func post<T>(name: Notification.Name, from fromObject: Any? = nil, with withObject: T) {
        post(name: name, object: fromObject, userInfo: ["\(T.self)": withObject])
    }
    
    /// Adds an observer to the receiver's dispatch table.
    ///
    /// - Parameters:
    ///   - name: The name of notification.
    ///   - type: Type of expected object in notification's `userInfo`.
    ///   - object: The object whose notifications the observer wants to receive.
    ///   - queue: The operation queue to which block should be added.
    ///   - block: The block to be executed when the notification is received and object's type matches with expected one.
    /// - Returns: An `ObservationToken`.
    public func subscribe<T>(
        for name: Notification.Name,
        _ type: T.Type,
        from object: Any? = nil,
        on queue: OperationQueue? = nil,
        using block: @escaping (T) -> Void
    ) -> ObservationToken {
        let token = addObserver(forName: name, object: object, queue: queue) {
            if let object = $0.userInfo?["\(T.self)"] as? T {
                block(object)
            }
        }
        return ObservationToken(token: token)
    }
    
    /// Adds an observer to the receiver's dispatch table.
    ///
    /// - Parameters:
    ///   - name: The name of notification.
    ///   - type: Type of expected object in notification's `userInfo`.
    ///   - object: The object whose notifications the observer wants to receive.
    ///   - queue: The operation queue to which block should be added.
    ///   - block: The block to be executed with `Notification`'s `userInfo` when the notification is received.
    /// - Returns: An `ObservationToken`.
    public func subscribe(
        for name: Notification.Name,
        from object: Any? = nil,
        on queue: OperationQueue? = nil,
        using block: @escaping ([AnyHashable: Any]?) -> Void
    ) -> ObservationToken {
        let token = addObserver(forName: name, object: object, queue: queue) {
            block($0.userInfo)
        }
        return ObservationToken(token: token)
    }

#endif
}
