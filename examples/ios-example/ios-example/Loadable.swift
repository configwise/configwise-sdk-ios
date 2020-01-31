//
//  Loadable.swift
//  ios-example
//
//  Created by Sergey Muravev on 24.12.2019.
//  Copyright © 2019 VipaHelda BV. All rights reserved.
//

import Foundation

enum Loadable<T> {

    case notRequested
    case isLoading(last: T?)
    case loaded(T)
    case failed(Error)

    var value: T? {
        switch self {
        case let .loaded(value): return value
        case let .isLoading(last): return last
        default: return nil
        }
    }
    
    var error: Error? {
        switch self {
        case let .failed(error): return error
        default: return nil
        }
    }
    
    var isLoading: Bool {
        switch self {
        case .isLoading:
            return true
        default:
            return false
        }
    }
    
    var isLoaded: Bool {
        switch self {
        case .loaded: return true
        default: return false
        }
    }
    
    var isFailed: Bool {
        switch self {
        case .failed: return true
        default: return false
        }
    }
    
    var isNotRequested: Bool {
        switch self {
        case .notRequested: return true
        default: return false
        }
    }
}

extension Loadable: Equatable where T: Equatable {
    static func == (lhs: Loadable<T>, rhs: Loadable<T>) -> Bool {
        switch (lhs, rhs) {
        case (.notRequested, .notRequested): return true
        case let (.isLoading(lhsV), .isLoading(rhsV)): return lhsV == rhsV
        case let (.loaded(lhsV), .loaded(rhsV)): return lhsV == rhsV
        case let (.failed(lhsE), .failed(rhsE)):
            return lhsE.localizedDescription == rhsE.localizedDescription
        default: return false
        }
    }
}
