//
//  ButtonContainerView.swift
//  
//
//  Created by Alberto P. Gerteksa on 15/9/22.
//

import UIKit
import SnapKit

class ButtonContainerView: UIView {
    
    var nextButtonDidTap: (() -> Void)?
    var getStartedButtonDidTap: (() -> Void)?

    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.layer.borderColor = viewTintColor.cgColor
        button.layer.borderWidth = 2
        button.setTitleColor(viewTintColor, for: .normal)
        button.titleLabel?.font = UIFont(name:"ArialRoundedMTBold", size: 16)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
        return button
    }()
    
    
    private lazy var getStartedButton: UIButton = {
        let button = UIButton()
        button.setTitle("Get Started", for: .normal)
        button.backgroundColor = viewTintColor
        button.layer.shadowColor = viewTintColor.cgColor
        button.layer.opacity = 0.5
        button.layer.shadowOffset = .init(width:4, height:4)
        button.layer.shadowRadius = 8
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name:"ArialRoundedMTBold", size: 16)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(getStartedTapped), for: .touchUpInside)
        return button
    }()
    
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nextButton, getStartedButton])
        stack.axis = .horizontal
        stack.spacing = 24
        return stack
    }()
    
    private let viewTintColor: UIColor
    init(tintColor: UIColor) {
        self.viewTintColor = tintColor
        super.init(frame: .zero)
        layout()
    }
    
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func layout() {
        backgroundColor = .white
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(self).inset(UIEdgeInsets(top: 24, left: 24, bottom: 36, right: 24))
        }
        
        nextButton.snp.makeConstraints { make in
            make.width.equalTo(getStartedButton.snp.width).multipliedBy(0.5)
       
        }
    }
    
    @objc private func nextTapped() {
        nextButtonDidTap?()
    }
    
    @objc private func getStartedTapped() {
        getStartedButtonDidTap?()
    }
}
