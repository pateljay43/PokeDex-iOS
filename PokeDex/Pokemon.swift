//
//  Pokemon.swift
//  PokeDex
//
//  Created by JAY PATEL on 5/23/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    fileprivate var _pokemonURL: String!
    
    fileprivate var _id: Int!
    fileprivate var _name: String!
    fileprivate var _description: String!
    fileprivate var _type: String!
    fileprivate var _defense: String!
    fileprivate var _height: String!
    fileprivate var _weight: String!
    fileprivate var _attack: String!
    fileprivate var _nextEvo: String!
    fileprivate var _nextEvoId: String!
    fileprivate var _nextEvoName: String!
    fileprivate var _nextEvoLvl: String!
    
    
    var id: Int { return (_id == nil) ? 0 : _id }
    var name: String { return (_name == nil) ? "" : _name }
    var description: String { return (_description == nil) ? "" : _description }
    var type: String { return (_type == nil) ? "" : _type }
    var defense: String { return (_defense == nil) ? "" : _defense }
    var height: String { return (_height == nil) ? "" : _height }
    var weight: String { return (_weight == nil) ? "" : _weight }
    var attack: String { return (_attack == nil) ? "" : _attack }
    var nextEvo: String { return (_nextEvo == nil) ? "" : _nextEvo }
    var nextEvoId: String { return (_nextEvoId == nil) ? "" : _nextEvoId }
    var nextEvoName: String { return (_nextEvoName == nil) ? "" : _nextEvoName }
    var nextEvoLvl: String { return (_nextEvoLvl == nil) ? "" : _nextEvoLvl }
    
    
    
    init(withName name: String, andId id: Int) {
        self._id = id
        self._name = name.capitalized
        
        self._pokemonURL = URL_Base + URL_Pokemon + "\(self._id!)"
    }
    
    func downloadDetails(completed: @escaping DownloadComplete) {
        Alamofire.request(self._pokemonURL).responseJSON { (response) in
            if let dict = response.result.value as? Dictionary<String, Any> {
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                if let height = dict["height"] as? String {
                    self._height = height
                }
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                if let types = dict["types"] as? [Dictionary<String, Any>] , types.count > 0 {
                    if let name = types[0]["name"] as? String {
                        self._type = name.capitalized
                        if types.count > 1 {
                            for x in 1..<types.count {
                                if let name = types[x]["name"] as? String {
                                    self._type! += "/\(name.capitalized)"
                                }
                            }
                        }
                    }
                }
                if let descriptions = dict["descriptions"] as? [Dictionary<String, Any>] , descriptions.count > 0{
                    if let descURL = descriptions[0]["resource_uri"] as? String{
                        let url = "\(URL_Base)\(descURL)"
                        Alamofire.request(url).responseJSON(completionHandler: { (response) in
                            if let dict = response.result.value as? Dictionary<String, Any> {
                                if let desc = dict["description"] as? String {
                                    self._description = desc.replacingOccurrences(of: "POKMON", with: "POKEMON")    // error in the api
                                    print(self._description)
                                }
                            }
                            completed()
                        })
                    }
                }
                if let evolutions = dict["evolutions"] as? [Dictionary<String, Any>] , evolutions.count > 0{
                    if let evo = evolutions[0]["to"] as? String {
                        if evo.range(of: "mega") == nil {       // not supporting mega pokemon
                            self._nextEvoName = evo.capitalized
                            
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                self._nextEvoId = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "").replacingOccurrences(of: "/", with: "")
                            }
                            if let lvl = evolutions[0]["level"] as? Int {
                                self._nextEvoLvl = "\(lvl)"
                            }
                        }
                    }
                }
            }
            completed()
        }
    }
}
