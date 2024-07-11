//
//  NetworkingManager.swift
//  TiTech
//
//  Created by Apple on 11/7/24.
//

import Foundation
import Alamofire
import Moya

struct VoidAlias: Codable {}

private func JSONResponseDataFormatter(_ data: Data) -> String {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return String(data: prettyData, encoding: .utf8) ?? String(data: data, encoding: .utf8) ?? ""
    } catch {
        return String(data: data, encoding: .utf8) ?? ""
    }
}

class NetworkingManager {
    static let apiProvider: MoyaProvider<NetworkingAPI> = {
        let plugins = [NetworkLoggerPlugin(configuration: .init(formatter: .init(responseData: JSONResponseDataFormatter), logOptions: .verbose))]
        return MoyaProvider<NetworkingAPI>(session: APISession.session, plugins: plugins)
    }()
}

class APISession {
    static let eventMonitor = ClosureEventMonitor()
    static let session: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = APIConstants.DEFAULT_TIMEOUT_INTERVAL
        configuration.timeoutIntervalForResource = APIConstants.DEFAULT_TIMEOUT_INTERVAL
        let sessionManager = Session(configuration: configuration, interceptor: RequestHandler(), eventMonitors: [eventMonitor])
        return sessionManager
    }()
}

class RequestHandler: RequestInterceptor {
    private typealias RefreshCompletion = (_ succeeded: Bool, _ idToken: String?) -> Void
    private let lock = NSLock()
    private var isRefreshing = false
    private var requestsToRetry: [(RetryResult) -> Void] = []
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        lock.lock() ; defer { lock.unlock() }
        
        if let response = request.task?.response as? HTTPURLResponse,
            response.statusCode == HTTPStatusCodes.Unauthorized.rawValue
                || response.statusCode == HTTPStatusCodes.Forbidden.rawValue {
            requestsToRetry.append(completion)
            if !isRefreshing {
                // handle retry here
                completion(.doNotRetry)
            }
            
        } else {
            completion(.doNotRetry)
        }
        
    }
}
