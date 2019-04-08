//
//  DemoWebViewViewController.swift
//  WeConnectIOS
//
//  Created by ChacND_HAV on 3/29/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit

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
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        if let savedList = UserDefaults.standard.object(forKey: "list_post_saved") as? Data {
            let decoder = JSONDecoder()
            if let loadedList : ListSaved = try? decoder.decode(ListSaved.self, from: savedList) {
                listSaved = loadedList
                listShow = listSaved
                tableView.reloadData()
            }
        }
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
