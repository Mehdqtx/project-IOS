//
//  ShowInfoViewController.swift
//  ProjetSwift
//
//  Created by Maxime Soustelle on 23/02/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import UIKit
import CoreData

class ShowInfoViewController: UIViewController{

    //var info : [Information] = []
    var info : Information? = nil

    @IBOutlet weak var nomMedecin: UILabel!
    @IBOutlet weak var prenomMedecin: UILabel!
    @IBOutlet weak var informations: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Get Context
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            print("Erreur")
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        // Create request for information
        let request : NSFetchRequest<Information> = Information.fetchRequest()
        do{
            let requestSize : Int = try context.fetch(request).count
            // If we already have existing information
            if requestSize > 0{
                try self.info = context.fetch(request)[context.fetch(request).count-1]
            }
            else{}
        }
        catch let error as NSError{
            print(error)
            return
        }
        // Set the labels
        self.nomMedecin.text = self.info?.nomMedecin
        self.prenomMedecin.text = self.info?.prenomMedecin
        self.informations.text = self.info?.info
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Saving
    func saveInfo(withFirstName : String, andLastName : String, andInfo : String){
        // Get Context
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            print("Erreur")
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        // Create object
        let information = Information(context: context)
        // Update values
        information.nomMedecin = andLastName
        information.prenomMedecin = withFirstName
        information.info = andInfo
        // Save context
        do{
            try context.save()
            self.info = information
        }
        catch let error as NSError{
            print(error)
            return
        }
    }
    
    // MARK: - Navigation
    @IBAction func unwindToInfoAfterEditInfo(segue: UIStoryboardSegue){
        let editInfoController = segue.source as! EditInfoViewController
        let nomMedecin = editInfoController.doctorLastName.text ?? ""
        let prenomMedecin = editInfoController.doctorFirstName.text ?? ""
        let info = editInfoController.informations.text ?? ""
        self.saveInfo(withFirstName: prenomMedecin, andLastName: nomMedecin, andInfo: info)
        self.nomMedecin.text = self.info?.nomMedecin
        self.prenomMedecin.text = self.info?.prenomMedecin
        self.informations.text = self.info?.info
    }
    
    let segueEditInfoId = "editInfo"
    // Giving actual informations to show it in the text fields
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == self.segueEditInfoId{
            let editInfoViewController = segue.destination as! EditInfoViewController
            editInfoViewController.information = self.info
        }
    }
    
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
