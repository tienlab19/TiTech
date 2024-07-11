//
//  DataManager.swift
//  TiTech
//
//  Created by Apple on 9/7/24.
//

import Foundation

class DataManager {
    static let shared = DataManager.init()
    
    var accessToken = ""
    var chatGPTapiKey = ""
}
