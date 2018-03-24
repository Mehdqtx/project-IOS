//
//  NewRdvViewController.swift
//  ProjetSwift
//
//  Created by Maxime Soustelle on 12/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import UIKit
import CoreData

class NewRdvViewController: UIViewController, UITextFieldDelegate {

    /*
    var pickedPraticien : String? = nil
    var pickerData: [String] = [String]()
    fileprivate lazy var praticiensFetched : NSFetchedResultsController<Praticien> = {
        let request : NSFetchRequest<Praticien> = Praticien.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(Praticien.nomPraticien), ascending: true)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil,cacheName: nil)
        fetchResultController.delegate = self
        return fetchResultController
    }()

    @IBOutlet weak var praticienPicker: UIPickerView!
    */
    @IBOutlet weak var addTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var pathTextField: UITextField!
    @IBOutlet weak var prepTextField: UITextField!
    
    var newRendezVous: RendezVous?
 
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        /*
        do{
            try self.praticiensFetched.performFetch()
        }
        catch let error as NSError{
            DialogBoxHelper.alert(view: self, error: error)
        }
        let praticiens : [Praticien]? = self.praticiensFetched.fetchedObjects
        for p in praticiens! {
            pickerData.append(p.nomPraticien!)
        }
        //pickerData = ["Jean", "Paul", "Martin"].sorted()
        if(pickerData.count > 0){
            pickedPraticien = pickerData[0]
        }
        */
        datePicker.minimumDate = Date()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    @IBAction func newPraticienAction(_ sender: Any) {
        guard (self.addTextField.text != "") else {
            DialogBoxHelper.alert(view: self, withTitle: "Champ Vide")
            return
        }
        pickerData.append(self.addTextField.text!)
        let praticien = Praticien(context: CoreDataManager.context)
        praticien.nomPraticien = self.addTextField.text
        praticienPicker.reloadAllComponents()
    }
    */
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        let praticien : String = self.addTextField.text ?? ""
        let path : String = self.pathTextField.text ?? ""
        let preparation : String = self.prepTextField.text ?? ""
        guard (praticien != "") && (path != "") && (preparation != "") else {
            DialogBoxHelper.alert(view: self, withTitle: "Champ(s) manquant(s)", andMessage: "Veuillez renseigner tous les champs.")
            return
        }
        let dateRDV = datePicker.date as NSDate?
        let formatter = DateFormatter()
        formatter.dateFormat = "mm"
        let prep = formatter.date(from: preparation) as NSDate?
        let trajet = formatter.date(from: path) as NSDate?
        self.newRendezVous = RendezVous(date: dateRDV!, prepDuration: prep!, travelDuration: trajet!, doctorName: praticien)
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Picker Management -
     // The number of columns of data
     func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
     }
     /*
     // The data to return for the row and component (column) that's being passed in
     func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
     }
     
     // The number of rows of data
     func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerData.count
     }
     
     // Catpure the picker view selection
     func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
     // This method is triggered whenever the user makes a change to the picker selection.
     // The parameter named row and component represents what was selected.
        if(pickerData.count > 0){
            self.pickedPraticien = pickerData[pickerView.selectedRow(inComponent: 0)]
        }
     }
    */
    // MARK: - TextFieldDelegate -
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
