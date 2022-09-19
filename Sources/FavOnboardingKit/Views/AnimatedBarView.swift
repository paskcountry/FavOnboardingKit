//
//  AnimatedBarView.swift
//  
//
//  Created by Alberto P. Gerteksa on 16/9/22.
//

import UIKit
import Combine


class AnimatedBarView: UIView {
    
    enum State {
        case clear
        case animating
        case filled
    }
    
    @Published private var state: State = .clear
    private var subsCribers = Set<AnyCancellable>()
    private var animator: UIViewPropertyAnimator!
    private let barColor: UIColor
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private lazy var backgroundBarView: UIView = {
        let view = UIView()
        view.backgroundColor = barColor.withAlphaComponent(0.2)
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var foregroundBarView: UIView = {
        let view = UIView()
        view.backgroundColor = barColor
        view.alpha = 0.0
        return view
    }()
    
   
    
    init(barColor: UIColor) {
        self.barColor = barColor
        super.init(frame: .zero)
        setupAnimator()
        layout()
        observe()
    }
    
    
    
    func startAnimating() {
        state = .animating
    }
    
    func complete() {
        state = .filled
    }
    
    func reset() {
        state = .clear
    }
    
    
    private func setupAnimator() {
        self.animator = UIViewPropertyAnimator(duration: 3.0, curve: .easeInOut, animations: {
            self.foregroundBarView.transform = .identity
        })
    }
    
    private func observe() {
        $state.sink { [unowned self] state in
            switch state {
            case .clear:
                setupAnimator()
                foregroundBarView.alpha = 0.0
                animator.stopAnimation(false)
            case .animating:
                foregroundBarView.transform = .init(scaleX: 0, y:1.0)
                foregroundBarView.transform = .init(translationX: -frame.size.width, y:0)
                foregroundBarView.alpha = 1.0
                animator.startAnimation()
            case .filled:
                animator.stopAnimation(true)
                foregroundBarView.transform = .identity
                
            }
            
            
        }.store(in: &subsCribers)
    }
    
    private func layout() {
        addSubview(backgroundBarView)
        backgroundBarView.addSubview(foregroundBarView)
        
        backgroundBarView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        foregroundBarView.snp.makeConstraints { make in
            make.edges.equalTo(backgroundBarView)
        }
    }
    
}
