//
//  PaymentMethod.swift
//  MiniSuperApp
//
//  Created by Bradley.yoon on 2021/11/14.
//

import Foundation

struct PaymentMethod: Codable {
    let id: String
    let name: String
    let digits: String
    let color:String
    let isPrimary: Bool
}
