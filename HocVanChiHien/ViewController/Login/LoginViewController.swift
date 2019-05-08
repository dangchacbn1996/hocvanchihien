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
        DataManager.instance.userInfo = data
        DataManager.instance.userInfo = data
        if (DataManager.instance.listAudio != nil && DataManager.instance.listQues != nil) {
            Loading.sharedInstance.dismiss()
            enterMain()
        }
    }
    
    func apiOnGetAudioListDone(data: ModelAudioFreeList) {
        DataManager.instance.listAudio = data
        if (DataManager.instance.userInfo != nil && DataManager.instance.listQues != nil) {
            Loading.sharedInstance.dismiss()
            enterMain()
        }
    }
    
    func apiOnGetListQuesDone(data : [SubModelQuiz]){
        DataManager.instance.listQues = data
        if (DataManager.instance.userInfo != nil && DataManager.instance.listAudio != nil) {
            Loading.sharedInstance.dismiss()
            enterMain()
        }
    }
    
    @IBOutlet weak var tfUserName : UITextField!
    @IBOutlet weak var tfPassword : UITextField!
    var loadDone = false

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let queue = DispatchQueue(label: "loadListFreeAudio")
        queue.async {
            APIManager.getAudioList(callBack: self)
        }
        let queueQues = DispatchQueue(label: "loadListQues")
        queueQues.async {
            APIManager.getListQues(callBack: self)
        }
    }
    
    func enterMain() {
        let viewController = UIStoryboard(name: Constant.storyMain, bundle: nil).instantiateViewController(withIdentifier: Constant.idViewController.vcMain)
        self.navigationController?.pushViewController(viewController, animated: true)
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
