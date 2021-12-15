//
//  File.swift
//
//
//  Created by Bradley.yoon on 2021/12/15.
//

import Foundation
import Network

struct TopupRequest: Request {
    typealias Output = TopupResponse

    let endpoint: URL
    let method: HTTPMethod
    let query: QueryItems
    let header: HTTPHeader

    init(baseURL: URL, amount: Double, paymentMethodID: String) {
        self.endpoint = baseURL.appendingPathComponent("/topup")
        self.method = .post
        self.query = [
            "amount": amount,
            "paymentMethod": paymentMethodID
        ]
        self.header = [:]
    }

}

struct TopupResponse: Decodable {
    let status: String
}
