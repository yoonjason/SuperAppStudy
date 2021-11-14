//
//  CardOnFileRepository.swift
//  MiniSuperApp
//
//  Created by Bradley.yoon on 2021/11/14.
//

import Foundation

protocol CardOnFileRepository {
    var cardOnFile: ReadOnlyCurrentValuePublisher<[PaymentMethod]> { get }
}

final class CardOnFileRepositoryImp: CardOnFileRepository {
    var cardOnFile: ReadOnlyCurrentValuePublisher<[PaymentMethod]> { paymentMethodsSubject }

    private let paymentMethodsSubject = CurrentValuePublisher<[PaymentMethod]>([
        PaymentMethod(id: "0", name: "신한은행", digits: "0123", color: "#f19a38ff", isPrimary: false),
        PaymentMethod(id: "1", name: "우리카드", digits: "0988", color: "#f347f6ff", isPrimary: false),
        PaymentMethod(id: "2", name: "현대카드", digits: "0123", color: "#f78c5f5ff", isPrimary: false),
        PaymentMethod(id: "3", name: "국민카드", digits: "0123", color: "#65c46fff", isPrimary: false),
        PaymentMethod(id: "4", name: "카카오카드", digits: "0123", color: "#ffcc00ff", isPrimary: false)
        ])
}
