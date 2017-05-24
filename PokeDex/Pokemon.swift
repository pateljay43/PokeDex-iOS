//
//  Pokemon.swift
//  PokeDex
//
//  Created by JAY PATEL on 5/23/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import Foundation

class Pokemon {
    
    fileprivate var _id: Int!
    fileprivate var _name: String!
    
    var id: Int { return _id }
    var name: String { return _name }
    
    init(withName name: String, andId id: Int) {
        self._id = id
        self._name = name
    }
}
