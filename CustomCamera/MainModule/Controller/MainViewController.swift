//
//  MainViewController.swift
//  CustomCamera
//
//  Created by Vlad on 13.09.24.
//

import UIKit

final class MainViewController: UIViewController {
    
    //MARK: Private
    private let contentView = MainView()
    
    //MARK: Life cycle
    override func loadView() {
        super.loadView()
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTargetCameraButton()
    }
    
    //MARK: Setup
    private func setupTargetCameraButton() {
        contentView.cameraButton.addTarget(self, action: #selector(cameraButtonTapped), for: .touchUpInside)
    }
}

//MARK: OBJC
extension MainViewController {
    @objc private func cameraButtonTapped() {
        let cameraViewController = CameraViewController()
        cameraViewController.modalPresentationStyle = .fullScreen
        present(cameraViewController, animated: true)
    }
}
