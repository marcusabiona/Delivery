//
//  ObservationToken.swift
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

/// Token that used to identify observer in notification center.
/// Returned by notification center.
public class ObservationToken: NSObject {
    
    /// Underlying token returned by notification center.
    private let _token: NSObjectProtocol
    
    /// Initializes a new `ObservationToken` with token returned by notification center.
    ///
    /// - Parameter token: Token returned by notification center.
    init(token: NSObjectProtocol) {
        _token = token
    }
    
    /// Removes observation token from notification center.
    /// This method also will be invoked when observation token will be about to be deallocated.
    public func invalidate() {
        NotificationCenter.default.removeObserver(_token)
    }
    
    /// Provides convenient way to add observation token to tokens bag without creating new variable.
    ///
    /// - Parameter bag: Tokens bag will be used to store obervation token.
    public func add(to bag: TokensBag) {
        bag.add(token: self)
    }
    
    deinit {
        invalidate()
    }
}
