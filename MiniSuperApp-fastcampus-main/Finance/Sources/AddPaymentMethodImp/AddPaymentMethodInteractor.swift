//
//  AddPaymentMethodInteractor.swift
//  MiniSuperApp
//
//  Created by Bradley.yoon on 2021/11/14.
//

import ModernRIBs
import Combine
import FinanceEntity
import FinanceRepository
import AddPaymentMethod
import Foundation

protocol AddPaymentMethodRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol AddPaymentMethodPresentable: Presentable {
    var listener: AddPaymentMethodPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}



protocol AddPaymentMethodInteractorDependency {
    var cardOnFileRepository: CardOnFileRepository { get }
}

final class AddPaymentMethodInteractor: PresentableInteractor<AddPaymentMethodPresentable>, AddPaymentMethodInteractable, AddPaymentMethodPresentableListener {

    weak var router: AddPaymentMethodRouting?
    weak var listener: AddPaymentMethodListener?
    
    private let dependency: AddPaymentMethodInteractorDependency
    
    private var cancellabels: Set<AnyCancellable>

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(
        presenter: AddPaymentMethodPresentable,
        dependency: AddPaymentMethodInteractorDependency
    ) {
        self.dependency = dependency
        self.cancellabels = .init()
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func didTapClose() {
        listener?.addPaymentMethodDidTapClose()
    }
    
    func didTapConfirm(with number: String, cvc: String, expiry: String) {
        let info = AddPaymentMethodInfo(number: number, cvc: cvc, expiration: expiry)
        dependency.cardOnFileRepository.addCard(info: info)
            .receive(on: DispatchQueue.main)
            .sink { _ in } receiveValue: { method in
            self.listener?.addPaymentMethodDidAddCard(paymentMethod: method)
        }
        .store(in: &cancellabels)

    }
}
