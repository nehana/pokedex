//
//  ViewController.swift
//  Pokedex
//
//  Created by Neha on 2/11/19.
//  Copyright © 2019 Neha. All rights reserved.
//
import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    var pokemonArray = PokemonGenerator.getPokemonArray()
    var filteredType = Set<Int>()
    
    var userP: UITextField!
    var mainTitle: UILabel!
    
    var userAttack: String!
    var userHealth: String!
    var userDefense: String!
    var attack =  0
    var health = 0
    var defense = 0
    var attackValue: UITextField!
    var healthValue: UITextField!
    var defenseValue: UITextField!
    
    var pName: String!
    var pSearch: UITextField!
    var searchButton: UIButton!
    var rand20Button: UIButton!
    var randP: Set<Int>!
    var margin: CGFloat = 10


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black        
        
        mainTitle = UILabel(frame: CGRect(x: 0, y: 50, width: view.frame.width, height: 80))
        mainTitle.text = "Your Pokedex"
        mainTitle.textColor = .white
        mainTitle.backgroundColor = .orange
        mainTitle.textAlignment = .center
        mainTitle.font = UIFont.systemFont(ofSize: 60)
        view.addSubview(mainTitle)
        pSearch = UITextField(frame: CGRect(x: 30, y: 320, width: 200, height: 30))
        pSearch.borderStyle = .bezel
        pSearch.backgroundColor = .white
        pSearch.addTarget(self, action: #selector(pSearchText), for: .allEditingEvents)
        pSearch.placeholder = "Enter Pokemon"
        view.addSubview(pSearch)
        
        searchButton = UIButton(frame: CGRect(x: 300, y: 320, width: 80, height: 30))
        searchButton.backgroundColor = .orange
        searchButton.setTitle("Search", for: .normal)
        searchButton.setTitleColor(.white, for: .normal)
        searchButton.layer.cornerRadius = 4
        searchButton.addTarget(self, action: #selector(findButtonTapped), for: .touchUpInside)
        view.addSubview(searchButton)
        attackValue = UITextField(frame: CGRect(x: 60, y: 370, width: 180, height: 30))
        attackValue.placeholder = "Attack Filter"
        attackValue.borderStyle = .bezel
        attackValue.backgroundColor = .white
        attackValue.addTarget(self, action: #selector(attackText), for: .allEditingEvents)
        view.addSubview(attackValue)
        healthValue = UITextField(frame: CGRect(x: 60, y: 420, width: 180, height: 30))
        healthValue.placeholder = "Health Filter"
        healthValue.borderStyle = .bezel
        healthValue.backgroundColor = .white
        healthValue.addTarget(self, action: #selector(healthText), for: .allEditingEvents)
        view.addSubview(healthValue)
        defenseValue = UITextField(frame: CGRect(x: 60, y: 470, width: 180, height: 30))
        defenseValue.placeholder = "Defense Filter"
        defenseValue.borderStyle = .bezel
        defenseValue.backgroundColor = .white
        defenseValue.addTarget(self, action: #selector(defenseText), for: .allEditingEvents)
        view.addSubview(defenseValue)
        
        rand20Button = UIButton(frame: CGRect(x: 30, y: 850, width: 150, height: 30))
        rand20Button.backgroundColor = .orange
        rand20Button.setTitle("Random 20!", for: .normal)
        rand20Button.setTitleColor(.white, for: .normal)
        rand20Button.layer.cornerRadius = 4
        rand20Button.addTarget(self, action: #selector(randomButtonTapped), for: .touchUpInside)
        view.addSubview(rand20Button)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "findSegue" {
            let filtered: FilteredViewController = segue.destination as! FilteredViewController
            filtered.pokemonArray = pokemonArray
            filtered.pName = pName
            filtered.types = filteredType
            filtered.attack = attack
            filtered.health = health
            filtered.defense = defense
            filtered.randP = randP
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        
        self.attackValue.delegate = self
        self.healthValue.delegate = self
        self.defenseValue.delegate = self
        
        randP = Set<Int>()
        self.pSearch.delegate = self
    }
    
    @objc func attackText(sender: UITextField) {
        userAttack = sender.text
        if userAttack != "" {
            attack = Int(userAttack)!
        }
    }
    
    @objc func healthText(sender:UITextField) {
        userHealth = sender.text
        if userHealth != "" {
            health = Int(userHealth)!
        }
    }
    @objc func defenseText(sender: UITextField) {
        userDefense = sender.text
        if userDefense != "" {
            defense = Int(userDefense)!
        }
    }
    
    @objc func pSearchText (sender: UITextField) {
        let numPokemon = Int(sender.text!)
        if numPokemon != nil {
            for i in pokemonArray {
                if numPokemon == i.number {
                    pName = i.name
                }
            }
        } else {
            pName = sender.text
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func randomButtonTapped(sender: UIButton) {
        while randP.count < 20 {
            randP.insert(Int(arc4random_uniform(80)) + 1)
        }
        self.performSegue(withIdentifier: "findSegue", sender: self)
    }

    @objc func typeButtonTouched(sender: UIButton) {
        if (filteredType.contains(sender.tag)){
            filteredType.remove(sender.tag)
            sender.layer.borderColor = UIColor.blue.cgColor
        } else {
            filteredType.insert(sender.tag)
            sender.layer.borderWidth = 1
        }
    }
    
    @objc func findButtonTapped(sender: UIButton) {
        self.performSegue(withIdentifier: "findSegue", sender: self)
    }
    

}
