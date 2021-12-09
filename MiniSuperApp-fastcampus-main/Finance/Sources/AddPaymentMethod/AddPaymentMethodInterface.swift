//
//  File.swift
//  
//
//  Created by Bradley.yoon on 2021/12/09.
//

import Foundation
import ModernRIBs
import FinanceEntity
import RIBsUtil

//인터페이스 클래스에는 빌더블, 리스너가 필요하다.
public protocol AddPaymentMethodBuildable: Buildable {
    func build(withListener listener: AddPaymentMethodListener, closeButtonType: DismissButtonType) -> ViewableRouting
}

public protocol AddPaymentMethodListener: AnyObject {
    //인터렉터는 자신을 띄웠던 부모 리스너에게 이벤트를 전달한다.
    func addPaymentMethodDidTapClose()
    func addPaymentMethodDidAddCard(paymentMethod: PaymentMethod)
}
