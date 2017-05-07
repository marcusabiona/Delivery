//
//  NotificationCenter+Keyboard.swift
//  Delivery
//
//  Created by Aleksei Zaikin on 08/05/2017.
//  Copyright © 2017 Aleksei Zaikin. All rights reserved.
//

import UIKit

public extension NotificationCenter {

    /// Adds an observer to the receiver's dispatch table for Notification.Name.UIKeyboardWillShow.
    ///
    /// - Parameters:
    ///   - object: The object whose notifications the observer wants to receive.
    ///   - queue: The operation queue to which block should be added.
    ///   - block: The block to be executed with `KeyboardNotification` when the notification is received.
    /// - Returns: An `ObservationToken`.
    public func subscribeForKeyboardWillShow(
        from object: Any? = nil,
        on queue: OperationQueue? = nil,
        using block: @escaping (KeyboardNotification) -> Void
        ) -> ObservationToken {
        let token = addObserver(forName: .UIKeyboardWillShow, object: object, queue: queue) {
            block(KeyboardNotification(note: $0))
        }
        return ObservationToken(token: token)
    }

    /// Adds an observer to the receiver's dispatch table for Notification.Name.UIKeyboardDidShow.
    ///
    /// - Parameters:
    ///   - object: The object whose notifications the observer wants to receive.
    ///   - queue: The operation queue to which block should be added.
    ///   - block: The block to be executed with `KeyboardNotification` when the notification is received.
    /// - Returns: An `ObservationToken`.
    public func subscribeForKeyboardDidShow(
        from object: Any? = nil,
        on queue: OperationQueue? = nil,
        using block: @escaping (KeyboardNotification) -> Void
        ) -> ObservationToken {
        let token = addObserver(forName: .UIKeyboardDidShow, object: object, queue: queue) {
            block(KeyboardNotification(note: $0))
        }
        return ObservationToken(token: token)
    }

    /// Adds an observer to the receiver's dispatch table for Notification.Name.UIKeyboardWillHide.
    ///
    /// - Parameters:
    ///   - object: The object whose notifications the observer wants to receive.
    ///   - queue: The operation queue to which block should be added.
    ///   - block: The block to be executed with `KeyboardNotification` when the notification is received.
    /// - Returns: An `ObservationToken`.
    public func subscribeForKeyboardWillHide(
        from object: Any? = nil,
        on queue: OperationQueue? = nil,
        using block: @escaping (KeyboardNotification) -> Void
        ) -> ObservationToken {
        let token = addObserver(forName: .UIKeyboardWillHide, object: object, queue: queue) {
            block(KeyboardNotification(note: $0))
        }
        return ObservationToken(token: token)
    }

    /// Adds an observer to the receiver's dispatch table for Notification.Name.UIKeyboardDidHide.
    ///
    /// - Parameters:
    ///   - object: The object whose notifications the observer wants to receive.
    ///   - queue: The operation queue to which block should be added.
    ///   - block: The block to be executed with `KeyboardNotification` when the notification is received.
    /// - Returns: An `ObservationToken`.
    public func subscribeForKeyboardDidHide(
        from object: Any? = nil,
        on queue: OperationQueue? = nil,
        using block: @escaping (KeyboardNotification) -> Void
        ) -> ObservationToken {
        let token = addObserver(forName: .UIKeyboardDidHide, object: object, queue: queue) {
            block(KeyboardNotification(note: $0))
        }
        return ObservationToken(token: token)
    }

    /// Adds an observer to the receiver's dispatch table for Notification.Name.UIKeyboardWillChangeFrame.
    ///
    /// - Parameters:
    ///   - object: The object whose notifications the observer wants to receive.
    ///   - queue: The operation queue to which block should be added.
    ///   - block: The block to be executed with `KeyboardNotification` when the notification is received.
    /// - Returns: An `ObservationToken`.
    public func subscribeForKeyboardWillChangeFrame(
        from object: Any? = nil,
        on queue: OperationQueue? = nil,
        using block: @escaping (KeyboardNotification) -> Void
        ) -> ObservationToken {
        let token = addObserver(forName: .UIKeyboardWillChangeFrame, object: object, queue: queue) {
            block(KeyboardNotification(note: $0))
        }
        return ObservationToken(token: token)
    }
}
