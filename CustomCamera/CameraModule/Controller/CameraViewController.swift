//
//  CameraViewController.swift
//  CustomCamera
//
//  Created by Vlad on 13.09.24.
//

import UIKit
import AVFoundation

final class CameraViewController: UIViewController {
    
    //MARK: Private
    private lazy var contentView = CameraView(frame: view.bounds)
    private let cameraService: CameraServiceProtocol = CameraService()
    
    //MARK: Life cycle
    override func loadView() {
        super.loadView()
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkPermisions()
        setupPreviewLayer()
        setupTargets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraService.setupCaptureSession()
    }
    
    //MARK: Setup camera
    private func checkPermisions() {
        let cameraStatusAuth = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch cameraStatusAuth {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { auth in
                if !auth {
                    abort()
                }
            }
        case .restricted:
            abort()
        case .denied:
            abort()
        case .authorized:
            return
        default:
            fatalError()
        }
    }
    
    private func setupPreviewLayer() {
        let previewLayer = AVCaptureVideoPreviewLayer(session: cameraService.captureSession)
        previewLayer.frame = contentView.bounds
        previewLayer.videoGravity = .resizeAspectFill
        contentView.layer.insertSublayer(previewLayer, at: 0)
    }
    
    //MARK: Setup
    private func setupTargets() {
        setupCancelButtonTarget()
        setupTapGestureForSnapshotView()
        setupTapGestureForSwitchCameraImageView()
    }
    
    private func setupCancelButtonTarget() {
        contentView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    }
    
    private func setupTapGestureForSnapshotView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(snapshotViewTapped))
        contentView.snapshotView.addGestureRecognizer(tapGesture)
    }
    
    private func setupTapGestureForSwitchCameraImageView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(switchCameraImageViewTapped))
        contentView.switchCameraImageView.addGestureRecognizer(tapGesture)
    }
    
    private func addAnimationWhenClickingOnView(view: UIView) {
        UIView.animate(withDuration: 0.1, animations: {
            view.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                view.transform = .identity
            }
        }
    }
}

//MARK: OBJC
extension CameraViewController {
    @objc private func cancelButtonTapped() {
        cameraService.stopSession()
        dismiss(animated: true)
    }
    
    @objc private func snapshotViewTapped() {
        addAnimationWhenClickingOnView(view: contentView.snapshotView)
        
        let photoSettings = AVCapturePhotoSettings()
        photoSettings.flashMode = .off
        cameraService.output.capturePhoto(with: photoSettings, delegate: self)
    }
    
    @objc private func switchCameraImageViewTapped() {
        addAnimationWhenClickingOnView(view: contentView.switchCameraImageView)
        cameraService.switchCamera()
    }
}

extension CameraViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: (any Error)?) {
        guard error == nil else {
            print(error!.localizedDescription)
            return
        }
        
        guard let imageData = photo.fileDataRepresentation() else { return }
        print(imageData)
        
    }
}
