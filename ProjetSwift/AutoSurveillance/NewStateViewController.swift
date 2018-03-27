//
//  NewStateViewController.swift
//  ProjetSwift
//
//  Created by Maxime Soustelle on 20/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import UIKit

class NewStateViewController: UIViewController {

    @IBOutlet weak var onSwitch: UISwitch!
    @IBOutlet weak var offSwitch: UISwitch!
    @IBOutlet weak var dyskSwitch: UISwitch!
    var autosurveillance : Autosurveillance? = nil
    var newEtat: Etat?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onAction(_ sender: Any) {
        self.offSwitch.setOn(false, animated: true)
        self.dyskSwitch.setOn(false, animated: true)
    }
    @IBAction func offAction(_ sender: Any) {
        self.onSwitch.setOn(false, animated: true)
        self.dyskSwitch.setOn(false, animated: true)
    }
    @IBAction func dyskAction(_ sender: Any) {
        self.offSwitch.setOn(false, animated: true)
        self.onSwitch.setOn(false, animated: true)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func saveAction(_ sender: Any) {
        let switchSelected : String
        if onSwitch.isOn{
            switchSelected = "ON"
        }
        else if offSwitch.isOn{
            switchSelected = "OFF"
        }
        else{
            switchSelected = "DYSK"
        }
        self.newEtat = Etat(date: Date() as NSDate, nom: switchSelected, autos: self.autosurveillance!)
        self.dismiss(animated: true, completion: nil)
    }
}
