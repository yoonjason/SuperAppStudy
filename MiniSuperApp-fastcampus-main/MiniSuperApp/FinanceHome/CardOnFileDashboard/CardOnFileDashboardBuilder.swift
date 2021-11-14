//
//  CardOnFileDashboardBuilder.swift
//  MiniSuperApp
//
//  Created by Bradley.yoon on 2021/11/14.
//

import ModernRIBs

protocol CardOnFileDashboardDependency: Dependency {
    var cardOnFileRepository: CardOnFileRepository { get }
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class CardOnFileDashboardComponent: Component<CardOnFileDashboardDependency>, CardOnFileDashboardInteractorDependency {
    var cardOnFileRepository: CardOnFileRepository { dependency.cardOnFileRepository }
}

// MARK: - Builder

protocol CardOnFileDashboardBuildable: Buildable {
    func build(withListener listener: CardOnFileDashboardListener) -> CardOnFileDashboardRouting
}

final class CardOnFileDashboardBuilder: Builder<CardOnFileDashboardDependency>, CardOnFileDashboardBuildable {

    override init(dependency: CardOnFileDashboardDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: CardOnFileDashboardListener) -> CardOnFileDashboardRouting {
        let component = CardOnFileDashboardComponent(dependency: dependency)
        let viewController = CardOnFileDashboardViewController()
        let interactor = CardOnFileDashboardInteractor(
            presenter: viewController,
            dependency: component
        )
        interactor.listener = listener
        return CardOnFileDashboardRouter(interactor: interactor, viewController: viewController)
    }
}
