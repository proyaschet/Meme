//
//  showMemeViewController.swift
//  meme
//
//  Created by Amarnath Manipatra on 23/01/17.
//  Copyright © 2017 otd. All rights reserved.
//

import UIKit

class showMemeViewController: UIViewController {
    
    
    
    var mem : Meme?
    var pos : Int?
    
    
    @IBOutlet weak var memedImage : UIImageView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        memedImage.image = mem?.memedImage
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "edit"
        {
            let vc = segue.destination as! ViewController
            vc.position = pos
            vc.originalImage = mem?.originalImage;
            vc.editPic = true
            
        }
        
    }
    
    

  

}
