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
        Loading.sharedInstance.dismiss()
    }
    
    func apiOnGetUserInfoDone(data: ModelUserInfo) {
        print("DataLogin: \(data.audioPermission)")
        print("DataLogin: \(data.name)")
        print("DataLogin: \(data.phone)")
        DataManager.instance.userInfo = data
        if (loadDone) {
            Loading.sharedInstance.dismiss()
            enterMain()
        } else {
            loadDone = true
        }
    }
    
    func apiOnGetAudioListDone(data: ModelAudioFreeList) {
        DataManager.instance.listAudio = data
        if (loadDone) {
            Loading.sharedInstance.dismiss()
            enterMain()
        } else {
            loadDone = true
        }
    }
    
    @IBOutlet weak var tfUserName : UITextField!
    @IBOutlet weak var tfPassword : UITextField!
    var loadDone = false

    override func viewDidLoad() {
        super.viewDidLoad()
        tfUserName.text = "dangchacbn1996@gmail.com"
        tfPassword.text = "dangchac"
        let queue = DispatchQueue(label: "loadListFreeAudio")
        queue.async {
            APIManager.getAudioList(callBack: self)
        }
    }
    
    func enterMain() {
        let viewController = UIStoryboard(name: Constant.storyMain, bundle: nil).instantiateViewController(withIdentifier: Constant.idViewController.vcMain)
        self.navigationController?.pushViewController(viewController, animated: true)
//        (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController = viewController
    }
    
    
    @IBAction func loginView(_ button : UIButton){
        self.view.endEditing(true)
        Loading.sharedInstance.show(in: self.view)
        let email = tfUserName.text ?? ""
        let password = tfPassword.text ?? ""
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
            guard self != nil else {
                Toast.shared.makeToast(string: "Sai tài khoản!", inView: self!.view)
                Loading.sharedInstance.dismiss()
                return
            }
            guard error == nil else {
                let errorCode = (error as NSError?)?.code
                print("AccInfo: \(errorCode) | \(error!.localizedDescription ?? "")")
                Loading.sharedInstance.dismiss()
                Toast.shared.makeToast(string: errorCode == nil ? error!.localizedDescription : FirebaseConstant.checkCodeError(code: errorCode!), inView: self!.view)
                return
            }
            if let userInfo = user?.user {
                print("AccInfo: \(userInfo.uid)")
                print("AccInfo: \(userInfo.email)")
                print("AccInfo: -----------------")
                DataManager.instance.userID = userInfo.uid ?? ""
                DataManager.instance.userEmail = userInfo.email ?? ""
                APIManager.getUserInfo(callBack: self!, userID: userInfo.uid)
            }
        }
    }

}
