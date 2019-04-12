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
//    var lastTouch = CGPoint(x: 0, y: 0)

    override func viewDidLoad() {
        super.viewDidLoad()
        listAudio = DataManager.instance.listAudio?.listAudio ?? [DataAudioFreeList]()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: AudioTableViewCell.CELL_IDENTIFY, bundle: nil), forCellReuseIdentifier: AudioTableViewCell.CELL_IDENTIFY)
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        lastTouch = touches.first?.location(in: self.view) ?? CGPoint(x: 0, y: 0)
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AudioTableViewCell.CELL_IDENTIFY, for: indexPath) as! AudioTableViewCell
        cell.setData(data: listAudio[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listAudio.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let viewController = UIStoryboard(name: Constant.storyMain, bundle: nil).instantiateViewController(withIdentifier: Constant.idViewController.idAudioTab.vcPlayer) as! AudioPlayerViewController
//        viewController.modalPresentationStyle = .overCurrentContext
//
        AudioManager.instance.nextSong = listAudio[indexPath.row]
        if let cell = tableView.cellForRow(at: indexPath) as? AudioTableViewCell {
            AudioManager.instance.avatar = cell.icon.image ?? UIImage(named: "Cho")!
        }
        if (self.tabBarController is MainTabBarViewController) {
            print("True")
        } else {
            print("False")
        }
        let cellRect = tableView.rectForRow(at: indexPath).origin
        let lastTouch = CGPoint(x: cellRect.x + self.view.bounds.width / 2, y: cellRect.y + 56/2 + 48)
        (self.tabBarController as? MainTabBarViewController)?.openPlayerFromPoint(position: lastTouch)
    }

}
