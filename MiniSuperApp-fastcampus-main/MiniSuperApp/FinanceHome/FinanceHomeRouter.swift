import ModernRIBs

protocol FinanceHomeInteractable: Interactable, SuperPayDashboardListener {
    var router: FinanceHomeRouting? { get set }
    var listener: FinanceHomeListener? { get set }
}

protocol FinanceHomeViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
    func addDashboard(_ view: ViewControllable)
}

final class FinanceHomeRouter: ViewableRouter<FinanceHomeInteractable, FinanceHomeViewControllable>, FinanceHomeRouting {

    private let superPayDashboardBuildable: SuperPayDashboardBuildable
    private var superPayRouting: Routing?

    // TODO: Constructor inject child builder protocols to allow building children.
     init(interactor: FinanceHomeInteractable, viewController: FinanceHomeViewControllable, superPayDashboardBuildable: SuperPayDashboardBuildable) {
        self.superPayDashboardBuildable = superPayDashboardBuildable
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachSuperPayDashboard() {
        if superPayRouting != nil {
            return
        }
        let router = superPayDashboardBuildable.build(withListener: interactor)
        let dashboard = router.viewControllable
        viewController.addDashboard(dashboard)
        
        self.superPayRouting = router
        attachChild(router)
    }
}
/**
 자식 리블렛을 붙일 때 2개 이상 붙이지 않도록 방어코드 작성한다.
 
 */
