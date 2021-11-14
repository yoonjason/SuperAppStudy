//
//  PaymentMethodViewModel.swift
//  MiniSuperApp
//
//  Created by Bradley.yoon on 2021/11/14.
//

import UIKit

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


