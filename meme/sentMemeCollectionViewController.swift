//
//  sentMemeCollectionViewController.swift
//  meme
//
//  Created by Amarnath Manipatra on 23/01/17.
//  Copyright © 2017 otd. All rights reserved.
//

import UIKit

class sentMemeCollectionViewController: UICollectionViewController {

    
    @IBOutlet weak var flowLayout : UICollectionViewFlowLayout!
    
    var memes : [Meme]! {
        return (UIApplication.shared.delegate as! AppDelegate).memes
        //return appDelegate.memes
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let space:CGFloat = 3.0
        let width = (view.frame.size.width - (5 * space)) / 3.0
        let height = (view.frame.size.height - (5 * space)) / 3.0
        flowLayout.minimumInteritemSpacing = space
        flowLayout.itemSize = CGSize(width:width,height:height)
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.collectionView?.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print(memes.count)
        
        return self.memes.count
    }
    
    
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sentMemeCollectionViewCell", for: indexPath) as! sentMemeCollectionViewCell
       
        cell.sentImage?.image = memes[indexPath.row].memedImage
        
        return cell
        
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailvc = self.storyboard?.instantiateViewController(withIdentifier: "showMemeViewController") as! showMemeViewController
        
        detailvc.mem = memes[indexPath.row]
        detailvc.pos = indexPath.row
        self.navigationController?.pushViewController(detailvc, animated: true)
    }

   
    

   

}
