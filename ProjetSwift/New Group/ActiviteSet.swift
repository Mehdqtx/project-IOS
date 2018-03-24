//
//  ActiviteSet.swift
//  ProjetSwift
//
//  Created by Maxime Soustelle on 23/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import Foundation
import CoreData

/// Set of Activite
///
/// *add*: `ActiviteSet` x `Activite` -> `Activite` -- add a `Activite` to the collection
///
/// *remove*: `ActiviteSet` x `Activite` -> `ActiviteSet` -- remove a `Activite` from the collection
///
/// *count*: `ActiviteSet` -> `Int` -- number of `Activite` in the collection
///
/// *createIterator*: returns an iterator on collection
///

class ActiviteSet : Sequence{
    
    var count: Int{
        return ActiviteDAO.count
    }
    
    @discardableResult
    func add(activity: Activite) -> ActiviteSet{
        ActiviteDAO.save()
        return self
    }

    @discardableResult
    func remove(activity: Activite) -> ActiviteSet{
        ActiviteDAO.delete(activity: activity)
        ActiviteDAO.save()
        return self
    }
    
    
    subscript(index: Int) -> Activite{
        get{
            guard let set = ActiviteDAO.fetchAll() else { fatalError("cannot fetch data") }
            guard (index>=0) && (index<set.count) else{ fatalError("index out of range") }
            return set[index]
        }
        set{
            guard var set = ActiviteDAO.fetchAll() else { fatalError("cannot fetch data") }
            guard (index>=0) && (index<set.count) else{ fatalError("index out of range") }
            ActiviteDAO.delete(activity: set[index])
            set[index]  = newValue
            ActiviteDAO.save()
        }
    }

    func makeIterator() -> ItActiviteSet{
        return ItActiviteSet(self)
    }
    
}

// MARK: -

struct ItActiviteSet : IteratorProtocol{
    private var current: Int = 0
    private let set: [Activite]
    
    fileprivate init(_ s: ActiviteSet){
        if let set = ActiviteDAO.fetchAll(){
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
    mutating func reset() -> ItActiviteSet{
        self.current = 0
        return self
    }
    
    @discardableResult
    mutating func next() -> Activite? {
        guard self.current < self.set.count else{
            return nil
        }
        let nextActivite = self.set[self.current]
        self.current += 1
        return nextActivite
    }
    
    /// true if iterator as finished
    var end : Bool{
        return self.current < self.set.count
    }
}


