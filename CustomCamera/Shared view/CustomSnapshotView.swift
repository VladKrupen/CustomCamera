//
//  CustomSnapshotView.swift
//  CustomCamera
//
//  Created by Vlad on 13.09.24.
//

import UIKit

final class CustomSnapshotView: UIView {
    
    var diameter: CGFloat = 70
    
    private let circleFillImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(systemName: "circle.fill")
        return $0
    }(UIImageView())
    
    private let circleImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(systemName: "circle")
        return $0
    }(UIImageView())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTintColor(color: UIColor) {
        circleFillImageView.tintColor = color
        circleImageView.tintColor = color
    }
    
    private func layout() {
        addSubview(circleFillImageView)
        addSubview(circleImageView)
        
        NSLayoutConstraint.activate([
            circleImageView.widthAnchor.constraint(equalToConstant: diameter),
            circleImageView.heightAnchor.constraint(equalToConstant: diameter),
            
            circleImageView.topAnchor.constraint(equalTo: topAnchor),
            circleImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            circleImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            circleImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            circleFillImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            circleFillImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            circleFillImageView.widthAnchor.constraint(equalToConstant: diameter - 20),
            circleFillImageView.heightAnchor.constraint(equalToConstant: diameter - 20),
        ])
    }
}
