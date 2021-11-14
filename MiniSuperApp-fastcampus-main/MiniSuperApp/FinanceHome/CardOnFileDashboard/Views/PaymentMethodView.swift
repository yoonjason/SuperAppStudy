//
//  PaymentMethodView.swift
//  MiniSuperApp
//
//  Created by Bradley.yoon on 2021/11/14.
//

import UIKit

final class PaymentMethodView: UIView {

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .white
        label.text = "우리은행"
        return label
    }()

    private let subtitleLbael: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .white
        label.text = "**** 9999"
        return label
    }()
    
    init(viewModel: PaymentMethodViewModel) {
        super.init(frame: .zero)
        setupViews()
        
        nameLabel.text = viewModel.name
        subtitleLbael.text = viewModel.digits
        backgroundColor = viewModel.color
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews(){
        addSubview(nameLabel)
        addSubview(subtitleLbael)
        backgroundColor = .systemIndigo
        roundCorners()
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            subtitleLbael.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            subtitleLbael.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
