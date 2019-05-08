//
//  GameMainViewController.swift
//  HocVanChiHien
//
//  Created by DC on 5/1/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit

class GameMainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    static let ID_Identify = "GameMainViewController"
    
    @IBOutlet weak var collectionView : UICollectionView!
    var  size : CGFloat = 50
    var delegate : GameQuizDelegate!
    
//    var delegate : 

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        //        collectionView.collectionViewLayout.flow
        collectionView.register(UINib(nibName: CellQuizCVC.NIB_NAME, bundle: nil), forCellWithReuseIdentifier: CellQuizCVC.NIB_NAME)
        // Do any additional setup after loading the view.
    }

    override func viewWillLayoutSubviews() {
        size = self.collectionView.bounds.width * 0.5 - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return delegate.getQuesData().count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        let cell = collectionView.cellForItem(at: indexPath) as! CellQuizCVC
        //        cell.viewContainer.selec
//        Toast.shared.makeToast(string: listQues.listSubject?[indexPath.item].title ?? "Non", inView: self.view)
        delegate.openQues(index: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellQuizCVC.NIB_NAME, for: indexPath) as! CellQuizCVC
        cell.lbContent.text = delegate.getQuesData()[indexPath.item].title ?? "NoSub"
        return cell
    }
    
}
