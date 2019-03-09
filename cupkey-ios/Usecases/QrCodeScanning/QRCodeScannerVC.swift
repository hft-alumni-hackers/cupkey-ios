import Foundation
import UIKit
import AVFoundation

protocol QRCodeScannerVCDelegate {
    func didScanQrCode(scannedContent: String)
    func bttCancelClicked()
}

class QRCodeScannerVC: UIViewController {

    let TAG = "QRCodeScannerVC"

    fileprivate unowned var rootView: QRCodeScannerVCView { return view as! QRCodeScannerVCView }

    var delegate: QRCodeScannerVCDelegate?

    var captureSession = AVCaptureSession()
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView: UIView?

    var hasQRCodeFound = false


    override func loadView() {
        self.view = QRCodeScannerVCView()
    }

    override func viewDidLoad() {
        print(TAG, "viewDidLoad()")
        self.setupSbbNavigationBar(
            title: "Scan QR Code",
            backButtonSelector: nil,
            rightButtonTitle: "Cancel",
            rightButtonSelector: #selector(self.bttCancelClicked)
        )

        self.setupCameraStream()
    }

    @objc func bttCancelClicked() {
        self.delegate?.bttCancelClicked()
    }

    private func setupCameraStream() {
        // Get the back-facing camera for capturing videos
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(
            deviceTypes: [.builtInWideAngleCamera],
            mediaType: AVMediaType.video,
            position: .back
        )

        guard let captureDevice = deviceDiscoverySession.devices.first else {
            print("Failed to get the camera device")
            return
        }

        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
            let input = try AVCaptureDeviceInput(device: captureDevice)

            // Set the input device on the capture session.
            captureSession.addInput(input)

            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
            let captureMetadataOutput = AVCaptureMetadataOutput()

            captureSession.addOutput(captureMetadataOutput)

            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        } catch {
            // If any error occurs, simply print it out and don't continue any more.
            print(error)
            return
        }

        // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer?.frame = UIScreen.main.bounds
        view.layer.addSublayer(videoPreviewLayer!)

        // Start video capture.
        captureSession.startRunning()

        // Initialize QR Code Frame to highlight the QR codes
        qrCodeFrameView = UIView()

        self.rootView.subviews.forEach {
            self.rootView.bringSubviewToFront($0)
        }

        if let qrCodeFrameView = qrCodeFrameView {
            qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
            qrCodeFrameView.layer.borderWidth = 2
            view.addSubview(qrCodeFrameView)
            view.bringSubviewToFront(qrCodeFrameView)
        }
    }
}

extension QRCodeScannerVC: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(
        _ output: AVCaptureMetadataOutput,
        didOutput metadataObjects: [AVMetadataObject],
        from connection: AVCaptureConnection
    ) {
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            return
        }

        // Get the metadata object (this contains the qr code data).
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject

        if metadataObj.type == AVMetadataObject.ObjectType.qr {
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            self.qrCodeFrameView?.frame = barCodeObject!.bounds

            if metadataObj.stringValue != nil {
                let qrCodeContent = metadataObj.stringValue
                if self.hasQRCodeFound {
                    return
                } else {
                    self.delegate?.didScanQrCode(scannedContent: qrCodeContent!)
                    self.hasQRCodeFound = true
                }
            }
        }
    }
}

