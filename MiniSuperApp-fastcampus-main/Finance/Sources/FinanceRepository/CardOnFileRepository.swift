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
import Network

public protocol CardOnFileRepository {
    var cardOnFile: ReadOnlyCurrentValuePublisher<[PaymentMethod]> { get }
    func addCard(info: AddPaymentMethodInfo) -> AnyPublisher<PaymentMethod, Error>
    func fetch()
}

public final class CardOnFileRepositoryImp: CardOnFileRepository {
    public var cardOnFile: ReadOnlyCurrentValuePublisher<[PaymentMethod]> { paymentMethodsSubject }

    private let paymentMethodsSubject = CurrentValuePublisher<[PaymentMethod]>([
//        PaymentMethod(id: "4", name: "카카오카드", digits: "0123", color: "#ffcc00ff", isPrimary: false),
//        PaymentMethod(id: "0", name: "신한은행", digits: "0123", color: "#f19a38ff", isPrimary: false),
//        PaymentMethod(id: "0", name: "신한은행", digits: "0123", color: "#f19a38ff", isPrimary: false),
//        PaymentMethod(id: "4", name: "카카오카드", digits: "0123", color: "#ffcc00ff", isPrimary: false)
        ])
    //카드 쪽 데이터와. APi 연동
    
    public func addCard(info: AddPaymentMethodInfo) -> AnyPublisher<PaymentMethod, Error> {
        let reqeust = AddCardRequest(baseURL: baseURL, info: info)
        return network.send(reqeust)
            .map(\.output.card)
            .handleEvents(
                receiveSubscription: nil,
                receiveOutput: { [weak self] method in
                    guard let this = self else { return }
                    this.paymentMethodsSubject.send(this.paymentMethodsSubject.value + [method])
                },
                receiveCompletion: nil,
                receiveCancel: nil,
                receiveRequest: nil
            )
            .eraseToAnyPublisher()
    }
    
    public func fetch() {
        let reuqest = CardOnFileRequest(baseURL: baseURL)
        network.send(reuqest)
            .map(\.output.cards)
            .sink { _ in
                
            } receiveValue: { [weak self] cards in
                self?.paymentMethodsSubject.send(cards)
            }
            .store(in: &cancellables)

    }
    
    private let network: Network
    private let baseURL: URL
    private var cancellables: Set<AnyCancellable>
    
    public init(
        network: Network,
        baseURL: URL
    ) {
        self.network = network
        self.baseURL = baseURL
        self.cancellables = .init()
    }

}
