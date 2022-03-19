//
//  APIManager.swift
//  save
//
//  Created by Frank Liu on 2021/10/24.
//

import UIKit
import Alamofire
import SwiftyJSON

let BASAE_URL = "https://senba.tw/php/"
let IMAGE_URL = "https://senba.tw/senba_pic/"

enum APIName: String {
    case login                = "login_chk.php"                   // 登入
    case inputInvoice         = "inv_input_record.php"            // 手動輸入發票
    case scanInvoice          = "inv_scan_record.php"             // 發票掃描儲存
    case queryProductCate     = "product_query_cat.php"           // 商品查詢 以類別
    case queryProdurtByName   = "product_query_product.php"       // 商品查詢 以商品名稱
    case loveProduct          = "product_collect.php"             // 收藏清單
    case doLove               = "product_collect_input.php"       // 收藏商品註記
    case queryProductMerch    = "product_query_merchant.php"      // 商品查詢 以商家名稱
    case queryProductBarcode  = "product_query_barcode.php"       // 商品查詢 以商品條碼
    case queryInvoiceRecorder = "inv_head.php"                    // 消費發票紀錄
    case queryInvoiceDetail   = "inv_detail.php"                  // 消費發票明細
    case queryProductBySeller = "product_query_mer_cat.php"       // 商品查詢+類別
}

class APIManager: NSObject {
    static let shared = APIManager()
    let app = UIApplication.shared.delegate as? AppDelegate
    
    func login(isShow:Bool, phone:String, email:String, password:String, completion: @escaping (Bool, JSON?)->()) {
        let url = BASAE_URL + APIName.login.rawValue

        if isShow {
            app?.showLoadingHUD()
        }

         let params = ["phoneNo"    : phone,
                       "email"      : email,
                       "password"   : password] as [String : String]

        var header:[String:String]? = nil
        
        let encode = params.map { $0.0 + "=" + $0.1 }.joined(separator: "&")

        header = ["application/x-www-form-urlencoded" : "Content-type"]

        Alamofire.request(url, method: .post, parameters: params, encoding: encode, headers: header).responseJSON { (response) in
            if response.result.isSuccess {
                let data:JSON = JSON(response.result.value as Any)
                print(data)
                completion(true, data)
            }else{
                completion(true, nil)
                print("Error")
            }
            self.app?.hideAllHUD()
        }
    }
    
    func inputInvoice(isShow:Bool, invoiceNum:String, invoiceDate:String, randomNm:String, period:String, sellerName:String, amout:String, completion: @escaping (Bool, JSON?)->()) {
        let url = BASAE_URL + APIName.inputInvoice.rawValue

        if isShow {
            app?.showLoadingHUD()
        }

        let params = ["phoneNo"        : gPhoneNo,
                       "invNum"         : invoiceNum,
                       "invDate"        : invoiceDate,
                       "randomNumber"   : randomNm,
                       "invPeriod"      : period,
                       "sellerName"     : sellerName,
                       "amount"         : amout] as [String : String]

        var header:[String:String]? = nil
        
        let encode = params.map { $0.0 + "=" + $0.1 }.joined(separator: "&")

        header = ["application/x-www-form-urlencoded" : "Content-type"]

        Alamofire.request(url, method: .post, parameters: params, encoding: encode, headers: header).responseJSON { (response) in
            if response.result.isSuccess {
                let data:JSON = JSON(response.result.value as Any)
                print(data)
                completion(true, data)
            }else{
                completion(true, nil)
                print("Error")
            }
            self.app?.hideAllHUD()
        }
    }
    
    func scanInvoice(isShow:Bool, invoiceNum:String, invoiceDate:String, randomNm:String, completion: @escaping (Bool, JSON?)->()) {
        let url = BASAE_URL + APIName.scanInvoice.rawValue

        if isShow {
            app?.showLoadingHUD()
        }

        let params = ["phoneNo"        : gPhoneNo,
                       "invNum"         : invoiceNum,
                       "invDate"        : invoiceDate,
                       "randomNumber"   : randomNm] as [String : String]

        var header:[String:String]? = nil
        
        let encode = params.map { $0.0 + "=" + $0.1 }.joined(separator: "&")

        header = ["application/x-www-form-urlencoded" : "Content-type"]

        Alamofire.request(url, method: .post, parameters: params, encoding: encode, headers: header).responseJSON { (response) in
            if response.result.isSuccess {
                let data:JSON = JSON(response.result.value as Any)
                print(data)
                completion(true, data)
            }else{
                completion(true, nil)
                print("Error")
            }
            self.app?.hideAllHUD()
        }
    }
    
    func queryProductCagegory(isShow:Bool, name:String, completion: @escaping (Bool, JSON?)->()) {
        let url = BASAE_URL + APIName.queryProductCate.rawValue

        if isShow {
            app?.showLoadingHUD()
        }

        let params = ["phoneNo"        : gPhoneNo,
                       "catx"           : name] as [String : String]

        var header:[String:String]? = nil
        
        let encode = params.map { $0.0 + "=" + $0.1 }.joined(separator: "&")

        header = ["application/x-www-form-urlencoded" : "Content-type"]

        Alamofire.request(url, method: .post, parameters: params, encoding: encode, headers: header).responseJSON { (response) in
            if response.result.isSuccess {
                let data:JSON = JSON(response.result.value as Any)
                print(data)
                completion(true, data)
            }else{
                completion(true, nil)
                print("Error")
            }
            self.app?.hideAllHUD()
        }
    }
    
    func queryProductByName(isShow:Bool, name:String, completion: @escaping (Bool, JSON?)->()) {
        let url = BASAE_URL + APIName.queryProdurtByName.rawValue

        if isShow {
            app?.showLoadingHUD()
        }

        let params = ["phoneNo"        : gPhoneNo,
                      "productx"       : name] as [String : String]

        var header:[String:String]? = nil
        
        let encode = params.map { $0.0 + "=" + $0.1 }.joined(separator: "&")

        header = ["application/x-www-form-urlencoded" : "Content-type"]

        Alamofire.request(url, method: .post, parameters: params, encoding: encode, headers: header).responseJSON { (response) in
            if response.result.isSuccess {
                let data:JSON = JSON(response.result.value as Any)
                print(data)
                completion(true, data)
            }else{
                completion(true, nil)
                print("Error")
            }
            self.app?.hideAllHUD()
        }
    }
    
    func queryProductByMerch(isShow:Bool, merchant:String, completion: @escaping (Bool, JSON?)->()) {
        let url = BASAE_URL + APIName.queryProductMerch.rawValue

        if isShow {
            app?.showLoadingHUD()
        }

        let params = ["phoneNo"         : gPhoneNo,
                      "merchantx"       : merchant] as [String : String]

        var header:[String:String]? = nil
        
        let encode = params.map { $0.0 + "=" + $0.1 }.joined(separator: "&")

        header = ["application/x-www-form-urlencoded" : "Content-type"]

        Alamofire.request(url, method: .post, parameters: params, encoding: encode, headers: header).responseJSON { (response) in
            if response.result.isSuccess {
                let data:JSON = JSON(response.result.value as Any)
                print(data)
                completion(true, data)
            }else{
                completion(true, nil)
                print("Error")
            }
            self.app?.hideAllHUD()
        }
    }
    
    func queryProductByBarcode(isShow:Bool, barcode:String, completion: @escaping (Bool, JSON?)->()) {
        let url = BASAE_URL + APIName.queryProductBarcode.rawValue

        if isShow {
            app?.showLoadingHUD()
        }

        let params = ["phoneNo"         : gPhoneNo,
                      "barcodex"        : barcode] as [String : String]

        var header:[String:String]? = nil
        
        let encode = params.map { $0.0 + "=" + $0.1 }.joined(separator: "&")

        header = ["application/x-www-form-urlencoded" : "Content-type"]

        Alamofire.request(url, method: .post, parameters: params, encoding: encode, headers: header).responseJSON { (response) in
            if response.result.isSuccess {
                let data:JSON = JSON(response.result.value as Any)
                print(data)
                completion(true, data)
            }else{
                completion(true, nil)
                print("Error")
            }
            self.app?.hideAllHUD()
        }
    }
    
    func getLoveList(isShow:Bool, completion: @escaping (Bool, JSON?)->()) {
        let url = BASAE_URL + APIName.loveProduct.rawValue

        if isShow {
            app?.showLoadingHUD()
        }

        let params = ["phoneNo"        : gPhoneNo] as [String : String]

        var header:[String:String]? = nil
        
        let encode = params.map { $0.0 + "=" + $0.1 }.joined(separator: "&")

        header = ["application/x-www-form-urlencoded" : "Content-type"]

        Alamofire.request(url, method: .post, parameters: params, encoding: encode, headers: header).responseJSON { (response) in
            if response.result.isSuccess {
                let data:JSON = JSON(response.result.value as Any)
                print(data)
                completion(true, data)
            }else{
                completion(true, nil)
                print("Error")
            }
            self.app?.hideAllHUD()
        }
    }
    
    func doLoveAction(isShow:Bool, barCode:String, isLove:String, completion: @escaping (Bool, JSON?)->()) {
        let url = BASAE_URL + APIName.doLove.rawValue

        if isShow {
            app?.showLoadingHUD()
        }

        let params = ["phoneNo"          : gPhoneNo,
                      "barcodex"         : barCode,
                      "isCollect"        : isLove] as [String : String]

        var header:[String:String]? = nil
        
        let encode = params.map { $0.0 + "=" + $0.1 }.joined(separator: "&")

        header = ["application/x-www-form-urlencoded" : "Content-type"]

        Alamofire.request(url, method: .post, parameters: params, encoding: encode, headers: header).responseJSON { (response) in
            if response.result.isSuccess {
                let data:JSON = JSON(response.result.value as Any)
                print(data)
                completion(true, data)
            }else{
                completion(true, nil)
                print("Error")
            }
            self.app?.hideAllHUD()
        }
    }
    
    func queryInvoiceList(isShow:Bool, queryMon:String, completion: @escaping (Bool, JSON?)->()) {
        let url = BASAE_URL + APIName.queryInvoiceRecorder.rawValue

        if isShow {
            app?.showLoadingHUD()
        }

        let params = ["phoneNo"          : gPhoneNo,
                      "queryMon"         : queryMon] as [String : String]

        var header:[String:String]? = nil
        
        let encode = params.map { $0.0 + "=" + $0.1 }.joined(separator: "&")

        header = ["application/x-www-form-urlencoded" : "Content-type"]

        Alamofire.request(url, method: .post, parameters: params, encoding: encode, headers: header).responseJSON { (response) in
            if response.result.isSuccess {
                let data:JSON = JSON(response.result.value as Any)
                print(data)
                completion(true, data)
            }else{
                completion(true, nil)
                print("Error")
            }
            self.app?.hideAllHUD()
        }
    }
    
    func queryInvoiceDetail(isShow:Bool, invoiceNum:String, invoiceDate:String, completion: @escaping (Bool, JSON?)->()) {
        let url = BASAE_URL + APIName.queryInvoiceDetail.rawValue

        if isShow {
            app?.showLoadingHUD()
        }

        let params = ["phoneNo"          : gPhoneNo,
                      "invNum"           : invoiceNum,
                      "invDate"          : invoiceDate] as [String : String]

        var header:[String:String]? = nil
        
        let encode = params.map { $0.0 + "=" + $0.1 }.joined(separator: "&")

        header = ["application/x-www-form-urlencoded" : "Content-type"]

        Alamofire.request(url, method: .post, parameters: params, encoding: encode, headers: header).responseJSON { (response) in
            if response.result.isSuccess {
                let data:JSON = JSON(response.result.value as Any)
                print(data)
                completion(true, data)
            }else{
                completion(true, nil)
                print("Error")
            }
            self.app?.hideAllHUD()
        }
    }
    
    func queryProductByMerchAndSeller(isShow:Bool, merchantx:String, catx:String, pageNo:String="-1", completion: @escaping (Bool, JSON?)->()) {
        let url = BASAE_URL + APIName.queryProductBySeller.rawValue

        if isShow {
            app?.showLoadingHUD()
        }

        var params = ["phoneNo"          : gPhoneNo,
                      "merchantx"        : merchantx,
                      "catx"             : catx] as [String : String]
        
        if pageNo != "-1" {
            params["pageNo"] = pageNo
        }

        var header:[String:String]? = nil
        
        let encode = params.map { $0.0 + "=" + $0.1 }.joined(separator: "&")

        header = ["application/x-www-form-urlencoded" : "Content-type"]

        Alamofire.request(url, method: .post, parameters: params, encoding: encode, headers: header).responseJSON { (response) in
            if response.result.isSuccess {
                let data:JSON = JSON(response.result.value as Any)
                print(data)
                completion(true, data)
            }else{
                completion(true, nil)
                print("Error")
            }
            self.app?.hideAllHUD()
        }
    }
}

extension String: ParameterEncoding {

    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()
        request.httpBody = data(using: .utf8, allowLossyConversion: false)
        return request
    }
}

/*
func login(isShow:Bool, phone:String, email:String, password:String, completion: @escaping (Bool, JSON?)->()) {
    let url = BASAE_URL + APIName.login.rawValue
    
    if isShow {
        app?.showLoadingHUD()
    }
    let semaphore = DispatchSemaphore (value: 0)

    let parameters = "phoneNo=0918587059&email=gn831116%40gmail.com&password=0918587059"
    let postData =  parameters.data(using: .utf8)

    var request = URLRequest(url: URL(string: "https://senba.tw/php/login_chk.php")!,timeoutInterval: Double.infinity)
    request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-type")

    request.httpMethod = "POST"
    request.httpBody = postData

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      guard let data = data else {
        print(String(describing: error))
        semaphore.signal()
        self.app?.hideAllHUD()
        completion(true, nil)
        return
      }
      print(String(data: data, encoding: .utf8)!)
        let data2 = Data(String(data: data, encoding: .utf8)!.utf8)
        let json = JSON(data2)
        completion(true, json)
      self.app?.hideAllHUD()
      semaphore.signal()
    }

    task.resume()
    semaphore.wait()
}
 */
