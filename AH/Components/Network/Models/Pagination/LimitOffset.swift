//
//  LimitOffsetParams.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import Foundation

struct LimitOffset: RequestParams {
    static let defaultLimit = 20
    static let defaultPage = 1
    
    // MARK: - Properties

    var page: Int
    let limit: Int
    let total: Int?
    
    var hasMore: Bool { total.flatMap { $0 > page * limit } ?? true }
    var isFirstPage: Bool { page == LimitOffset.defaultPage }
    var builder: Parameters {
        Parameters {
            $0.p <- page
            $0.ps <- limit
        }
    }
    
    // MARK: - Lifecycle

    init(page: Int = defaultPage, limit: Int = defaultLimit, total: Int? = nil) {
        self.page = page
        self.limit = limit
        self.total = total
    }
    
    // MARK: - Helper Methods
    
    mutating func nextPage() -> LimitOffset? {
        guard hasMore else { return nil }
        page += 1
        return self
    }
    
    @discardableResult
    mutating func reset(with limit: Int?) -> LimitOffset {
        self = LimitOffset(page: LimitOffset.defaultPage, limit: limit ?? self.limit)
        return self
    }
}
