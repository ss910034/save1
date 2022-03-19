//
//  ScanProductViewController.swift
//  save
//
//  Created by Frank Liu on 2021/10/23.
//

import UIKit
import SwiftyJSON
import AVFoundation

var gScan1 = 0
var gScan2 = 0

class ScanProductViewController: BaseViewController, QRScannerViewDelegate {
    
    @IBOutlet weak var scanArea: UIView!
    @IBOutlet weak var scanCapture: UIImageView!

    var scannerView:QRScannerView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gScan1 = 0
        NotificationCenter.default.addObserver(self, selector: #selector(scanProduct), name: NSNotification.Name("ScanProduct"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(stopScanProduct), name: NSNotification.Name("StopScanProduct"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(removeScanNot), name: NSNotification.Name("RemoveScanNot"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.reStartScan()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        gIsFromScan = 2
        self.stopScanProduct()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    @objc func removeScanNot() {
        if gScan1 == 0 {
            NotificationCenter.default.removeObserver(self)
        }
    }
    
    @objc func scanProduct() {
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
    
    @objc func stopScanProduct() {
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
        if str!.count < 20 {
            APIManager.shared.queryProductByBarcode(isShow: true, barcode: str!) { status, JSON in
                let json:JSON! = JSON
                var ary:[ProdutCateDetailData] = []
                let dic = json.dictionaryValue.sorted(by: { $0 < $1})
                dic.forEach { (key: String, value: JSON) in
                    let data = ProdutCateDetailData()
                    let dic = value.dictionaryValue
                    data.id = dic["id"]!.stringValue
                    data.discountx = dic["discountx"]!.stringValue
                    data.productx = dic["productx"]!.stringValue
                    data.pricex = dic["pricex"]!.stringValue
                    data.barcodex = dic["barcodex"]!.stringValue
                    data.merchantx = dic["merchantx"]!.stringValue
                    data.catx = dic["catx"]!.stringValue
                    data.isCollect = dic["isCollect"]!.stringValue
                    data.productx = dic["productx"]!.stringValue
                    ary.append(data)
                }
                if ary.count == 0 {
                    // Constants.showInfoDialog(vc: self, title: "提示", content: "該商品尚未登陸，請試試文字搜尋！", type: 0, isClose: 0)
                    Constants.showAlert2(vc: gRootViewController, title: "提示", msg:  "讀取失敗") { alert in
                        if !self.scannerView!.isRunning {
                            self.scannerView?.startScanning()
                        }
                    }
                }
                else {
                    let vc = ProductInfoViewController()
                    vc.dataAry = ary
                    vc.productId = ary[0].id
                    vc.parentVC2 = self
                    gNav?.pushViewController(vc, animated: true)
                }
            }
        }
        else {
            Constants.showAlert2(vc: gRootViewController, title: "提示", msg:  "讀取失敗") { alert in
                if !self.scannerView!.isRunning {
                    self.scannerView?.startScanning()
                }
            }
        }
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
