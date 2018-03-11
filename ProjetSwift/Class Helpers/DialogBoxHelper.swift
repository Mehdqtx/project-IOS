//
//  DialogBoxHelper.swift
//  ProjetSwift
//
//  Created by Maxime Soustelle on 11/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import Foundation
import UIKit

class DialogBoxHelper {
    class func alert(view: UIViewController, withTitle title: String, andMessage msg: String = ""){
        let alert = UIAlertController(title: title, message: msg,preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(cancelAction)
        view.present(alert, animated: true)
    }
    
    class func alert(view: UIViewController, error: NSError){
        self.alert(view: view, withTitle: "\(error)", andMessage: "\(error.userInfo)")
    }
}
