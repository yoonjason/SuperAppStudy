//
//  TopupBuilder.swift
//  MiniSuperApp
//
//  Created by Bradley.yoon on 2021/11/14.
//

import ModernRIBs
import FinanceRepository
import CombineUtil
import FinanceEntity
import AddPaymentMethod
import SuperUI

/**
 Topup리블렛이 동작하기 위해 필요한 것들을 선언해두는 곳이다.
 Topup리블렛은 부모 리블렛이 뷰컨트롤러를 하나 지정해줘야한다.
 뷰 컨틀로러는 라우터한테 넘겨줘서 라우터에서 이 뷰 컨트롤러를 접근할 수 있다.
 이 뷰컨은 탑업 리블렛이 소유한게 아니고 띄운 부모리블렛이 소요할 수 있다.
 */
public protocol TopupDependency: Dependency  {
    var topupBaseViewController: ViewControllable { get }
    var cardOnFileRepository: CardOnFileRepository { get }
    var superPayRepository: SuperPayRepository { get }
}

final class TopupComponent: Component<TopupDependency>, TopupInteractorDependency, AddPaymentMethodDependency, EnterAmountDependency, CardOnFileDependency {
    var superPayRepository: SuperPayRepository { dependency.superPayRepository }
    
    var selectedPaymentMethod: ReadOnlyCurrentValuePublisher<PaymentMethod> { paymentMethodStream }
    
    var paymentMethodStream: CurrentValuePublisher<PaymentMethod>
    
    var cardOnFileRepository: CardOnFileRepository { dependency.cardOnFileRepository }
    
    fileprivate var TopupViewController: ViewControllable {
        return dependency.topupBaseViewController
    }
    
    init(
        dependency: TopupDependency,
        paymentMethodStream: CurrentValuePublisher<PaymentMethod>
    ){
        self.paymentMethodStream = paymentMethodStream
        super.init(dependency: dependency)
    }

}

// MARK: - Builder

public protocol TopupBuildable: Buildable {
    func build(withListener listener: TopupListener) -> Routing
}

public final class TopupBuilder: Builder<TopupDependency>, TopupBuildable {

    public override init(dependency: TopupDependency) {
        super.init(dependency: dependency)
    }

    public func build(withListener listener: TopupListener) -> Routing {
        let paymentMethodStream = CurrentValuePublisher(PaymentMethod(id: "", name: "", digits: "", color: "", isPrimary: false))
        
        let component = TopupComponent(dependency: dependency, paymentMethodStream: paymentMethodStream)
        let interactor = TopupInteractor(dependency: component)
        let addPaymentMethodBuilder = AddPaymentMethodBuilder(dependency: component)
        let enterAmountBuilder = EnterAmountBuilder(dependency: component)
        let cardOnFileBuilder = CardOnFileBuilder(dependency: component)
        interactor.listener = listener
        return TopupRouter(
            interactor: interactor,
            viewController: component.TopupViewController,
            addPaymeentMethodBuildable: addPaymentMethodBuilder,
            enterAmountBuildable: enterAmountBuilder,
            cardOnFileBuildable: cardOnFileBuilder
        )
    }
}
