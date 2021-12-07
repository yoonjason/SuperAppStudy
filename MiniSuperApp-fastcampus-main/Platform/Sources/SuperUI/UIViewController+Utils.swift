//
//  UIViewController+Utils.swift
//  MiniSuperApp
//
//  Created by Bradley.yoon on 2021/11/15.
//

import UIKit
import RIBsUtil

public extension UIViewController {

//    navi
    func setupNavigationItem(with buttonType:DismissButtonType, target: Any?, action: Selector?) {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: buttonType.iconSystemName,
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold)),
            style: .plain,
            target: target,
            action: action)
    }
}


