//
//  Constants.swift
//  TiTech
//
//  Created by Apple on 11/7/24.
//

import Foundation

struct APIConstants {
    static let DEFAULT_TIMEOUT_INTERVAL: TimeInterval = 60.0
    
    static let NASA_API_KEY = "TqsXBhTETsdyskP7a6todOubGNcq5GySaIMEe25O"
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case acceptLanguage = "Accept-Language"
    case ifModifiedSince = "If-Modified-Since"
    case userAgent = "User-Agent"
    case cookie = "Cookie"
    case deviceGuid = "X-DEVICE-GUID"
    case notificationId = "X-Push-Notify"
    case urlScheme = "X-Url-Scheme"
}

enum ContentType: String {
    case json = "application/json"
    case urlencoded = "application/x-www-form-urlencoded"
    case password = "X- -Password"
    case html = "text/html"
}

enum HTTPStatusCodes: Int {
    // 100 Informational
    case Continue = 100
    case SwitchingProtocols
    case Processing
    // 200 Success
    case OK = 200
    case Created = 201
    case Accepted
    case NonAuthoritativeInformation
    case NoContent
    case ResetContent
    case PartialContent
    case MultiStatus
    case AlreadyReported
    case IMUsed = 226
    // 300 Redirection
    case MultipleChoices = 300
    case MovedPermanently
    case Found
    case SeeOther
    case NotModified
    case UseProxy
    case SwitchProxy
    case TemporaryRedirect
    case PermanentRedirect
    // 400 Client Error
    case BadRequest = 400
    case Unauthorized
    case PasswordRequired
    case Forbidden
    case NotFound = 404
    case MethodNotAllowed
    case NotAcceptable
    case ProxyAuthenticationRequired
    case RequestTimeout
    case Conflict
    case Gone
    case LengthRequired
    case PreconditionFailed
    case PayloadTooLarge
    case URITooLong
    case UnsupportedMediaType
    case RangeNotSatisfiable
    case ExpectationFailed
    case ImATeapot
    case MisdirectedRequest = 421
    case UnprocessableEntity
    case Locked
    case FailedDependency
    case UpgradeRequired = 426
    case PreconditionRequired = 428
    case TooManyRequests
    case RequestHeaderFieldsTooLarge = 431
    case UnavailableForLegalReasons = 451
    // 500 Server Error
    case InternalServerError = 500
    case NotImplemented
    case BadGateway
    case ServiceUnavailable
    case GatewayTimeout
    case HTTPVersionNotSupported
    case VariantAlsoNegotiates
    case InsufficientStorage
    case LoopDetected
    case NotExtended = 510
    case NetworkAuthenticationRequired
}

enum HttpStatusCodeErrorType: Int {
    /// その他のステータスコードエラー
    case httpStatusCodeErrorTypeOther = 0
    /// 認証エラー 401/403
    case httpStatusCodeErrorTypeAuthenticationError
    /// 強制アップデート 415
    case httpStatusCodeErrorTypeForceUpdate
    /// 4xxその他エラー
    case httpStatusCodeErrorType4xxError
    /// メンテナンス 503
    case httpStatusCodeErrorTypeMaintenance
    /// 5xxその他エラー
    case httpStatusCodeErrorType5xxServerError
    /// HTTPステータスコードエラーではない(正常)
    case httpStatusCodeErrorTypeNone
}

