//
//  Log.swift
//  tinvay
//
//  Created by Apple on 27/6/24.
//

import Foundation
import UIKit

class Logger: NSObject {
    static let shared = Logger()
    var isShowResult = true
    
    func printParamJSON(url: String, parameters: [String: Any]?, method: String) {
        guard let params = parameters else {
            print("\n./\(method): \(url)")
            return
        }
        
        // Serialize to JSON
        if let jsonData = try? JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions.prettyPrinted) {
            // Convert to a string and print
            if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                if method == "GET" {
                    var str = ""
                    for (index, obj) in parameters!.enumerated() {
                        if index == 0 {
                            str = "?\(obj.key)=\(obj.value)"
                        } else {
                            str = "\(str)&\(obj.key)=\(obj.value)"
                        }
                    }
                    
                    print("\n./\(method): \(url)\(str) \nparams: \(JSONString)")
                    
                } else {
                    print("\n./\(method): \(url) \(JSONString)")
                }
            } else {
                print("\n./\(method): \(url): Param JSON null")
            }
        }
    }
    
    func logApiRequest(url: String, method: String, parameters: [String: Any]?, result: Data?) {
        if self.isShowResult {
            self.printParamJSON(url: url, parameters: parameters, method: method)
            self.printResultResponse(url: url, data: result)
        } else {
            self.printParamJSON(url: url, parameters: parameters, method: method)
            self.printResultResponse(url: url, data: nil)
        }
    }
    
    func printResultResponse(url: String, data: Data?) {
        if data == nil {
            print("result: \("Response Not Print || Nil")\n")
            return
        }
        
        if let JSONString = String(data: data!, encoding: String.Encoding.utf8) {
            if let dataConvert = JSONString.data(using: .utf8) {
                do {
                    if let jsonData = try JSONSerialization.jsonObject(with: dataConvert, options: .fragmentsAllowed) as? [String: Any] {
                        print("result: \(jsonData)")
                        
                        if let meta = jsonData["meta"] as? [String: Any] {
                            let code = meta["code"] as? Int ?? -1
                            let message = meta["message"] as? String ?? "Null"
                            print("<API-Success> code: \(code), message: \(message), url: \(url)")
                        }
                        
                    } else {
                        print("result: \("jsonArray - bad json")\n")
                    }
                } catch let error as NSError {
                    print("result: error \(error.localizedDescription), url: \(url)")
                }
            } else {
                print("result: JSONString null, url: \(url)")
            }
            
        } else {
            print("result: JSONString null, url: \(url)")
        }
    }
    
    static func println(_ title: String) {
        print("\(title)")
    }
    
    static func println(_ title: String, _ data: Any?) {
        if let data = data as? [String: Any] {
            guard let data = try? JSONSerialization.data(withJSONObject: data, options: JSONSerialization.WritingOptions.prettyPrinted) else {
                return
            }
            let parameters = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
            print("\(title):  \(parameters ?? "data value nil")")

        } else {
            print("\(title): data is not exist or nil")
        }
    }
    
    static func println(_ title: String, _ data: Any?, _ controller: UIViewController) {
        if let data = data as? [String: Any] {
            guard let data = try? JSONSerialization.data(withJSONObject: data, options: JSONSerialization.WritingOptions.prettyPrinted) else {
                return
            }
            let parameters = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
            print("<\(controller.description)> \(title):  \(parameters ?? "data value nil")")
        } else {
            print("<\(controller.description)> \(title): data is not exist or nil")
        }
    }
}
