//
//  LoginViewController.swift
//  HocVanChiHien
//
//  Created by DC on 4/9/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, APIManagerProtocol{
    func apiOnDidFail(mess: String) {
        Toast.shared.makeToast(string: mess, inView: self.view)
    }
    
    func apiOnGetUserInfoDone(data: UserInfoModel) {
        print("DataLogin: \(data.audioPermission)")
        print("DataLogin: \(data.name)")
        print("DataLogin: \(data.phone)")
        let viewController = UIStoryboard(name: Constant.storyMain, bundle: nil).instantiateViewController(withIdentifier: Constant.idViewController.vcMain)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBOutlet weak var tfUserName : UITextField!
    @IBOutlet weak var tfPassword : UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        tfUserName.text = "dangchacbn1996@gmail.com"
        tfPassword.text = "dangchac"
    }
    
    @IBAction func loginView(_ button : UIButton){
        self.view.endEditing(true)
        let email = tfUserName.text ?? ""
        let password = tfPassword.text ?? ""
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
            guard let strongSelf = self else {
                Toast.shared.makeToast(string: "Sai tài khoản!", inView: self!.view)
                return
            }
            guard error == nil else {
                print("AccInfo: \(error?.localizedDescription)")
                Toast.shared.makeToast(string: error?.localizedDescription ?? "", inView: self!.view)
                return
            }
            if let userInfo = user?.user {
                print("AccInfo: \(userInfo.uid)")
                print("AccInfo: \(userInfo.email)")
                print("AccInfo: -----------------")
                APIManager.getUserInfo(callBack: self!, userID: userInfo.uid)
            }
        }
    }

}
