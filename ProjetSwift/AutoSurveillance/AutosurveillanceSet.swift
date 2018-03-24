//
//  AutosurveillanceSet.swift
//  ProjetSwift
//
//  Created by Maxime Soustelle on 24/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import Foundation
import CoreData

/// Set of Autosurveillance
///
/// *add*: `AutosurveillanceSet` x `Autosurveillance` -> `Autosurveillance` -- add a `Autosurveillance` to the collection
///
/// *remove*: `AutosurveillanceSet` x `Autosurveillance` -> `AutosurveillanceSet` -- remove a `Autosurveillance` from the collection
///
/// *count*: `AutosurveillanceSet` -> `Int` -- number of `Autosurveillance` in the collection
///
/// *createIterator*: returns an iterator on collection
///

class AutosurveillanceSet : Sequence{
    
    var count: Int{
        return AutosurveillanceDAO.count
    }
    
    @discardableResult
    func add(autosurveillance: Autosurveillance) -> AutosurveillanceSet{
        AutosurveillanceDAO.save()
        return self
    }
    
    @discardableResult
    func remove(autosurveillance: Autosurveillance) -> AutosurveillanceSet{
        AutosurveillanceDAO.delete(autosurveillance: autosurveillance)
        AutosurveillanceDAO.save()
        return self
    }
    
    
    subscript(index: Int) -> Autosurveillance{
        get{
            guard let set = AutosurveillanceDAO.fetchAll() else { fatalError("cannot fetch data") }
            guard (index>=0) && (index<set.count) else{ fatalError("index out of range") }
            return set[index]
        }
        set{
            guard var set = AutosurveillanceDAO.fetchAll() else { fatalError("cannot fetch data") }
            guard (index>=0) && (index<set.count) else{ fatalError("index out of range") }
            AutosurveillanceDAO.delete(autosurveillance: set[index])
            set[index]  = newValue
            AutosurveillanceDAO.save()
        }
    }
    
    func makeIterator() -> ItAutosurveillanceSet{
        return ItAutosurveillanceSet(self)
    }
    
}

// MARK: -

struct ItAutosurveillanceSet : IteratorProtocol{
    private var current: Int = 0
    private let set: [Autosurveillance]
    
    fileprivate init(_ s: AutosurveillanceSet){
        if let set = AutosurveillanceDAO.fetchAll(){
            self.set = set
        }
        else{
            self.set = []
        }
    }
    
    /// reset iterator
    ///
    /// - Returns: iterator reseted
    @discardableResult
    mutating func reset() -> ItAutosurveillanceSet{
        self.current = 0
        return self
    }
    
    @discardableResult
    mutating func next() -> Autosurveillance? {
        guard self.current < self.set.count else{
            return nil
        }
        let nextAutosurveillance = self.set[self.current]
        self.current += 1
        return nextAutosurveillance
    }
    
    /// true if iterator as finished
    var end : Bool{
        return self.current < self.set.count
    }
}
