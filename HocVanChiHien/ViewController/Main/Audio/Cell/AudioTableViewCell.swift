//
//  AudioFreeTableViewCell.swift
//  HocVanChiHien
//
//  Created by ChacND_HAV on 4/11/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import Alamofire

class AudioTableViewCell: UITableViewCell {
    static let CELL_IDENTIFY = "AudioTableViewCell"
    @IBOutlet weak var icon : CustomImageView!
    @IBOutlet weak var lbTitle : UILabel!
    @IBOutlet weak var btnMore : UIButton!
//    @IBOutlet weak var actionMore: UITapGestureRecognizer!
    
    func setData(data : DataAudioFreeList) {
        print("AudioURL: \(data.audioImage ?? "")")
        if (data.audioImage != nil) {
            if let url = URL(string: data.audioImage!) {
                icon.downloaded(from: url)
            }
        }
        lbTitle.text = data.audioName
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
