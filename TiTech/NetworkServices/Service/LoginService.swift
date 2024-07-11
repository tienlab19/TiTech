//
//  TinvayService.swift
//  tinvay
//
//  Created by Apple on 27/6/24.
//

import Foundation
import FirebaseAuth
import FirebaseCore
import UIKit

protocol LoginServiceProtocols {
    func login(username: String, password: String, completion: @escaping (Bool) -> Void)
}

class LoginService: LoginServiceProtocols {
    let service = BaseService.shared
    
    func login(username: String,
               password: String,
               completion: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: username, password: password) { authResult, error in
            if error != nil {
                completion(false)
            } else {
                completion(true)
            }
        }
    }
}
