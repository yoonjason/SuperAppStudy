import ModernRIBs

/**
 부모로부터 받는다.
 */
protocol FinanceHomeDependency: Dependency {
    var cardOnFileRepository: CardOnFileRepository { get }
    var superPayRepository: SuperPayRepository { get }
}

final class FinanceHomeComponent: Component<FinanceHomeDependency>, SuperPayDashboardDependency, CardOnFileDashboardDependency, AddPaymentMethodDependency, TopupDependency {

    var cardOnFileRepository: CardOnFileRepository { dependency.cardOnFileRepository }
    var superPayRepository: SuperPayRepository { dependency.superPayRepository }
    var balance: ReadOnlyCurrentValuePublisher<Double> { superPayRepository.balance }
    var topupBaseViewController: ViewControllable
    //파이낸스홈 리블렛이 가지고 있는 파이낸스홈 뷰컨트롤러가 되면 된다.

    init(
        dependency: FinanceHomeDependency,
        topupBaseViewController: ViewControllable
    ) {
        self.topupBaseViewController = topupBaseViewController
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol FinanceHomeBuildable: Buildable {
    func build(withListener listener: FinanceHomeListener) -> FinanceHomeRouting
}

final class FinanceHomeBuilder: Builder<FinanceHomeDependency>, FinanceHomeBuildable {

    override init(dependency: FinanceHomeDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: FinanceHomeListener) -> FinanceHomeRouting {

        let viewController = FinanceHomeViewController()

        let component = FinanceHomeComponent(
            dependency: dependency,
            topupBaseViewController: viewController
        )

        let interactor = FinanceHomeInteractor(presenter: viewController)
        interactor.listener = listener

        let superPayDashboradBuilder = SuperPayDashboardBuilder(dependency: component)
        let cardFileOnDashboardBuilder = CardOnFileDashboardBuilder(dependency: component)
        let addPaymentMethodBuilder = AddPaymentMethodBuilder(dependency: component)
        let topupBuilder = TopupBuilder(dependency: component)

        return FinanceHomeRouter(
            interactor: interactor,
            viewController: viewController,
            superPayDashboardBuildable: superPayDashboradBuilder,
            cardOnFileDashboardBuildable: cardFileOnDashboardBuilder,
            addPaymentMethodBuildable: addPaymentMethodBuilder,
            topupBuildable: topupBuilder
        )
    }
}

//리블렛의 컴포넌트는 리블렛이 필요한 객체들을 담는 바구니라고 한다.
//자식 리블렛이 필요한 것들도 담는 바구니이다.
//자식들의 디펜던시를 부모 컴포넌트가 컨펌하도록 한다.


