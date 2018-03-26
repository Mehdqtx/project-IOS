//
//  ShowSynthesePilulierViewController.swift
//  ProjetSwift
//
//  Created by java on 26/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import UIKit
import CoreData

class ShowSynthesePilulierViewController:UIViewController,UITableViewDataSource, UITableViewDelegate,NSFetchedResultsControllerDelegate{
    
    var prises:[PriseReelle]? = nil
    
    @IBOutlet var pilulierPresenter: SynthesePilulierPresenter!
    
    @IBOutlet weak var pilulierTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Load context
        
        super.viewDidLoad()
        
        do{
            prises = try PriseReelle.getAllPrisesValider()
        }
        catch let error as NSError{
            DialogBoxHelper.alert(view: self, error: error)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (prises?.count)!
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "pilulierCell", for: indexPath) as! SynthesePilulierTableViewCell
        self.pilulierPresenter.configure(theCell: cell, forPrise: prises?[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
