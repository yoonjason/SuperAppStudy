//
//  PaymentMethod.swift
//  MiniSuperApp
//
//  Created by Bradley.yoon on 2021/11/14.
//

import Foundation

public struct PaymentMethod: Codable {
    public let id: String
    public let name: String
    public let digits: String
    public let color: String
    public let isPrimary: Bool

    public init(
        id: String,
        name: String,
        digits: String,
        color: String,
        isPrimary: Bool
    ) {
        self.id = id
        self.name = name
        self.digits = digits
        self.color = color
        self.isPrimary = isPrimary
    }
}
