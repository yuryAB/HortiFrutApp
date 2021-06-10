//
//  CameraViewController.swift
//  hortifruti
//
//  Created by yury antony on 23/05/21.
//

import UIKit
import AVFoundation
import Vision

public enum SearchType {
    case general
    case espec
}

class CameraViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    let informationIdentifierView = UIView()
    let nameLabel = UILabel()
    let identifierViewButton = UIButton()
    var infoFlag = false
    var neededUnit = Unit(image: UIImage(named: "alface")!, name: "none", type: .fruit)
    var searchType:SearchType = .general
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCaptureSession()
        identifierViewButton.addTarget(self, action: #selector(idenButtonAction), for: .touchUpInside)
        style()
        setupAutoLayout()
        informationIdentifierView.alpha = 0
        navigationControllerSets()
    }
    
    func setupCaptureSession() {
        let captureSession = AVCaptureSession()
        
        // search for available capture devices
        let availableDevices = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back).devices
        
        // setup capture device, add input to our capture session
        do {
            if let captureDevice = availableDevices.first {
                let captureDeviceInput = try AVCaptureDeviceInput(device: captureDevice)
                captureSession.addInput(captureDeviceInput)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        // setup output, add output to our capture session
        let captureOutput = AVCaptureVideoDataOutput()
        captureOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(captureOutput)
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.frame
        view.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
    }
    
    // called everytime a frame is captured
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        if !self.infoFlag {
            let config = MLModelConfiguration()
            
            guard let model = try? VNCoreMLModel(for: ClassificationUnits(configuration: config).model) else {return}
            
            let request = VNCoreMLRequest(model: model) { (finishedRequest, error) in
                
                guard let results = finishedRequest.results as? [VNClassificationObservation] else { return }
                guard let Observation = results.first else { return }
                //print("Aqui: ",Observation.confidence)
                switch self.searchType {
                case .general:
                    if Observation.identifier != "none" {
                        if Observation.confidence > 0.7 {
                            DispatchQueue.main.async {
                                self.nameLabel.text = "\(Observation.identifier)"
                                self.showResult()
                            }
                        }
                    }
                case .espec:
                    if Observation.identifier != "none" {
                        print(Observation.identifier)
                        DispatchQueue.main.async {
                            if Observation.identifier == self.neededUnit.unitName {
                                self.nameLabel.text = "É \(self.neededUnit.unitName)"
                                self.showResult()
                            } else {
                                self.nameLabel.text = "Não é \(self.neededUnit.unitName)"
                                self.showResult()
                            }
                        }
                    }
                }
                
                
            }
            guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
            
            // executes request
            try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
        }
    }
    
    func showResult(){
        self.informationIdentifierApears()
    }
    
    func navigationControllerSets() {
        navigationController?.navigationBar.tintColor = UIColor(named: "unitsBodyBackground")
        navigationController?.navigationBar.barTintColor = UIColor.clear
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func style() {
        nameLabel.textColor = UIColor(named: "hortiidenViewLabel")
        nameLabel.textAlignment = .center
        
        identifierViewButton.backgroundColor = UIColor(named: "hortiYellow")
        identifierViewButton.setTitle("Ok", for: .normal)
        identifierViewButton.setTitleColor(UIColor(named: "hortiIdenButtonLabelColor"), for: .normal)
        identifierViewButton.layer.cornerRadius = 20
        identifierViewButton.clipsToBounds = true
        
        informationIdentifierView.backgroundColor = UIColor(named: "unitsBodyBackground")
        informationIdentifierView.layer.cornerRadius = 20
        informationIdentifierView.clipsToBounds = true
        
        informationIdentifierView.addSubview(nameLabel)
        informationIdentifierView.addSubview(identifierViewButton)
        view.addSubview(informationIdentifierView)
    }
    
    func setupAutoLayout() {
        let extremity:CGFloat = 10
        
        //Constraints
        informationIdentifierView.translatesAutoresizingMaskIntoConstraints = false
        informationIdentifierView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 190).isActive = true
        informationIdentifierView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: extremity).isActive = true
        informationIdentifierView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -extremity).isActive = true
        informationIdentifierView.heightAnchor.constraint(equalToConstant: 190).isActive = true
        
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        let viewReference = informationIdentifierView
        nameLabel.topAnchor.constraint(equalTo: viewReference.topAnchor, constant: 30).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: viewReference.centerXAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: viewReference.leftAnchor, constant: 0).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: viewReference.rightAnchor, constant: 0).isActive = true
        
        identifierViewButton.translatesAutoresizingMaskIntoConstraints = false
        identifierViewButton.centerXAnchor.constraint(equalTo: viewReference.centerXAnchor).isActive = true
        identifierViewButton.bottomAnchor.constraint(equalTo: viewReference.bottomAnchor, constant: -40).isActive = true
        identifierViewButton.leftAnchor.constraint(equalTo: viewReference.leftAnchor, constant: 90).isActive = true
        identifierViewButton.rightAnchor.constraint(equalTo: viewReference.rightAnchor, constant: -90).isActive = true
        identifierViewButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}

extension CameraViewController {
    func informationIdentifierApears(){
        self.infoFlag = true
        informationIdentifierView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        UIView.animate(withDuration: 0.6) {
            self.informationIdentifierView.alpha = 1.0
            self.view.layoutIfNeeded()
        }
    }
    
    func informationIdentifierDesapears(){
        self.infoFlag = false
        informationIdentifierView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 190).isActive = true
        UIView.animate(withDuration: 0.6) {
            self.informationIdentifierView.alpha = 0.0
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func idenButtonAction() {
        DispatchQueue.main.async {
            self.informationIdentifierDesapears()
        }
    }
}


