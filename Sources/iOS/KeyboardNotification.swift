//
//  KeyboardNotification.swift
//  Delivery
//
//  Created by Aleksei Zaikin on 08/05/2017.
//  Copyright © 2017 Aleksei Zaikin. All rights reserved.
//

import UIKit

/// Wrapper around `Notification` with keyboard information.
public struct KeyboardNotification {

    /// User info of original notification.
    public let userInfo: [AnyHashable: Any]

    /// Initializes new `KeyboardNotification` with specified `NSNotification`.
    ///
    /// - Parameter note: Original `NSNotification`.
    init(note: Notification) {
        userInfo = note.userInfo ?? [:]
    }

    /// Keyboard's frame at the beginning of animation.
    public var frameBegin: CGRect {
        guard let value = userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue else {
            return .zero
        }
        return value.cgRectValue
    }

    /// Keyboard's frame at the end of animation.
    public var frameEnd: CGRect {
        guard let value = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue else {
            return .zero
        }
        return value.cgRectValue
    }

    /// Duration of keyboard's animation
    public var duration: TimeInterval {
        guard let number = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber else {
            return 0.25
        }
        return number.doubleValue
    }

    /// Media timing function of keyboard's animation.
    public var curve: UIViewAnimationOptions {
        guard let number = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber else {
            return .curveEaseInOut
        }
        return UIViewAnimationOptions(rawValue: number.uintValue)
    }

    /// Converts original frame of keyboard at the beginning to frame in specified view.
    ///
    /// - Parameter view: View will be used to convert frame.
    /// - Returns: The converted frame.
    public func frameBeginConverted(for view: UIView) -> CGRect {
        return view.convert(frameBegin, from: nil)
    }

    /// Converts original frame of keyboard at the end to frame in specified view.
    ///
    /// - Parameter view: View will be used to convert frame.
    /// - Returns: The converted frame.
    public func frameEndConverted(for view: UIView) -> CGRect {
        return view.convert(frameEnd, from: nil)
    }
}
