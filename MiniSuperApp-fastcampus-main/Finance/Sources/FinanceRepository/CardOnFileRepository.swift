//
//  CardOnFileRepository.swift
//  MiniSuperApp
//
//  Created by Bradley.yoon on 2021/11/14.
//

import Foundation
import Combine
import FinanceEntity
import CombineUtil

public protocol CardOnFileRepository {
    var cardOnFile: ReadOnlyCurrentValuePublisher<[PaymentMethod]> { get }
    func addCard(info: AddPaymentMethodInfo) -> AnyPublisher<PaymentMethod, Error>
}

public final class CardOnFileRepositoryImp: CardOnFileRepository {
    public var cardOnFile: ReadOnlyCurrentValuePublisher<[PaymentMethod]> { paymentMethodsSubject }

    private let paymentMethodsSubject = CurrentValuePublisher<[PaymentMethod]>([
        PaymentMethod(id: "4", name: "카카오카드", digits: "0123", color: "#ffcc00ff", isPrimary: false),
        PaymentMethod(id: "0", name: "신한은행", digits: "0123", color: "#f19a38ff", isPrimary: false),
        PaymentMethod(id: "0", name: "신한은행", digits: "0123", color: "#f19a38ff", isPrimary: false),
        PaymentMethod(id: "4", name: "카카오카드", digits: "0123", color: "#ffcc00ff", isPrimary: false)
        ])
    //카드 쪽 데이터와. APi 연동
    
    public func addCard(info: AddPaymentMethodInfo) -> AnyPublisher<PaymentMethod, Error> {
        let paymentMethod = PaymentMethod(id: "0", name: "Kakao", digits: "\(info.number.suffix(4))", color: "", isPrimary: false)
        var new = paymentMethodsSubject.value
        new.append(paymentMethod)
        paymentMethodsSubject.send(new)
        return Just(paymentMethod).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
    public init() {
        
    }

}
