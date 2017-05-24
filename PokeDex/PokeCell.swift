//
//  PokeCell.swift
//  PokeDex
//
//  Created by JAY PATEL on 5/23/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbl: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    
    func updateCell(_ pokemon: Pokemon) {
        self.pokemon = pokemon
        self.img.image = UIImage(named: "\(pokemon.id)")
        self.lbl.text = pokemon.name.capitalized
    }
}
