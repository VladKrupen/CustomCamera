//
//  MainView.swift
//  CustomCamera
//
//  Created by Vlad on 13.09.24.
//

import UIKit

final class MainView: UIView {
    
    //MARK: UI
    let cameraButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(systemName: "camera"), for: .normal)
        return $0
    }(UIButton(type: .system))
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layoutCameraButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Layout
    private func layoutCameraButton() {
        addSubview(cameraButton)
        
        NSLayoutConstraint.activate([
            cameraButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            cameraButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -30),
        ])
    }
}
