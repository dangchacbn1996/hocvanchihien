//
//  DemoWebViewViewController.swift
//  WeConnectIOS
//
//  Created by ChacND_HAV on 3/29/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
//import Firebase
import FirebaseStorage
import AVKit

class SavedListPosts: UIViewController, MainSubViewController, UITableViewDelegate, UITableViewDataSource{
    
    func searchResult(string: String) {
        if (string != "") {
            listShow = ListSaved()
            for item in listSaved.listSaved {
                if (ConvertHelper.convertVietNam(text: item.title).contains(ConvertHelper.convertVietNam(text: string))) {
                    listShow.listSaved.append(item)
                }
            }
            tableView.reloadData()
            return
        }
        listShow = listSaved
        tableView.reloadData()
    }
    
    @IBOutlet weak var tableView : UITableView!
    var listSaved = ListSaved()
    var listShow = ListSaved()
    var isPlayed = false
    let storage = Storage.storage()
    var playerItem : AVPlayerItem!
    var playerInstance : AVPlayer!
    var data : Data!
    var player : AVAudioPlayer!
    var url : URL?
    var mediaPlayer : AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton(frame: CGRect.zero)
        self.view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Play", for: UIControl.State.normal)
        button.backgroundColor = UIColor.brown
//        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(playVideo)))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[button]-16-|",
                                                                   options: NSLayoutConstraint.FormatOptions.alignAllTop,
                                                                   metrics: nil,
                                                                   views: ["button" : button]))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[button(16)]-|",
                                                                   options: NSLayoutConstraint.FormatOptions.alignAllLeft,
                                                                   metrics: nil,
                                                                   views: ["button" : button]))
        
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listShow.listSaved.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellSaved", for: indexPath) as! CellSaved
        cell.title.text = listShow.listSaved[indexPath.row].title
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0) {
            return
        }
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailContentVC") as! DetailContentViewController
        viewController.data = Option(href : "", title : listSaved.listSaved[indexPath.row].title, html : "", url : listShow.listSaved[indexPath.row].url)
        viewController.modalPresentationStyle = .overCurrentContext
        //        let file = "\(self.listOption[self.isSave].href.split(separator: "/").last ?? "").txt"
        self.present(viewController, animated: true, completion: nil)
    }
    
    @objc func removeWord(_ cell : UIButton){
        
    }
}

class CellSaved : UITableViewCell {
    @IBOutlet weak var title : UILabel!
    @IBOutlet weak var btnRemove : UIButton!
}
