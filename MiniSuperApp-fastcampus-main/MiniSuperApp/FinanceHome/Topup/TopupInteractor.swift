//
//  TopupInteractor.swift
//  MiniSuperApp
//
//  Created by Bradley.yoon on 2021/11/14.
//

import ModernRIBs

protocol TopupRouting: Routing {
    func cleanupViews()
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
    func attachAddPaymentMethod()
    func detachAddPaymentMethod()
    func attachEnterAmount()
    func detachEnterAmount()
    func attachCardOnFile(paymentMethods: [PaymentMethod])
    func detachCardOnFile()
}

protocol TopupListener: AnyObject {
    func topupDidClose()
    func topupDidFinish()
}

protocol TopupInteractorDependency {
    var cardOnFileRepository: CardOnFileRepository { get }
    var paymentMethodStream: CurrentValuePublisher<PaymentMethod> { get }
}

final class TopupInteractor: Interactor, TopupInteractable, AdaptivePresentationControllerDelegate, AddPaymentMethodListener {

    let presentationDelegateProxy: AdaptivePresentationControllerDelegateProxy

    private var paymentMethods: [PaymentMethod] {
        dependency.cardOnFileRepository.cardOnFile.value
    }

    weak var router: TopupRouting?
    weak var listener: TopupListener?

    private let dependency: TopupInteractorDependency

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(
        dependency: TopupInteractorDependency
    ) {
        self.dependency = dependency
        self.presentationDelegateProxy = AdaptivePresentationControllerDelegateProxy()
        super.init()
        self.presentationDelegateProxy.delegate = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        if let card = dependency.cardOnFileRepository.cardOnFile.value.first {
            dependency.paymentMethodStream.send(card)
            router?.attachEnterAmount()
        } else {
            router?.attachAddPaymentMethod()
        }

    }

    override func willResignActive() {
        super.willResignActive()

        router?.cleanupViews()
        // TODO: Pause any business logic.
    }

    func addPaymentMethodDidTapClose() {
        router?.detachAddPaymentMethod()
        listener?.topupDidClose()
    }

    func addPaymentMethodDidAddCard(paymentMethod: PaymentMethod) {

    }

    func presentationControllerDismiss() {
        listener?.topupDidClose()
    }

    func enterAmountDidTapClose() {
        router?.detachEnterAmount()
        listener?.topupDidClose()
    }

    func enterAmountDidTapPaymentMethod() {
        router?.attachCardOnFile(paymentMethods: paymentMethods)
    }
    
    func enterAmountDidFinishTopup() {
        listener?.topupDidFinish()
    }

    func cardOnFileDidTapClose() {
        router?.detachCardOnFile()
    }
    
    func cardOnFileDidTapAddCard() {
        //attach add card
    }
    
    func cardOnFileDidSelect(at index: Int) {
        if let selected = paymentMethods[safe: index] {
            dependency.paymentMethodStream.send(selected)
        }
        router?.detachCardOnFile()
    }

}
