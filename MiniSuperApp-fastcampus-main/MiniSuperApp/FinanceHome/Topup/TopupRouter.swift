//
//  TopupRouter.swift
//  MiniSuperApp
//
//  Created by Bradley.yoon on 2021/11/14.
//

import ModernRIBs

protocol TopupInteractable: Interactable, AddPaymentMethodListener, EnterAmountListener, CardOnFileListener {
    var router: TopupRouting? { get set }
    var listener: TopupListener? { get set }
    var presentationDelegateProxy: AdaptivePresentationControllerDelegateProxy { get }
}

protocol TopupViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy. Since
    // this RIB does not own its own view, this protocol is conformed to by one of this
    // RIB's ancestor RIBs' view.
}

final class TopupRouter: Router<TopupInteractable>, TopupRouting {


    private var navigationControllerable: NavigationControllerable?
    
    private let addPaymentMethodBuildable: AddPaymentMethodBuildable
    private var addPaymentMethodRouting: Routing?
    
    private let enterAmountBuildable: EnterAmountBuildable
    private var enterAmountRouting: Routing?
    
    private let cardOnFileBuildable: CardOnFileBuildable
    private var cardOnFileRouting: Routing?
    
    init(
        interactor: TopupInteractable,
        viewController: ViewControllable,
        addPaymeentMethodBuildable: AddPaymentMethodBuildable,
        enterAmountBuildable: EnterAmountBuildable,
        cardOnFileBuildable: CardOnFileBuildable
    ) {
        self.viewController = viewController
        self.addPaymentMethodBuildable = addPaymeentMethodBuildable
        self.enterAmountBuildable = enterAmountBuildable
        self.cardOnFileBuildable = cardOnFileBuildable
        super.init(interactor: interactor)
        interactor.router = self
        
    }

    func cleanupViews() {
        if viewController.uiviewController.presentedViewController != nil, navigationControllerable != nil {
            navigationControllerable?.dismiss(completion: nil)
        }
        // TODO: Since this router does not own its view, it needs to cleanup the views
        // it may have added to the view hierarchy, when its interactor is deactivated.
    }
    
    func attachAddPaymentMethod(closeButtonType: DismissButtonType) {
        if addPaymentMethodRouting != nil {
            return
        }
        let router = addPaymentMethodBuildable.build(withListener: interactor, closeButtonType: closeButtonType)
        if let navigation = navigationControllerable {
            navigation.pushViewController(router.viewControllable, animated: true)
        }else{
            presentInsideNavigation(router.viewControllable)
        }
        
        attachChild(router)
        addPaymentMethodRouting = router
    }
    
    func detachAddPaymentMethod() {
        guard let router = addPaymentMethodRouting else {
            return
        }
//        dismissPresentedNavigation(completion: nil)
        navigationControllerable?.popViewController(animated: true)
        detachChild(router)
        addPaymentMethodRouting = nil
    }
    
    func attachEnterAmount() {
        if enterAmountRouting != nil {
            return
        }
        let router = enterAmountBuildable.build(withListener: interactor)
        if let navigation = navigationControllerable {
            navigation.setViewControllers([router.viewControllable])
            resetChildRouting()
        } else {
            presentInsideNavigation(router.viewControllable)
            attachChild(router)
        }
        enterAmountRouting = router
    }
    
    func detachEnterAmount() {
        guard let router = enterAmountRouting else {
            return
        }
        
        dismissPresentedNavigation(completion: nil)
        detachChild(router)
        enterAmountRouting = nil
    }
    
    func popToRoot() {
        navigationControllerable?.popToRoot(animated: true)
        resetChildRouting()
    }
    
    private func presentInsideNavigation(_ viewControllerable: ViewControllable) {
        let navigation = NavigationControllerable(root: viewControllerable)//Topup라우터가 푸시와 팝을 할 때 필요하다.
        navigation.navigationController.presentationController?.delegate = interactor.presentationDelegateProxy
        self.navigationControllerable = navigation
        viewController.present(navigation, animated: true, completion: nil)
    }
    
    private func dismissPresentedNavigation(completion: (() -> Void)?) {
        if self.navigationControllerable == nil {
            return
        }
        viewController.dismiss(completion: nil)
        self.navigationControllerable = nil
    }
    
    func attachCardOnFile(paymentMethods: [PaymentMethod]) {
        if cardOnFileRouting != nil {
            return
        }
        let router = cardOnFileBuildable.build(withListener: interactor, paymentMethods: paymentMethods)
        navigationControllerable?.pushViewController(router.viewControllable, animated: true)
        cardOnFileRouting = router
        attachChild(router)
    }
    
    func detachCardOnFile() {
        guard let router = cardOnFileRouting else {
            return
        }
        navigationControllerable?.popToRoot(animated: true)
        detachChild(router)
        cardOnFileRouting = nil
    }
    
    private func resetChildRouting(){
        if let cardOnFileRouting = cardOnFileRouting {
            detachChild(cardOnFileRouting)
            self.cardOnFileRouting = nil
        }else if let addPaymentMethodRouting = addPaymentMethodRouting{
            detachChild(addPaymentMethodRouting)
            self.addPaymentMethodRouting = nil
        }
    }
    
    // MARK: - Private

    private let viewController: ViewControllable //부모가 건내준
}

