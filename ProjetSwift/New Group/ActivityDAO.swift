//
//  ActivityDAO.swift
//  ProjetSwift
//
//  Created by Maxime Soustelle on 14/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import Foundation

protocol ActivityDAO{
    func getAllActivities() -> [Activity]
    func getActivity() -> Activity
    func deleteActivity(activity: Activity) -> Bool
}
