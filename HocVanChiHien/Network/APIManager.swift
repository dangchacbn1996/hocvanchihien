//
//  APIManagerTransfer.swift
//  DerivativeIOS
//
//  Created by DC on 1/22/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

@objc protocol APIManagerProtocol {
    func apiOnDidFail(mess : String)
    @objc optional func apiOnGetUserInfoDone(data : ModelUserInfo)
    @objc optional func apiOnUpdateAuthInfoDone(data : ModelUpdateAuthInfo)
    @objc optional func apiOnGetAudioListDone(data : ModelAudioFreeList)
}

public class APIManager {
    static func getUserInfo(callBack: APIManagerProtocol, userID: String) {
        Alamofire.request(API.apiCore + API.apiGetUserInfo,
                          method: HTTPMethod.post,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: ["userID":userID])
            .responseJSON{
                response in
                switch response.result {
                case .success:
                    readData(callBack: callBack, data: response.data!, modelType: ModelUserInfo.self, completion: { (Decodable) -> (Void) in
                        callBack.apiOnGetUserInfoDone!(data : Decodable)
                    })
                case .failure:
                    callBack.apiOnDidFail(mess: "Error: \(String(describing: response.description))")
                }
        }
    }
    
    static func updateAuthData(callBack: APIManagerProtocol, userID: String, name : String, phone : String) {
        let param = ["userID" : userID,
                     "userName" : name,
                     "userPhone" : phone]
        Alamofire.request(API.apiCore + API.apiCreateNewAuth,
                          method: HTTPMethod.post,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: param)
            .responseJSON{
                response in
                switch response.result {
                case .success:
                    readData(callBack: callBack, data: response.data!, modelType: ModelUpdateAuthInfo.self, completion: { (Decodable) -> (Void) in
                        callBack.apiOnUpdateAuthInfoDone!(data : Decodable)
                    })
                case .failure:
                    callBack.apiOnDidFail(mess: "Error: \(String(describing: response.description))")
                }
        }
    }
    
    static func getAudioList(callBack: APIManagerProtocol) {
        Alamofire.request(API.apiCore + API.apiGetAudioList,
                          method: HTTPMethod.post,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: [:])
            .responseJSON{
                response in
                switch response.result {
                case .success:
                    do {
                        let responseEx = try JSONDecoder().decode([DataAudioFreeList].self, from: response.data!)
                        callBack.apiOnGetAudioListDone?(data: ModelAudioFreeList(data: responseEx))
                    } catch let error {
                        print("Error: Decode: \(error)")
                        callBack.apiOnDidFail(mess: "Error: Có lỗi xảy ra")
                    }
                case .failure:
                    callBack.apiOnDidFail(mess: "Error: \(String(describing: response.description))")
                }
        }
    }
}

extension APIManager {
    
    static func base64Encode(string : String) -> (String) {
        let utf8str = string.data(using: String.Encoding.utf8)
        let base64Encoded = utf8str!.base64EncodedString()
        return base64Encoded
    }
    
    static func readData<T: Decodable>(callBack : APIManagerProtocol, data: Data, modelType: T.Type, completion : (T) -> (Void)) {
        do {
            let responseEx = try JSONDecoder().decode(modelType, from: data)
            completion(responseEx)
        } catch let error {
            print("Error: Decode: \(error)")
            callBack.apiOnDidFail(mess: "Error: Có lỗi xảy ra")
        }
    }
}

enum TransferType : String{
    case INTERNAL = "INTERNAL"
    case VPBANK = "VPBANK"
    case CITAD = "CITAD"
    case NAPAS = "NAPAS"
}

enum SelAccountType : String{
    case TOCARD = "TOCARD"
    case TOACCOUNT = "TOACCOUNT"
}

enum VAccountType : String {
    case VPBANK = "VPBANK"
    case BANK = "BANK"
    case OTHER = "OTHER"
    case INNER = "INNER"
}
