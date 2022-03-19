//
//  Constants.swift
//  tw.com.skl
//
//  Created by Frank Liu on 2019/4/30.
//  Copyright © 2019 Doing. All rights reserved.
//

import UIKit
import AVFoundation

enum TimeConstant {
    static let secsPerMin = 60
    static let secsPerHour = TimeConstant.secsPerMin * 60
}

let produtCateDic:[Int : String] = [0  : "飲料",
                                    1  : "零食餅乾",
                                    2  : "泡麵罐頭",
                                    3  : "洗沐用品",
                                    4  : "美妝保養",
                                    5  : "日用百貨",
                                    6  : "啤酒調酒",
                                    7  : "冷凍食品",
                                    8  : "生鮮冷藏",
                                    9  : "米油沖泡",
                                    10 : "保健護理",
                                    11 : "生活休閒",
                                    12 : "洋酒啤酒",
                                    13 : "母嬰用品",
                                    14 : "寵物商品"]

class Constants: NSObject {
    
    static func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    @objc static func getProductCategoryDic() -> [Int:String]! {
        return produtCateDic
    }
    
    static func convertToArray(text: String) -> Array<Dictionary<String, String>>? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? Array<Dictionary<String, String>>
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    static func showInfoDialog(vc:UIViewController, title:String, content:String, type:Int, isClose:Int) {
        let d = InfoDialogViewController()
        d.titleString = title
        d.contentString = content
        d.type = type
        d.isClose = isClose
        rotateType = 1
        d.modalPresentationStyle = .overCurrentContext
        vc.present(d, animated: false, completion: nil)
    }
    
    static func showAlert2(vc:UIViewController, title:String, msg:String, completion: @escaping (UIAlertAction)->()){
        let controller = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: completion)
        controller.addAction(okAction)
        vc.present(controller, animated: true, completion: nil)
    }
    
    static func showAlert(vc:UIViewController, title:String, msg:String) {
        let controller = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        controller.addAction(okAction)
        vc.present(controller, animated: true, completion: nil)
    }
    
    static func getAppVersion() -> String {
        return (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String)!
    }
    
    static func isFirstEnter() -> Bool {
        if !isKeyPresentInUserDefaults(key: "FirstToHome") {
            UserDefaults.standard.set(true, forKey: "FirstToHome")
            UserDefaults.standard.synchronize()
            return true
        }
        else if UserDefaults.standard.bool(forKey: "FirstToHome") {
            return false
        }
        return false
    }
    
    static func isFirstLogin() -> Bool {
        if !isKeyPresentInUserDefaults(key: "FirstLogin") {
            UserDefaults.standard.set(true, forKey: "FirstLogin")
            UserDefaults.standard.synchronize()
            return true
        }
        else if UserDefaults.standard.bool(forKey: "FirstLogin") {
            return false
        }
        return false
    }
    
    static func resetFirstEnterHome() {
        UserDefaults.standard.set(true, forKey: "FirstToHome")
        UserDefaults.standard.synchronize()
    }
    
    static func getLoginData() -> [String:String]? {
        return UserDefaults.standard.object(forKey: "LoginData") as? [String:String]
    }
    
    static func setLoginData(data:[String:String]) {
        UserDefaults.standard.set(data, forKey: "LoginData")
        UserDefaults.standard.synchronize()
    }
    
    static func getHistorySearchData() -> [String]? {
        return UserDefaults.standard.object(forKey: "HistorySearchData") as? [String]
    }
    
    static func setHistorySearchData(data:[String]) {
        UserDefaults.standard.set(data, forKey: "HistorySearchData")
        UserDefaults.standard.synchronize()
    }
    
    static func clearHistorySearchData() {
        UserDefaults.standard.removeObject(forKey: "HistorySearchData")
        UserDefaults.standard.synchronize()
    }
    
    static func getHistorySearchID() -> [Int]? {
        return UserDefaults.standard.object(forKey: "HistorySearchID") as? [Int]
    }
    
    static func setHistorySearchID(data:[Int]) {
        UserDefaults.standard.set(data, forKey: "HistorySearchID")
        UserDefaults.standard.synchronize()
    }
    
    static func isKeyPresentInUserDefaults(key: String) -> Bool {
        let rc = UserDefaults.standard.object(forKey: key) != nil
        return rc
    }
    
    static func getYellowColor() -> UIColor {
        return UIColor(displayP3Red: 255/255.0, green: 205/255.0, blue: 0/255.0, alpha: 1.0)
    }
    
    @objc static func getDefaultTextColor() -> UIColor {
        return UIColor(displayP3Red: 16/255.0, green: 65/255.0, blue: 84/255.0, alpha: 1.0)
    }
    
    @objc static func getDefaultLineColor() -> UIColor {
        return UIColor(displayP3Red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1.0)
    }
    
    static func randomString(length: Int) -> String {
        let letters : NSString = "ABC0DE1FG2HI3JK4LM5NO6PQR7STU8VW9XYZ"
        let len = UInt32(letters.length)
        var randomString = ""
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        return randomString
    }
    
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    static func getScreenSize() -> (w:CGFloat, h:CGFloat) {
        let bounds = UIScreen.main.bounds
        let width = bounds.size.width
        let height = bounds.size.height
        return (width, height)
    }
    
//    static func getDeviceId() -> String {
//        print("device id=" + UIDevice.current.identifierForVendor!.uuidString)
//        return UIDevice.current.identifierForVendor!.uuidString
//    }
    
    static func isValidEmail(emailStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailStr)
    }
    
    static func randomString2(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    static func showViewInKeywindow(view:UIView){
        UIApplication.shared.keyWindow?.addSubview(view)
    }
    
    // ISODATE YYYY-MM-ddTHH:mm:ss.SSSZ
    static func getDateString(date: Date) -> String {
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formater.timeZone = TimeZone(identifier: "UTC")
        let dateStr = formater.string(from: date)
        return dateStr
    }
    
    static func secureCopyItem(at srcURL: URL, to dstURL: URL) -> Bool {
        do {
            if FileManager.default.fileExists(atPath: dstURL.path) {
                try FileManager.default.removeItem(at: dstURL)
            }
            try FileManager.default.copyItem(at: srcURL, to: dstURL)
        } catch (let error) {
            print("Cannot copy item at \(srcURL) to \(dstURL): \(error)")
            return false
        }
        return true
    }
    
    /*
    static func deleteFile(folder:String, filename:String, storyId:String, completion: @escaping (Bool, JSON?)->()) {
        DispatchQueue.global(qos: .default).async {
            if storyId != "" {
                APIManager.shared.deleteStory(isShow: false, storyId: storyId, completion: { (status, JSON) in
                    print(JSON!)
                    completion(status, JSON)
                })
            }
            if filename != "" {
                let path = NSHomeDirectory() + "/Documents/" + filename
                if FileManager.default.fileExists(atPath: path) {
                    try! FileManager.default.removeItem(atPath: path)
                }
            }
        }
    }
    */
    
    static func formatted(time: Float) -> String {
        var secs = Int(ceil(time))
        var hours = 0
        var mins = 0
        
        if secs > TimeConstant.secsPerHour {
            hours = secs / TimeConstant.secsPerHour
            secs -= hours * TimeConstant.secsPerHour
        }
        
        if secs > TimeConstant.secsPerMin {
            mins = secs / TimeConstant.secsPerMin
            secs -= mins * TimeConstant.secsPerMin
        }
        
        var formattedString = ""
        if hours > 0 {
            formattedString = "\(String(format: "%02d", hours)):"
        }
        formattedString += "\(String(format: "%02d", mins)):\(String(format: "%02d", secs))"
        return formattedString
    }
    
    static func getDateByDay(date:String, byDay:Int) -> Date? {
        let today = Constants.getDateFromString(date: date)
        let another = Calendar.current.date(byAdding: .day, value: byDay, to: today!)
        return another
    }
    
    static func getDateByDay2(date:Date, byDay:Int) -> Date? {
        let another = Calendar.current.date(byAdding: .day, value: byDay, to: date)
        return another
    }
    
    // 數字 1 是星期天，2 是星期一，其它以此類推。
    static func getWeekDay(date:String) -> Int {
        let today = Constants.getDateFromString(date: date)
        let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: today!)
        let weekday = dateComponents.weekday!
        return weekday
    }
    
    static func getWeekDayString(week:Int) -> String {
        if week == 1 {
            return NSLocalizedString("sun", comment: "")
        }
        else if week == 2 {
            return NSLocalizedString("mon", comment: "")
        }
        else if week == 3 {
            return NSLocalizedString("tue", comment: "")
        }
        else if week == 4 {
            return NSLocalizedString("wed", comment: "")
        }
        else if week == 5 {
            return NSLocalizedString("thu", comment: "")
        }
        else if week == 6 {
            return NSLocalizedString("fri", comment: "")
        }
        else if week == 7 {
            return NSLocalizedString("sat", comment: "")
        }
        return "error"
    }
    
    static func markMail(mail:String) -> String {
        if mail == "" {
            return mail
        }
        let item1 = mail.components(separatedBy: "@")
        let item2 = item1[1].components(separatedBy: ".")
        var str1 = ""
        for (_, _) in item2[0].enumerated() {
            str1 += "*"
        }
        var rc = mail.replacingOccurrences(of: item2[0], with: str1)
        var str2 = ""
        if item1[0].count <= 3 {
            for _ in 1...item1[0].count {
                str2 += "*"
            }
            rc = rc.replacingOccurrences(of: item1[0], with: str2)
            return rc
        }
        else {
            var str3 = item1[0].dropLast(3)
            for _ in 1...3 {
                str3 += "*"
            }
            rc = rc.replacingOccurrences(of: item1[0], with: str3)
            return rc
        }
    }
    
    static func markMail2(mail:String) -> String {
        if mail == "" {
            return mail
        }
        let item1 = mail.components(separatedBy: "@")
        var rc = mail
        var str2 = ""
        if item1[0].count <= 2 {
            for _ in 1...item1[0].count {
                str2 += "*"
            }
            rc = rc.replacingOccurrences(of: item1[0], with: str2)
            return rc
        }
        else {
            if item1[0].count == 3 {
                let last = item1[0].last
                str2 = "**" + String(last!)
                rc = rc.replacingOccurrences(of: item1[0], with: str2)
                return rc
            }
            else {
                let last2 = item1[0].suffix(2)
                str2 = "**" + last2
                var str3 = item1[0].dropLast(4)
                str3 += str2
                rc = rc.replacingOccurrences(of: item1[0], with: str3)
                return rc
            }
        }
    }
    
    static func getDateFromString(date:String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.date(from:date)
    }
    
    static func getDateFromString2(date:String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.date(from:date)
    }
    
    static func getDateComps(date:Date) -> DateComponents {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        return components
    }
    
    static func changeLineSpace(txtString: String, space:CGFloat, fontSize: CGFloat, fontColor:UIColor) -> NSAttributedString {
        let style = NSMutableParagraphStyle()
        style.lineSpacing = space
        let attributes = [NSAttributedString.Key.paragraphStyle : style, NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize),
                          NSAttributedString.Key.foregroundColor: fontColor]
        return NSAttributedString(string: txtString, attributes: attributes)
    }
    
    static func changeLineSpaceAndCenter(txtString: String, space:CGFloat, fontSize: CGFloat, fontColor:UIColor) -> NSAttributedString {
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        style.lineSpacing = space
        let attributes = [NSAttributedString.Key.paragraphStyle : style, NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize),
                          NSAttributedString.Key.foregroundColor: fontColor]
        return NSAttributedString(string: txtString, attributes: attributes)
    }
    
    static func applyAttributedSubString(str:String, attributedString: NSAttributedString, query: String, color:UIColor, fontSize:CGFloat=0.0, centerSubstring:Bool=false) -> NSMutableAttributedString {
        let text = NSMutableAttributedString(attributedString: attributedString)
        var searchRange = str.startIndex..<str.endIndex
        while let range = str.range(of: query, options: NSString.CompareOptions.literal, range: searchRange) {
            text.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: NSRange(range, in: str))
            if fontSize != 0.0 {
                text.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: fontSize), range: NSRange(range, in: str))
            }
            if centerSubstring == true {
                let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = .center
                paragraphStyle.lineSpacing = 12.0
                text.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(range, in: str))
            }
            searchRange = range.upperBound..<searchRange.upperBound
        }
        return text
    }
    
    static func applyAttributedSubString2(str1:String, attributedString1: NSAttributedString, str2:String, attributedString2:NSAttributedString, query1: String, query2:String, color1:UIColor, color2:UIColor, fontSize1:CGFloat, fontSize2:CGFloat) -> (text1:NSMutableAttributedString, text2:NSMutableAttributedString) {
        let text1 = NSMutableAttributedString(attributedString: attributedString1)
        let text2 = NSMutableAttributedString(attributedString: attributedString2)

        var searchRange1 = str1.startIndex..<str1.endIndex
        var searchRange2 = str2.startIndex..<str2.endIndex

        while let range = str1.range(of: query1, options: NSString.CompareOptions.literal, range: searchRange1) {
            text1.addAttribute(NSAttributedString.Key.foregroundColor, value: color1, range: NSRange(range, in: str1))
            text1.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: fontSize1), range: NSRange(range, in: str1))
            searchRange1 = range.upperBound..<searchRange1.upperBound
        }
        
        while let range = str2.range(of: query2, options: NSString.CompareOptions.literal, range: searchRange2) {
            text2.addAttribute(NSAttributedString.Key.foregroundColor, value: color2, range: NSRange(range, in: str2))
            text2.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: fontSize2), range: NSRange(range, in: str2))
            searchRange2 = range.upperBound..<searchRange2.upperBound
        }
        
        return (text1, text2)
    }
    
    static func applyAttributedSubStringWithSpace(str:String, attributedString: NSAttributedString, query: String, space:CGFloat, color:UIColor, fontSize:CGFloat=0.0, centerSubstring:Bool=false) -> NSMutableAttributedString {
        let text = NSMutableAttributedString(attributedString: attributedString)
        var searchRange = str.startIndex..<str.endIndex
        while let range = str.range(of: query, options: NSString.CompareOptions.literal, range: searchRange) {
            text.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: NSRange(range, in: str))
            if fontSize != 0.0 {
                text.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: fontSize), range: NSRange(range, in: str))
            }
            if centerSubstring == true {
                let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = .center
                paragraphStyle.lineSpacing = space
                text.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(range, in: str))
            }
            searchRange = range.upperBound..<searchRange.upperBound
        }
        return text
    }
    
    static func customizeStrike(string: String, color: UIColor) -> NSMutableAttributedString {
        return NSMutableAttributedString(string: string, attributes:
            [NSAttributedString.Key.foregroundColor : color, NSAttributedString.Key.strikethroughStyle : 2])
    }
    
    static func getDurationFormat(time:Int) -> String {
        let minutes = time / 60 % 60
        let seconds = time % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

extension Collection where Indices.Iterator.Element == Index {
    subscript (exist index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension UIDevice {
    var iPhoneX: Bool {
        return UIScreen.main.nativeBounds.height == 2436
    }
    var iPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    enum ScreenType: String {
        case iPhones_4_4S = "iPhone 4 or iPhone 4S"
        case iPhones_5_5s_5c_SE = "iPhone 5, iPhone 5s, iPhone 5c or iPhone SE"
        case iPhones_6_6s_7_8 = "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8"
        case iPhones_6Plus_6sPlus_7Plus_8Plus = "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus"
        case iPhones_X_XS_11Pro = "iPhone X, iPhone XS or 11 pro"
        case iPhone_XR_11 = "iPhone XR or 11"
        case iPhone_XSMax_11ProMax = "iPhone XS Max or 11 Pro Max"
        case unknownx
    }
    var screenType: ScreenType {
        switch UIScreen.main.nativeBounds.height {
        case 960:
            return .iPhones_4_4S
        case 1136:
            return .iPhones_5_5s_5c_SE
        case 1334:
            return .iPhones_6_6s_7_8
        case 1792:
            return .iPhone_XR_11
        case 1920, 2208:
            return .iPhones_6Plus_6sPlus_7Plus_8Plus
        case 2436:
            return .iPhones_X_XS_11Pro
        case 2688:
            return .iPhone_XSMax_11ProMax
        default:
            return .unknownx
        }
    }
}

extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}
