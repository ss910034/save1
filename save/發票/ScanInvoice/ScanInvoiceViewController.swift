//
//  ScanProductViewController.swift
//  save
//
//  Created by Frank Liu on 2021/10/23.
//

import UIKit
import AVFoundation
import SwiftyJSON

class ScanInvoiceViewController: BaseViewController, QRScannerViewDelegate {
    
    @IBOutlet weak var btn1:UIButton!
    @IBOutlet weak var btn2:UIButton!
    
    @IBOutlet weak var btnPrice1:UIButton!
    @IBOutlet weak var btnPrice2:UIButton!

    @IBOutlet weak var scanArea: UIView!
    @IBOutlet weak var scanCapture: UIImageView!
    
    var scannerView:QRScannerView? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        gScan2 = 0
        NotificationCenter.default.addObserver(self, selector: #selector(scanInvoice), name: NSNotification.Name("ScanInvoice"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(stopScanInvoice), name: NSNotification.Name("StopInvoice"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(removeScanNot), name: NSNotification.Name("RemoveScanNot"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        btnPrice1.isHidden = true
        btnPrice2.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @objc func removeScanNot() {
        if gScan2 == 0 {
            NotificationCenter.default.removeObserver(self)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        gIsFromScan = 3
        self.stopScanInvoice()
    }
    
    @objc func scanInvoice() {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
            if self.scannerView != nil {
                self.scannerView?.removeFromSuperview()
            }
            self.scannerView = QRScannerView()
            self.scannerView?.delegate = self
            self.scannerView?.frame = self.scanArea.bounds
            self.scanArea.addSubview(self.scannerView!)
            self.scanArea.bringSubviewToFront(self.scanCapture)
            self.reStartScan()
        }
    }
    
    @objc func stopScanInvoice() {
        if let scannerView = self.scannerView {
            if scannerView.isRunning {
                scannerView.stopScanning()
                scannerView.removeFromSuperview()
            }
        }
    }
    
    func reStartScan() {
        if !scannerView!.isRunning {
            scannerView?.startScanning()
        }
    }
    
    func qrScanningDidStop() {
        
    }
    
    func qrScanningDidFail() {
        presentAlert(withTitle: "Error", message: "Scanning Failed. Please try again")
    }
    
    func qrScanningSucceededWithCode(_ str: String?) {
        do {
//            try goAfterAngelababy(money: 100, age: 25)
//            try goAfterVivian(money: 100, age: 25)
            if str!.count > 50 {
                let num = str!.substring(with: 0..<10)
                let date = str!.substring(with: 10..<17)
                let code = str!.substring(with: 17..<22)
                let date1 = str!.substring(with: 10..<16)
                var preName = "未開獎"
                if Int(date1) ?? 1111111 < 11007 {
                    preName = "已開獎"
                }
                if date.count != 7 {
                    Constants.showAlert2(vc: gRootViewController, title: "提示", msg:  "發票格式錯誤，請重新掃描。") { alert in
                        if !self.scannerView!.isRunning {
                            self.scannerView?.startScanning()
                        }
                    }
                    // Constants.showInfoDialog(vc: self, title: "提示", content: "發票格式錯誤，請重新掃描。", type: 1, isClose: 0)
                    return
                }
                // self.qrData = QRData(codeString: str)
                
                APIManager.shared.scanInvoice(isShow: true, invoiceNum: num, invoiceDate: date, randomNm: code) { status, JSON in
                    let json:JSON! = JSON
                    var prizeMoney = ""
                    if json["status"].stringValue == "1" {
                        let prizeStatus = json["prizeStatus"].stringValue
                        if prizeStatus == "1" {
                            preName = "中獎"
                            prizeMoney = json["prizeMoney"].stringValue
                            self.btnPrice2.isHidden = true
                            self.btnPrice1.isHidden = false
                            self.btnPrice1.setTitle("恭喜中獎！\(prizeMoney)元！", for: .normal)
                            self.scanArea.bringSubviewToFront(self.btnPrice1)
                        }
                        else if prizeStatus == "9" {
                            preName = "尚未開獎"
                            self.btnPrice2.isHidden = false
                            self.btnPrice1.isHidden = true
                            self.btnPrice2.setTitle(preName, for: .normal)
                            self.scanArea.bringSubviewToFront(self.btnPrice2)
                        }
                        else if prizeStatus == "0"{
                            preName = "未中獎"
                            self.btnPrice2.isHidden = false
                            self.btnPrice1.isHidden = true
                            self.btnPrice2.setTitle(preName, for: .normal)
                            self.scanArea.bringSubviewToFront(self.btnPrice2)
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now()+2.3) {
                            self.btnPrice2.isHidden = true
                            self.btnPrice1.isHidden = true
                            if !self.scannerView!.isRunning {
                                self.scannerView?.startScanning()
                            }
                        }
                        /*
                        Constants.showAlert2(vc: gRootViewController, title: "提示", msg:  "發票號碼：" + "\(num)" + "\n發票日期：" + date + "\n 隨機碼：" + code + "\n" + preName) { alert in
                            if !self.scannerView!.isRunning {
                                self.scannerView?.startScanning()
                            }
                        }
                        */
                    }
                    else {
                        Constants.showAlert2(vc: gRootViewController, title: "提示", msg:  "發票格式錯誤，請重新掃描。") { alert in
                            if !self.scannerView!.isRunning {
                                self.scannerView?.startScanning()
                            }
                        }
                        // Constants.showInfoDialog(vc: self, title: "提示", content: "發票格式錯誤，請重新掃描。", type: 1, isClose: 0)
                    }
                }
//                let vc = InfoDialogViewController()
//                vc.titleString = "提示"
//                vc.contentString = "發票號碼：" + "\(num)" + "\n發票日期：" + date + "\n 隨機碼：" + code + "\n" + preName;
//                vc.type = 0
//                vc.modalPresentationStyle = .overCurrentContext
//                gRootViewController.present(vc, animated: false, completion: nil)
            }
            else {
                Constants.showAlert2(vc: gRootViewController, title: "提示", msg:  "發票格式錯誤，請重新掃描。") { alert in
                    if !self.scannerView!.isRunning {
                        self.scannerView?.startScanning()
                    }
                }
                // Constants.showInfoDialog(vc: self, title: "提示", content: "發票格式錯誤，請重新掃描。", type: 1, isClose: 0)
            }
        }
        catch {
                
        }
    }
    
    @IBAction func inputInvoice() {
        gScan1 = 1
        gScan2 = 1
        let vc = InputInvoiceViewController()
        gNav1?.pushViewController(vc, animated: true)
    }
    
    @IBAction func openLight() {
        if let device = AVCaptureDevice.default(for: AVMediaType.video) {

            if (device.hasTorch) {
                do {
                    try device.lockForConfiguration()
                    let torchOn = !device.isTorchActive
                    try device.setTorchModeOn(level: 1.0)
                    device.torchMode = torchOn ? AVCaptureDevice.TorchMode.on : AVCaptureDevice.TorchMode.off
                    device.unlockForConfiguration()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

//extension ScanInvoiceViewController: QRScannerViewDelegate {
//
//}

extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }

    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }

    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }

    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
}
