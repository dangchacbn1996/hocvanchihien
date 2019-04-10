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
    @objc optional func apiOnGetUserInfoDone(data : UserInfoModel)
}

public class APIManager {
    static func getUserInfo(callBack: APIManagerProtocol, userID: String) {
        
//        let param = RequestManager.loadData(group: "B",
//                                            user: user,
//                                            session: sid,
//                                            type: "cursor",
//                                            cmd: "GetAllBankOnline",
//                                            p1: "", p2: "", p3: "", p4: "")
        
        Alamofire.request(API.apiCore + API.apiGetUserInfo,
                          method: HTTPMethod.post,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: ["userID":userID])
            .responseJSON{
                response in
                switch response.result {
                case .success:
                    readData(callBack: callBack, data: response.data!, modelType: UserInfoModel.self, completion: { (Decodable) -> (Void) in
                        callBack.apiOnGetUserInfoDone!(data : Decodable)
                    })
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
        } catch {
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
