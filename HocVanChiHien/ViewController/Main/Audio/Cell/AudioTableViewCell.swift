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
    
    func setData(data : DataAudioFreeList) {
        //        Alamofire.request(.GET, data.audioUrl ?? "").response { (request, response, data, error) in
        //            self.myImageView.image = UIImage(data: data, scale:1)
        //        }
//        Alamofire.request(URL(string: data.audioImage ?? "")!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseData { (response) in
//            self.icon._imageIcon = UIImage(data: response.data ?? Data(), scale: 1) ?? UIImage()
//        }
        print("AudioURL: \(data.audioImage ?? "")")
        icon.downloaded(from: URL(string: data.audioImage ?? "")!)
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
