//
//  AudioFreeViewController.swift
//  HocVanChiHien
//
//  Created by ChacND_HAV on 4/11/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit

class AudioFreeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tableView : UITableView!
    var listAudio = [DataAudioFreeList]()

    override func viewDidLoad() {
        super.viewDidLoad()
        listAudio = DataManager.instance.listAudio?.listAudio ?? [DataAudioFreeList]()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: AudioTableViewCell.CELL_IDENTIFY, bundle: nil), forCellReuseIdentifier: AudioTableViewCell.CELL_IDENTIFY)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AudioTableViewCell.CELL_IDENTIFY, for: indexPath) as! AudioTableViewCell
        cell.setData(data: listAudio[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listAudio.count
    }

}
