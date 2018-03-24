//
//  EtatSet.swift
//  ProjetSwift
//
//  Created by Maxime Soustelle on 24/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import Foundation
import CoreData

/// Set of Etat
///
/// *add*: `EtatSet` x `Etat` -> `Etat` -- add a `Etat` to the collection
///
/// *remove*: `EtatSet` x `Etat` -> `EtatSet` -- remove a `Etat` from the collection
///
/// *count*: `EtatSet` -> `Int` -- number of `Etat` in the collection
///
/// *createIterator*: returns an iterator on collection
///

class EtatSet : Sequence{
    
    var count: Int{
        return EtatDAO.count
    }
    
    @discardableResult
    func add(etat: Etat) -> EtatSet{
        EtatDAO.save()
        return self
    }
    
    @discardableResult
    func remove(etat: Etat) -> EtatSet{
        EtatDAO.delete(etat: etat)
        EtatDAO.save()
        return self
    }
    
    
    subscript(index: Int) -> Etat{
        get{
            guard let set = EtatDAO.fetchAll() else { fatalError("cannot fetch data") }
            guard (index>=0) && (index<set.count) else{ fatalError("index out of range") }
            return set[index]
        }
        set{
            guard var set = EtatDAO.fetchAll() else { fatalError("cannot fetch data") }
            guard (index>=0) && (index<set.count) else{ fatalError("index out of range") }
            EtatDAO.delete(etat: set[index])
            set[index]  = newValue
            EtatDAO.save()
        }
    }
    
    func makeIterator() -> ItEtatSet{
        return ItEtatSet(self)
    }
    
}

// MARK: -

struct ItEtatSet : IteratorProtocol{
    private var current: Int = 0
    private let set: [Etat]
    
    fileprivate init(_ s: EtatSet){
        if let set = EtatDAO.fetchAll(){
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
    mutating func reset() -> ItEtatSet{
        self.current = 0
        return self
    }
    
    @discardableResult
    mutating func next() -> Etat? {
        guard self.current < self.set.count else{
            return nil
        }
        let nextEtat = self.set[self.current]
        self.current += 1
        return nextEtat
    }
    
    /// true if iterator as finished
    var end : Bool{
        return self.current < self.set.count
    }
}
