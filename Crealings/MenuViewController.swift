//
//  MenuViewController.swift
//  Crealings
//
//  Created by Amber Miller on 3/26/15.
//  Copyright (c) 2015 Amber Miller. All rights reserved.
//

import Foundation
import UIKit

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var musicImage: UIImageView!
    @IBOutlet weak var soundsImage: UIImageView!
    
    @IBOutlet weak var statsTable: UITableView!
    
    @IBOutlet weak var musicSwitch: UISwitch!
    @IBOutlet weak var soundsSwitch: UISwitch!
    @IBOutlet weak var resetGameButton: UIButton!
    
    @IBOutlet weak var statsTab: UIButton!
    @IBOutlet weak var settingsTab: UIButton!
    
    let gameData = GameData.sharedInstance;
    var statsArray = [];
    
    override func viewDidLoad() {
        gameData.loadData();
        statsArray = gameData.getStatsArray();
        
        statsTable.hidden = false;
        
        musicImage.hidden = true;
        soundsImage.hidden = true;
        musicSwitch.hidden = true;
        soundsSwitch.hidden = true;
        resetGameButton.hidden = true;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statsArray.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as? UITableViewCell;
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "cell")
        }
        
        let item: AnyObject = statsArray[indexPath.row];
        
        let name: String = item["name"] as String;
        let value: Int = item["value"] as Int;
        cell!.textLabel?.text = "\(name) \(value)";
        cell?.textLabel?.textColor = UIColor.whiteColor();
        cell?.textLabel?.font = UIFont(name: "LilitaOne-Regular", size: 24.0);
        cell?.backgroundColor = UIColor.clearColor();
        
        return cell!;
    }
    
    @IBAction func backButtonTapped(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    @IBAction func musicSwitched(sender: UISwitch) {
    }
    
    
    @IBAction func soundsSwitched(sender: UISwitch) {
    }
    
    @IBAction func resetGame(sender: UIButton) {
        var refreshAlert = UIAlertController(title: "Reset Game?", message: "All data will be lost.", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            let defaults = NSUserDefaults.standardUserDefaults();
            defaults.setBool(true, forKey: "resetGame");
            self.dismissViewControllerAnimated(true, completion: nil);
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
            println("Reset Cancelelled")
        }))
        
        presentViewController(refreshAlert, animated: true, completion: nil)
    }
    
    @IBAction func statsTabTapped(sender: UIButton) {
        titleImage.image = UIImage(named: "statistics");
        statsTab.imageView?.image = UIImage(named: "stats_tab_selected");
        settingsTab.imageView?.image = UIImage(named: "settings_tab");
        
        statsTable.hidden = false;
        
        musicImage.hidden = true;
        soundsImage.hidden = true;
        musicSwitch.hidden = true;
        soundsSwitch.hidden = true;
        resetGameButton.hidden = true;
    }
    
    @IBAction func settingsTabTapped(sender: UIButton) {
        titleImage.image = UIImage(named: "settings");
        statsTab.imageView?.image = UIImage(named: "stats_tab");
        settingsTab.imageView?.image = UIImage(named: "settings_tab_selected");
        
        statsTable.hidden = true;
        
        musicImage.hidden = true;
        soundsImage.hidden = true;
        musicSwitch.hidden = true;
        soundsSwitch.hidden = true;
        resetGameButton.hidden = false;
    }
    
    
}