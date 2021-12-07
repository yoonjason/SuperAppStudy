//
//  AdaptivePresentationControllerDelegate.swift
//  MiniSuperApp
//
//  Created by Bradley.yoon on 2021/11/14.
//

import UIKit

//delegate weak로 해줘야 해서 anyobject
public protocol AdaptivePresentationControllerDelegate: AnyObject {
    func presentationControllerDismiss()
}

public final class AdaptivePresentationControllerDelegateProxy: NSObject, UIAdaptivePresentationControllerDelegate {
    public weak var delegate: AdaptivePresentationControllerDelegate?
    
    public func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        delegate?.presentationControllerDismiss()
    }
}
