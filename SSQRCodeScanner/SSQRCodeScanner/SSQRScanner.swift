//
//  SSQRScanner.swift
//
//  Created by Susim Samanta on 16/02/16.
//  Copyright (c) 2015 Susim Samanta. All rights reserved.
//

import UIKit
import AVFoundation

public typealias SSQRScannerHandler = (_ obj : AnyObject? , _ error : NSError?) -> Void
open class SSQRScanner: NSObject,AVCaptureMetadataOutputObjectsDelegate {
    
    var captureSession:AVCaptureSession?
    var scannerPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrScannerHandler: SSQRScannerHandler?
    
    open func createQRScannerOnCompletion(_ inView: UIView?, scannerHandler :@escaping SSQRScannerHandler) {
        
        self.qrScannerHandler = scannerHandler
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        var error:NSError?
        let input: AnyObject!
        do {
            input = try AVCaptureDeviceInput(device: captureDevice!)
        } catch let error1 as NSError {
            error = error1
            input = nil
        }
        if (error != nil) {
            self.qrScannerHandler!(nil, error)
        }
        captureSession = AVCaptureSession()
        captureSession?.addInput(input as! AVCaptureInput)
        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureSession?.addOutput(captureMetadataOutput)
        
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        captureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        
        scannerPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        scannerPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        scannerPreviewLayer?.frame = inView!.layer.bounds
        inView!.layer.addSublayer(scannerPreviewLayer!)
        
        captureSession?.startRunning()

    }
    open func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        
        if metadataObjects == nil || metadataObjects.count == 0 {
            self.qrScannerHandler!(nil, nil)
        }
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        if metadataObj.type == AVMetadataObjectTypeQRCode {
            _ = scannerPreviewLayer?.transformedMetadataObject(for: metadataObj as AVMetadataMachineReadableCodeObject) as! AVMetadataMachineReadableCodeObject
            self.qrScannerHandler!(metadataObj.stringValue as AnyObject?, nil)
        }
        captureSession?.stopRunning()
    }
}
