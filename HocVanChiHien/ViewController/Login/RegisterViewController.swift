//
//  RegisterViewController.swift
//  HocVanChiHien
//
//  Created by ChacND_HAV on 4/11/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController, APIManagerProtocol{
    
    @IBOutlet weak var tfUsername : UITextField!
    @IBOutlet weak var tfPass : UITextField!
    @IBOutlet weak var tfComfirmPass : UITextField!
    @IBOutlet weak var tfName : UITextField!
    @IBOutlet weak var tfPhone : UITextField!
    
    func apiOnDidFail(mess: String) {
        Toast.shared.makeToast(string: mess, inView: self.view)
        Loading.sharedInstance.dismiss()
    }
    
    func apiOnUpdateAuthInfoDone(data: ModelUpdateAuthInfo) {
        Loading.sharedInstance.dismiss()
        let viewController = UIStoryboard(name: Constant.storyLogin, bundle: nil).instantiateViewController(withIdentifier: Constant.idLoginViewController.vcLogin)
        self.present(viewController, animated: true) {
            Toast.shared.makeToast(string: "Tạo tài khoản thành công rồi ^^\nThử đăng nhập lần đầu nhé", inView: viewController.view)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tfUsername.text = "dangchacbn196@gmail.com"
        tfPhone.text = "0989864537"
        tfName.text = "Dang Chac"
        tfPass.text = "dangchac"
        tfComfirmPass.text = "dangchac"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerNewAccount(_ button : UIButton){
        self.view.endEditing(true)
        let email = tfUsername.text ?? ""
        let pass = tfPass.text ?? ""
        let passConfirm = tfComfirmPass.text ?? ""
        let name = tfName.text ?? ""
        let phone = tfPhone.text ?? ""
        if (email == "" ||
            pass == "" ||
            passConfirm == "" ||
            name == "" ||
            phone == "") {
            Toast.shared.makeToast(string: "Nhập đầy đủ thông tin giúp chị nhé!", inView: self.view)
            return
        }
        if (pass != passConfirm) {
            Toast.shared.makeToast(string: "2 mật khẩu phải giống nhau nhé!", inView: self.view)
            return
        }
        Loading.sharedInstance.show(in: self.view)
        Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
            guard error == nil else {
                let errorCode = (error as NSError?)?.code
                Loading.sharedInstance.dismiss()
                Toast.shared.makeToast(string: errorCode == nil ? error?.localizedDescription ?? "" : FirebaseConstant.checkCodeError(code: errorCode!), inView: self.view)
                return
            }
            if let userID = user?.user.uid {
                APIManager.updateAuthData(callBack: self, userID: userID, name: name, phone: phone)
            } else {
                Toast.shared.makeToast(string: "Server của chị đang lỗi mất rồi! Liên lạc với chị nhé ^^", inView: self.view)
                Loading.sharedInstance.dismiss()
            }
        }
        
//        let email = tfUserName.text ?? ""
//        let password = tfPassword.text ?? ""
//        Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
//            guard let strongSelf = self else {
//                Toast.shared.makeToast(string: "Sai tài khoản!", inView: self!.view)
//                Loading.sharedInstance.dismiss()
//                return
//            }
//            guard error == nil else {
//                print("AccInfo: \(error?.localizedDescription)")
//                Loading.sharedInstance.dismiss()
//                Toast.shared.makeToast(string: error?.localizedDescription ?? "", inView: self!.view)
//                return
//            }
//            if let userInfo = user?.user {
//                print("AccInfo: \(userInfo.uid)")
//                print("AccInfo: \(userInfo.email)")
//                print("AccInfo: -----------------")
//                APIManager.getUserInfo(callBack: self!, userID: userInfo.uid)
//            }
//        }
    }
}
