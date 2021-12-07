//
//  File.swift
//  
//
//  Created by Bradley.yoon on 2021/12/07.
//

import UIKit
import FinanceEntity


//인터렉터와
struct PaymentMethodViewModel {
    let name: String
    let digits: String
    let color: UIColor
    
    init(_ paymenMethod: PaymentMethod) {
        name = paymenMethod.name
        digits = "**** \(paymenMethod.digits)"
        color = UIColor(hex: paymenMethod.color) ?? .systemGray2
    }
}
