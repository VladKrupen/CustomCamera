//
//  CameraView.swift
//  CustomCamera
//
//  Created by Vlad on 13.09.24.
//

import UIKit

final class CameraView: UIView {
    
    //MARK: UI
    let cancelButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(systemName: "xmark"), for: .normal)
        $0.tintColor = .white
        return $0
    }(UIButton(type: .system))
    
    let snapshotView: CustomSnapshotView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTintColor(color: .white)
        $0.isUserInteractionEnabled = true
        return $0
    }(CustomSnapshotView())
    
    let switchCameraImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(systemName: "arrow.triangle.2.circlepath.camera")
        $0.tintColor = .white
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.isUserInteractionEnabled = true
        return $0
    }(UIImageView())
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        layoutElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Layout
    private func layoutElements() {
        layoutCancelButton()
        layoutSnapshotView()
        layoutSwitchCameraImageView()
    }
    
    private func layoutCancelButton() {
        addSubview(cancelButton)
        
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            cancelButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }
    
    private func layoutSnapshotView() {
        addSubview(snapshotView)
        
        NSLayoutConstraint.activate([
            snapshotView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            snapshotView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -30),
        ])
    }
    
    private func layoutSwitchCameraImageView() {
        addSubview(switchCameraImageView)
        
        NSLayoutConstraint.activate([
            switchCameraImageView.widthAnchor.constraint(equalToConstant: 30),
            switchCameraImageView.heightAnchor.constraint(equalToConstant: 30),
            
            switchCameraImageView.centerYAnchor.constraint(equalTo: snapshotView.centerYAnchor),
            switchCameraImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50)
        ])
    }
}
