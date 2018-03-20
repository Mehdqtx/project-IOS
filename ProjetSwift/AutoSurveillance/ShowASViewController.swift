//
//  ShowASViewController.swift
//  ProjetSwift
//
//  Created by Maxime Soustelle on 20/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import UIKit

class ShowASViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    var autosurveillance : Autosurveillance? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let anAutosurveillance = self.autosurveillance{
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM ' à' hh' h 'mm"
            let dateString = formatter.string(from: anAutosurveillance.dateRDVNeurologue! as Date)
            self.dateLabel.text = dateString
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
