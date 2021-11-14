//
//  AdaptivePresentationControllerDelegate.swift
//  MiniSuperApp
//
//  Created by Bradley.yoon on 2021/11/14.
//

import UIKit

//delegate weak로 해줘야 해서 anyobject
protocol AdaptivePresentationControllerDelegate: AnyObject {
    func presentationControllerDismiss()
}

final class AdaptivePresentationControllerDelegateProxy: NSObject, UIAdaptivePresentationControllerDelegate {
    weak var delegate: AdaptivePresentationControllerDelegate?
    
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        delegate?.presentationControllerDismiss()
    }
}
