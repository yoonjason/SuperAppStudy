//
//  AddPaymentMethodButton.swift
//  MiniSuperApp
//
//  Created by Bradley.yoon on 2021/11/14.
//

import UIKit

final class AddPaymentMethodButton: UIControl {
    private let plustIcon: UIImageView = {
        let imageView = UIImageView(
            image: UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24, weight: .semibold))
        )
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    init(){
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(plustIcon)
        
        NSLayoutConstraint.activate([
            plustIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            plustIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
