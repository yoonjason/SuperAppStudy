//
//  AppRootComponent.swift
//  MiniSuperApp
//
//  Created by Bradley.yoon on 2021/12/08.
//

import Foundation
import AppHome
import FinanceHome
import ProfileHome
import FinanceRepository
import ModernRIBs
import TransportHome
import TransportHomeImp


final class AppRootComponent: Component<AppRootDependency>, AppHomeDependency, FinanceHomeDependency, ProfileHomeDependency, TransportHomeDependency {
    
    
    var cardOnFileRepository: CardOnFileRepository
    var superPayRepository: SuperPayRepository
    
    lazy var transportHomeBuildable: TransportHomeBuildable = {
        return TransportHomeBuilder(dependency: self)
    }()

    init(
        dependency: AppRootDependency,
        cardOnFileRepository: CardOnFileRepository,
        superPayRepository: SuperPayRepository
    ) {
        self.superPayRepository = superPayRepository
        self.cardOnFileRepository = cardOnFileRepository
        super.init(dependency: dependency)
    }
}
