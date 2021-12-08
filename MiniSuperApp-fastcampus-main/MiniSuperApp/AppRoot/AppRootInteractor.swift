import Foundation
import ModernRIBs

protocol AppRootRouting: ViewableRouting {
  func attachTabs()
}

protocol AppRootPresentable: Presentable {
  var listener: AppRootPresentableListener? { get set }
  // TODO: Declare methods the interactor can invoke the presenter to present data.
}

public protocol AppRootListener: AnyObject {
  // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class AppRootInteractor: PresentableInteractor<AppRootPresentable>, AppRootInteractable, AppRootPresentableListener, URLHandler {
  
  weak var router: AppRootRouting?
  weak var listener: AppRootListener?
  
  // TODO: Add additional dependencies to constructor. Do not perform any logic
  // in constructor.
  override init(presenter: AppRootPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  override func didBecomeActive() {
    super.didBecomeActive()
    
    router?.attachTabs() //viewdidload와 비슷한 역할, 부모에게 attach되서 활성화될 때 호출
  }
  
  override func willResignActive() {
    super.willResignActive()
    // TODO: Pause any business logic.
  }
  
  func handle(_ url: URL) {
    
  }
}
