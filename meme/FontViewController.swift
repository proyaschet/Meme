//
//  FontViewController.swift
//  meme
//
//  Created by Amarnath Manipatra on 16/03/17.
//  Copyright © 2017 otd. All rights reserved.
//

import UIKit
protocol PickFontProtocol{
    func updateFont(_ newFontValue:String)
}

class FontViewController: UIViewController , UITableViewDataSource , UITableViewDelegate {

    var currentFont: String?
    var newFont: String?
    var globalFont = UIFont.familyNames
    var checkIndex: IndexPath?
    var delegate: PickFontProtocol?
    
    @IBOutlet weak var tableView : UITableView!
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return globalFont.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FontPickCell", for: indexPath) as! FontTableViewCell
        cell.FontPick.text = globalFont[indexPath.row]
       
        cell.FontPick.font = UIFont(name: globalFont[indexPath.row], size: 20)
        if currentFont == globalFont[indexPath.row]
        {
            cell.accessoryType = .checkmark
            checkIndex = indexPath
        }
        else
        {
            cell.accessoryType = .none
        }
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if let cell = tableView.cellForRow(at: indexPath)
        {
            if cell.accessoryType == .none
            {
                cell.accessoryType = .checkmark
              
                
                newFont = globalFont[indexPath.row]
                
                delegate?.updateFont(newFont!)
                dismiss(animated: true, completion: nil)
            }
            else
            {
                delegate?.updateFont(currentFont!)
                dismiss(animated: true, completion: nil)
            }
        }
        
        
        
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }

}
