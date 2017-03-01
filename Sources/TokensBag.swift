//
//  TokensBag.swift
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

/// Simple constainer for observation tokens.
/// All contained tokens will be invalidated when tokens bag will be about to be deallocated.
public class TokensBag {
    
    /// Observation tokens stored by tokens bag.
    private var _tokens: [ObservationToken] = []
    
    /// Initializes new instance of `TokensBag`.
    public init() {
    }
    
    /// Adds new observation token.
    ///
    /// - Parameter token: Observation token will be added to `TokensBag`.
    public func add(token: ObservationToken) {
        _tokens.append(token)
    }
    
    /// Invalidates all contained tokens and removes them from tokens bag.
    /// This method also will be invoked when tokens bag will be about to be deallocated.
    public func invalidate() {
        _tokens.invalidate()
    }
}
