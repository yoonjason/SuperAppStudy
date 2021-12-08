//
//  TopupInteractor.swift
//  MiniSuperApp
//
//  Created by Bradley.yoon on 2021/11/14.
//

import ModernRIBs
import AddPaymentMethod
import RIBsUtil
import FinanceRepository
import FinanceEntity
import CombineUtil
import SuperUI

protocol TopupRouting: Routing {
    func cleanupViews()
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
    func attachAddPaymentMethod(closeButtonType: DismissButtonType)
    func detachAddPaymentMethod()
    func attachEnterAmount()
    func detachEnterAmount()
    func attachCardOnFile(paymentMethods: [PaymentMethod])
    func detachCardOnFile()
    func popToRoot()
}



protocol TopupInteractorDependency {
    var cardOnFileRepository: CardOnFileRepository { get }
    var paymentMethodStream: CurrentValuePublisher<PaymentMethod> { get }
}

final class TopupInteractor: Interactor, TopupInteractable, AdaptivePresentationControllerDelegate, AddPaymentMethodListener {

    let presentationDelegateProxy: AdaptivePresentationControllerDelegateProxy

    private var isEnterAmountBool: Bool = false

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
            isEnterAmountBool = true
            dependency.paymentMethodStream.send(card)
            router?.attachEnterAmount()
        } else {
            isEnterAmountBool = false
            router?.attachAddPaymentMethod(closeButtonType: .close)
        }

    }

    override func willResignActive() {
        super.willResignActive()

        router?.cleanupViews()
        // TODO: Pause any business logic.
    }

    func addPaymentMethodDidTapClose() {
        router?.detachAddPaymentMethod()
        if !isEnterAmountBool {
            listener?.topupDidClose()
        }
    }

    func addPaymentMethodDidAddCard(paymentMethod: PaymentMethod) {
        dependency.paymentMethodStream.send(paymentMethod)
        
        if isEnterAmountBool {
            router?.popToRoot()
        } else {
            isEnterAmountBool = true
            router?.attachEnterAmount()
        }
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
        router?.attachAddPaymentMethod(closeButtonType: .back)
    }

    func cardOnFileDidSelect(at index: Int) {
        if let selected = paymentMethods[safe: index] {
            dependency.paymentMethodStream.send(selected)
        }
        router?.detachCardOnFile()
    }

}
