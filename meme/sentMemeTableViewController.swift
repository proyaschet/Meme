//
//  sentMemeTableViewController.swift
//  meme
//
//  Created by Amarnath Manipatra on 22/01/17.
//  Copyright © 2017 otd. All rights reserved.
//

import UIKit

class sentMemeTableViewController: UIViewController , UITableViewDataSource , UITableViewDelegate {

    
    
    @IBOutlet weak var tableView: UITableView!
    
    var memes : [Meme]! {
        return (UIApplication.shared.delegate as! AppDelegate).memes
        //return appDelegate.memes
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(memes.count)
        print((UIApplication.shared.delegate as! AppDelegate).memes.count)
        return memes.count
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            (UIApplication.shared.delegate as! AppDelegate).memes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sentMeme") as! TableViewCell
        
       cell.sentMemeImage?.image = memes[indexPath.row].memedImage
        cell.topCaption?.text = memes[indexPath.row].top
        cell.bottomCaption?.text = memes[indexPath.row].bottom
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "showMemeViewController") as! showMemeViewController
        detailController.mem = memes[(indexPath as NSIndexPath).row]
        detailController.pos = indexPath.row
        self.navigationController?.pushViewController(detailController, animated: true)
    }
  
    
 
    
    

   

}
