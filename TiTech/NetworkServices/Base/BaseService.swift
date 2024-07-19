//
//  BaseService.swift
//  tinvay
//
//  Created by Apple on 27/6/24.
//

import Foundation
import Alamofire
import Moya

class BaseService {
    // MARK: Singleton
    static let shared = BaseService()
    
    private init() { }
    
    private var headersDefault: HTTPHeaders? {
        var systemInfo = utsname()
        uname(&systemInfo)
        var header = HTTPHeaders()
        header.add(name: "Content-type", value: "application/json")
        if DataManager.shared.accessToken != "" {
            header.add(name: "Authorization", value: "Bearer \(DataManager.shared.accessToken)")
        }

        return header
    }
        
    func headers(accessToken: String?) -> HTTPHeaders? {
        var systemInfo = utsname()
        uname(&systemInfo)
        var header = HTTPHeaders()
        header.add(name: "Content-type", value: "application/json")
        if let _accessToken = accessToken {
            header.add(name: "Authorization", value: "Bearer \(_accessToken)")
        }
        
        return header
    }
    
    // MARK: - JSONDecoder
    private var jsonDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        let dateFormat = DateFormatter()
        decoder.dateDecodingStrategy = .formatted(dateFormat)
        return decoder
    }
    
    // MARK: - GET
    func GET<T: Codable>(url: String,
                         param: [String: Any]?,
                         headers: HTTPHeaders? = nil,
                         completion: @escaping ((Result<BaseModel<T>, APIError>) -> Void)) {
        let request = AF.request(url.toUrl,
                                 method: .get,
                                 parameters: param,
                                 headers: headers ?? self.headersDefault)
        request.validate().responseDecodable(of: BaseModel<T>.self, decoder: self.jsonDecoder) { [weak self] (response: DataResponse<BaseModel<T>, AFError>) in
            
            Logger.shared.logApiRequest(url: url, method: "GET", parameters: param, result: response.data)
            
            guard let `self` = self else {
                return
            }
            completion(self.handleResponse(response))
        }
    }
    
    // MARK: - POST
    func POST<T: Codable>(url: String,
                          param: [String: Any]?,
                          headers: HTTPHeaders? = nil,
                          encoding: ParameterEncoding = JSONEncoding.default,
                          completion: @escaping ((Result<BaseModel<T>, APIError>) -> Void)) {
        let request = AF.request(url,
                                 method: .post,
                                 parameters: param,
                                 encoding: encoding,
                                 headers: headers ?? self.headersDefault)
        request.validate().responseDecodable(of: BaseModel<T>.self, decoder: self.jsonDecoder) { [weak self] (response: DataResponse<BaseModel<T>, AFError>) in
            
            Logger.shared.logApiRequest(url: url, method: "POST", parameters: param, result: response.data)
            
            guard let `self` = self else {
                return
            }
            completion(self.handleResponse(response))
        }
    }
    
    func POSTAuth<T: Codable>(url: String,
                          param: [String: Any]?,
                          headers: HTTPHeaders? = nil,
                          completion: @escaping ((Result<T, APIError>) -> Void)) {
        let request = AF.request(url,
                                 method: .post,
                                 parameters: param,
                                 encoding: JSONEncoding.default,
                                 headers: headers ?? self.headersDefault)
        request.validate().responseDecodable(of: T.self, decoder: self.jsonDecoder) { [weak self] (response: DataResponse<T, AFError>) in
            
            Logger.shared.logApiRequest(url: url, method: "POST", parameters: param, result: response.data)
            
            guard let `self` = self else {
                return
            }
            completion(self.handleResponse(response))
        }
    }
    
    // MARK: - PUT
    func PUT<T: Codable>(url: String,
                         param: [String: Any]?,
                         headers: HTTPHeaders? = nil,
                         encoding: ParameterEncoding = JSONEncoding.prettyPrinted,
                         completion: @escaping ((Result<BaseModel<T>, APIError>) -> Void)) {
        
        let request = AF.request(url,
                                 method: .put,
                                 parameters: param,
                                 encoding: encoding,
                                 headers: headers ?? self.headersDefault)
        request.validate().responseDecodable(of: BaseModel<T>.self, queue: .main, decoder: self.jsonDecoder) { [weak self] (response: DataResponse<BaseModel<T>, AFError>) in

            Logger.shared.logApiRequest(url: url, method: "PUT", parameters: param, result: response.data)
            
            guard let `self` = self else {
                return
            }
            completion(self.handleResponse(response))
        }
    }
    
    // MARK: - DELETE
    func DELETE<T: Codable>(url: String,
                            param: [String: Any]?,
                            headers: HTTPHeaders? = nil,
                            completion: @escaping ((Result<BaseModel<T>, APIError>) -> Void)) {
        
        let request = AF.request(url,
                                 method: .delete,
                                 parameters: param,
                                 headers: headers ?? self.headersDefault)
        request.validate().responseDecodable(of: BaseModel<T>.self, decoder: self.jsonDecoder) { [weak self] (response: DataResponse<BaseModel<T>, AFError>) in

            Logger.shared.logApiRequest(url: url, method: "DELETE", parameters: param, result: response.data)
            
            guard let `self` = self else {
                return
            }
            completion(self.handleResponse(response))
        }
    }
    
    // MARK: - UPLOAD IMAGES
    func UPLOAD_IMAGES<T: Codable>(url: String,
                                   params: [String: String],
                                   images: [[String: Any]],
                                   completion: @escaping (Result<T, APIError>) -> Void) {
        let request = AF.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in params {
                print("./UPLOAD: images \(key): \(value)")
                if let newData = value.data(using: .utf8) {
                    multipartFormData.append(newData, withName: key)
                }
            }
            
            for object in images {
                guard let data = object as? [String: Data] else {
                    return
                }
                guard let key = data.keys.first, let value = data.values.first else {
                    return
                }
                
                multipartFormData.append(value, withName: key, fileName: "\(key).jpeg", mimeType: "image/jpeg")
                print("./UPLOAD: images key true:", key)
            }
        },
        to: url,
        method: .post,
        headers: headersDefault)
        
        request.uploadProgress { progress in
            let completedUnitCount = progress.completedUnitCount
            print("./UPLOAD: completed ", Units(bytes: Int64(completedUnitCount)).getReadableUnit())
            
        }.validate().responseDecodable(of: T.self, decoder: self.jsonDecoder) { [weak self] (response: DataResponse<T, AFError>) in
            
            Logger.shared.logApiRequest(url: url, method: "UPLOAD", parameters: params, result: response.data)
            
            guard let `self` = self else {
                return
            }
            completion(self.handleResponse(response))
        }
    }
}

//MARK: - Handle Response
extension BaseService {
    // Moya Response
    func handle<T: Codable>(_ result: Result<Response, MoyaError>, type: T.Type) -> Result<T?, APIError> {
        switch result {
        case .success(let response):
            do {
                let decodedObject = try self.jsonDecoder.decode(T.self, from: response.data)
                return .success(decodedObject)
            } catch {
                let apiError = APIError(message: error.localizedDescription, 
                                        statusCode: response.statusCode)
                return .failure(apiError)
            }
        case .failure(let error):
            guard let response = error.response else {
                let apiError = APIError(message: error.localizedDescription, statusCode: error.errorCode)
                return .failure(apiError)
            }
            let code = response.statusCode
            if code == 401 {
                self.handlerTokenExpire()
            }
            
            if let apiError = try? self.jsonDecoder.decode(APIError.self, from: response.data) {
                return .failure(apiError)
            } else {
                let jsonObject = try? JSONSerialization.jsonObject(with: response.data, options: .fragmentsAllowed) as? [String: Any]
                let metaObject = jsonObject?["meta"] as? [String: Any]
                let messageData = metaObject?["message"] as? String
                
                let message = messageData ?? error.localizedDescription
                let apiError = APIError(message: message, statusCode: code)
                return .failure(apiError)
            }
        }
    }
    
    // AF Response
    func handleResponse<T: Codable>(_ response: DataResponse<T, AFError>) -> (Result<T, APIError>) {
        switch response.result {
        case .success(let value):
            return Result.success(value)
            
        case .failure(let error):
            guard let data = response.data else {
                let code = response.response?.statusCode ?? -1
                if code == 401 {
                    self.handlerTokenExpire()
                }
                
                let message =  error.errorDescription ?? "AFError"
                let apiError = APIError(message: message, statusCode: code)
                return Result.failure(apiError)
            }
            
            if let apiError = try? self.jsonDecoder.decode(APIError.self, from: data) {
                return Result.failure(apiError)
                
            } else {
                let code = response.response?.statusCode ?? -1
                if code == 401 {
                    self.handlerTokenExpire()
                }
                
                let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any]
                let metaObject = jsonObject?["meta"] as? [String: Any]
                let messageData = metaObject?["message"] as? String
                
                let message = messageData ?? error.errorDescription ?? "AFError"
                let apiError = APIError(message: message, statusCode: code)
                return Result.failure(apiError)
            }
        }
    }

    func handlerTokenExpire() {
        NotificationCenter.default.post(name: .tokenExpire, object: nil)
    }
}
