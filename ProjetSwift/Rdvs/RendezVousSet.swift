//
//  RendezVousSet.swift
//  ProjetSwift
//
//  Created by Maxime Soustelle on 23/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import Foundation
import CoreData

/// Set of RendezVous
///
/// *add*: `RendezVousSet` x `RendezVous` -> `RendezVous` -- add a `RendezVous` to the collection
///
/// *remove*: `RendezVousSet` x `RendezVous` -> `RendezVousSet` -- remove a `RendezVous` from the collection
///
/// *getSize*: `RendezVousSet` -> `Int` -- number of `RendezVous` in the collection
///
/// *createIterator*: returns an iterator on collection
///

class RendezVousSet : Sequence{
    
    var count: Int{
        return RendezVousDAO.count
    }
    
    @discardableResult
    func add(rdv: RendezVous) -> RendezVousSet{
        RendezVousDAO.save()
        return self
    }
    
    @discardableResult
    func remove(rdv: RendezVous) -> RendezVousSet{
        RendezVousDAO.delete(rdv: rdv)
        RendezVousDAO.save()
        return self
    }
    
    
    subscript(index: Int) -> RendezVous{
        get{
            guard let set = RendezVousDAO.fetchAll() else { fatalError("cannot fetch data") }
            guard (index>=0) && (index<set.count) else{ fatalError("index out of range") }
            return set[index]
        }
        set{
            guard var set = RendezVousDAO.fetchAll() else { fatalError("cannot fetch data") }
            guard (index>=0) && (index<set.count) else{ fatalError("index out of range") }
            RendezVousDAO.delete(rdv: set[index])
            set[index]  = newValue
            RendezVousDAO.save()
        }
    }
    
    func makeIterator() -> ItRendezVousSet{
        return ItRendezVousSet(self)
    }
    
}

// MARK: -

struct ItRendezVousSet : IteratorProtocol{
    private var current: Int = 0
    private let set: [RendezVous]
    
    fileprivate init(_ s: RendezVousSet){
        if let set = RendezVousDAO.fetchAll(){
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
    mutating func reset() -> ItRendezVousSet{
        self.current = 0
        return self
    }
    
    @discardableResult
    mutating func next() -> RendezVous? {
        guard self.current < self.set.count else{
            return nil
        }
        let nextRendezVous = self.set[self.current]
        self.current += 1
        return nextRendezVous
    }
    
    /// true if iterator as finished
    var end : Bool{
        return self.current < self.set.count
    }
}
