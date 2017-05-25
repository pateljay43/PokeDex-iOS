//
//  PokemonDetailVC.swift
//  PokeDex
//
//  Created by JAY PATEL on 5/24/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var segView: UISegmentedControl!
    
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblDefense: UILabel!
    @IBOutlet weak var lblHeight: UILabel!
    @IBOutlet weak var lblId: UILabel!
    @IBOutlet weak var lblWeight: UILabel!
    @IBOutlet weak var lblBaseAttack: UILabel!
    
    @IBOutlet weak var lblEvo: UILabel!
    
    @IBOutlet weak var imgCurrEvo: UIImageView!
    @IBOutlet weak var imgNextEvo: UIImageView!
    
    private var _pokemon: Pokemon!
    
    var pokemon: Pokemon {
        get { return _pokemon }
        set { _pokemon = newValue }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblName.text = _pokemon.name
        lblId.text = "\(_pokemon.id)"
        let img = UIImage.init(named: "\(_pokemon.id)")
        mainImg.image = img
        imgCurrEvo.image = img
        
        _pokemon.downloadDetails {
            print("completed download")
            self.updateUI()
        }
    }
    
    func updateUI () {
        lblType.text = _pokemon.type
        lblBaseAttack.text = _pokemon.attack
        lblDefense.text = _pokemon.defense
        lblHeight.text = _pokemon.height
        lblWeight.text = _pokemon.weight
        lblDescription.text = _pokemon.description
        
        if _pokemon.nextEvoId == "" {
            lblEvo.text = "No Evolutions"
            imgNextEvo.isHidden = true
        } else {
            lblEvo.text = "Next Evolution: \(_pokemon.nextEvoName) LVL-\(_pokemon.nextEvoLvl)"
            imgNextEvo.isHidden = false
            imgNextEvo.image = UIImage.init(named: _pokemon.nextEvoId)
        }
    }

    @IBAction func backBtnPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
