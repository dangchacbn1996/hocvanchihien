//
//  MainAudioViewController.swift
//  HocVanChiHien
//
//  Created by DC on 4/11/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit

class MainAudioViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let viewController = UIStoryboard(name: Constant.storyMain, bundle: nil).instantiateViewController(withIdentifier: Constant.idViewController.idAudioTab.vcListFree)
        self.view.addSubview(viewController.view)
        viewController.view.frame = self.view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.didMove(toParent: self)
        self.addChild(viewController)
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
