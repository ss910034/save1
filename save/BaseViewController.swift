//
//  BaseViewController.swift
//  save
//
//  Created by Frank Liu on 2021/10/20.
//

import UIKit

var rotateType = 0

class BaseViewController: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(back), name: NSNotification.Name(
            "CloseInfoDialog"), object: nil)
        self.addKeyboardObserver()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
            super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
            switch UIDevice.current.orientation{
               case .landscapeLeft:
                print("Landscape Left")
                self.showBarCodeViw()
               case .landscapeRight:
                print("Landscape Right")
                self.showBarCodeViw()
               default:
                break
            }
        } else {
            print("Portrait")
        }
    }
    
    func showBarCodeViw() {
//        if rotateType == 1 {
//            if gIsBack == false {
//                gIsBack = true
//                self.presentBarCodeView()
//            }
//            return
//        }
        
        if gIsBack == false, isDialogOpen == false {
            gIsBack = true
            gScan1 = 1
            gScan2 = 1
            let vc = ShowBarCodeViewController()
            if gNav1 != nil, gIsLevel1 == false {
                gNav1?.pushViewController(vc, animated: true)
            }
            else if gNav2 != nil, gIsLevel1 == false {
                gNav2?.pushViewController(vc, animated: true)
            }
            else if gNav3 != nil, gIsLevel1 == false {
                gNav3?.pushViewController(vc, animated: true)
            }
            else if gNav4 != nil, gIsLevel1 == false {
                gNav4?.pushViewController(vc, animated: true)
            }
            else if gNav5 != nil, gIsLevel1 == false {
                gNav5?.pushViewController(vc, animated: true)
            }
            else {
                if isToDetail == true, gNav2 != nil {
                    gNav2?.pushViewController(vc, animated: true)
                }
                else {
                    gNav?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
    func presentBarCodeView() {
        let vc = ShowBarCodeViewController()
        self.presentInFullScreen(vc, animated: true, completion: nil)
    }
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        return true
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction  func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelModally() {
        self.dismiss(animated: false, completion: nil)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func scan() {
        gScan1 = 0
        gScan2 = 0
        let vc = InvoiceViewController()
        gNav1?.pushViewController(vc, animated: true)
    }
    
    @IBAction func search() {
        gScan1 = 1
        gScan2 = 1
        let vc = SearchViewController()
        gNav1?.pushViewController(vc, animated: true)
    }
}

extension UIViewController {
  func presentInFullScreen(_ viewController: UIViewController,
                           animated: Bool,
                           completion: (() -> Void)? = nil) {
    viewController.modalPresentationStyle = .fullScreen
    present(viewController, animated: animated, completion: completion)
  }
}

extension UIViewController {
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell {
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell {
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

extension UIResponder {
    
    static weak var responder: UIResponder?
    
    static func currentFirst() -> UIResponder? {
        responder = nil
        UIApplication.shared.sendAction(#selector(trap), to: nil, from: nil, for: nil)
        return responder
    }
    
    @objc private func trap() {
        UIResponder.responder = self
    }
}

extension UIViewController {
    func addKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardNotifications(notification:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
    }
    
    func removeKeyboardObserver(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    // This method will notify when keyboard appears/ dissapears
    @objc func keyboardNotifications(notification: NSNotification) {
        
        var txtFieldY : CGFloat = 0.0  //Using this we will calculate the selected textFields Y Position
        let spaceBetweenTxtFieldAndKeyboard : CGFloat = 5.0 //Specify the space between textfield and keyboard
       
        
        var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        if let activeTextField = UIResponder.currentFirst() as? UITextField ?? UIResponder.currentFirst() as? UITextView {
            // Here we will get accurate frame of textField which is selected if there are multiple textfields
            frame = self.view.convert(activeTextField.frame, from:activeTextField.superview)
            txtFieldY = frame.origin.y + frame.size.height
        }
        
        if let userInfo = notification.userInfo {
            // here we will get frame of keyBoard (i.e. x, y, width, height)
            let keyBoardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let keyBoardFrameY = keyBoardFrame!.origin.y
            let keyBoardFrameHeight = keyBoardFrame!.size.height
            
            var viewOriginY: CGFloat = 0.0
            //Check keyboards Y position and according to that move view up and down
            if keyBoardFrameY >= UIScreen.main.bounds.size.height {
                viewOriginY = 0.0
            } else {
                // if textfields y is greater than keyboards y then only move View to up
                if txtFieldY >= keyBoardFrameY {
                    
                    viewOriginY = (txtFieldY - keyBoardFrameY) + spaceBetweenTxtFieldAndKeyboard
                    
                    //This condition is just to check viewOriginY should not be greator than keyboard height
                    // if its more than keyboard height then there will be black space on the top of keyboard.
                    if viewOriginY > keyBoardFrameHeight { viewOriginY = keyBoardFrameHeight }
                }
            }
            
            //set the Y position of view
            self.view.frame.origin.y = -viewOriginY
        }
    }
}
