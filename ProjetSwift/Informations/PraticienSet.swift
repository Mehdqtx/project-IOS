//
//  PraticienSet.swift
//  ProjetSwift
//
//  Created by Maxime Soustelle on 24/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import Foundation
import CoreData

/// Set of Praticien
///
/// *add*: `PraticienSet` x `Praticien` -> `Praticien` -- add a `Praticien` to the collection
///
/// *remove*: `PraticienSet` x `Praticien` -> `PraticienSet` -- remove a `Praticien` from the collection
///
/// *count*: `PraticienSet` -> `Int` -- number of `Praticien` in the collection
///
/// *createIterator*: returns an iterator on collection
///

class PraticienSet : Sequence{
    
    var count: Int{
        return PraticienDAO.count
    }
    
    @discardableResult
    func add(activity: Praticien) -> PraticienSet{
        PraticienDAO.save()
        return self
    }
    
    @discardableResult
    func remove(prt: Praticien) -> PraticienSet{
        PraticienDAO.delete(prt: prt)
        PraticienDAO.save()
        return self
    }
    
    
    subscript(index: Int) -> Praticien{
        get{
            guard let set = PraticienDAO.fetchAll() else { fatalError("cannot fetch data") }
            guard (index>=0) && (index<set.count) else{ fatalError("index out of range") }
            return set[index]
        }
        set{
            guard var set = PraticienDAO.fetchAll() else { fatalError("cannot fetch data") }
            guard (index>=0) && (index<set.count) else{ fatalError("index out of range") }
            PraticienDAO.delete(prt: set[index])
            set[index]  = newValue
            PraticienDAO.save()
        }
    }
    
    func makeIterator() -> ItPraticienSet{
        return ItPraticienSet(self)
    }
    
}

// MARK: -

struct ItPraticienSet : IteratorProtocol{
    private var current: Int = 0
    private let set: [Praticien]
    
    fileprivate init(_ s: PraticienSet){
        if let set = PraticienDAO.fetchAll(){
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
    mutating func reset() -> ItPraticienSet{
        self.current = 0
        return self
    }
    
    @discardableResult
    mutating func next() -> Praticien? {
        guard self.current < self.set.count else{
            return nil
        }
        let nextPraticien = self.set[self.current]
        self.current += 1
        return nextPraticien
    }
    
    /// true if iterator as finished
    var end : Bool{
        return self.current < self.set.count
    }
}
