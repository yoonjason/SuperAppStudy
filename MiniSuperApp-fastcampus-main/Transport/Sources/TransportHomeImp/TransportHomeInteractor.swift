import ModernRIBs
import Combine
import Foundation
import CombineUtil
import TransportHome
//import FinanceHome

protocol TransportHomeRouting: ViewableRouting {
    func attachTopup()
    func detachTopup()
}

protocol TransportHomePresentable: Presentable {
    var listener: TransportHomePresentableListener? { get set }
    func setSuperPayBalance(_ blance: String)

}



protocol TransportHomeInteractorDependency {
    var superPayBlance: ReadOnlyCurrentValuePublisher<Double> { get }
}

final class TransportHomeInteractor: PresentableInteractor<TransportHomePresentable>, TransportHomeInteractable, TransportHomePresentableListener {


    weak var router: TransportHomeRouting?
    weak var listener: TransportHomeListener?
    
    private let ridePrice: Double = 18000

    private let dependency: TransportHomeInteractorDependency

    private var cancellables: Set<AnyCancellable>
    

    init(
        presenter: TransportHomePresentable,
        dependency: TransportHomeInteractorDependency
    ) {
        self.dependency = dependency
        self.cancellables = .init()
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        dependency.superPayBlance
            .receive(on: DispatchQueue.main)
            .sink { [weak self] balance in
            if let balanceText = Formatter.blanceFormatter.string(from: NSNumber(value: balance)) {
                self?.presenter.setSuperPayBalance(balanceText)
            }

        }
            .store(in: &cancellables)
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }

    func didTapBack() {
        listener?.transportHomeDidTapClose()
    }
    
    func didTapRideConfirmButton() {
        if dependency.superPayBlance.value < ridePrice {
            //어태치 팝업
            router?.attachTopup()
        }else {
            //success
        }
    }
    
    func topupDidClose() {
        router?.detachTopup()
    }
    
    func topupDidFinish() {
        router?.detachTopup()
    }
    
}
