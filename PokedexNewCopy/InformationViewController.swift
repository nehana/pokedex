//
//  InformationViewController.swift
//  Pokedex
//
//  Created by Neha on 2/12/19.
//  Copyright © 2019 Neha. All rights reserved.
//

import Foundation
import UIKit
import SafariServices

class InformationViewController: UIViewController {
    
    var types = ["Bug", "Dark", "Dragon","Electric", "Fairy", "Fighting", "Fire", "Flying", "Ghost", "Grass", "Ground", "Ice", "Normal", "Poison", "Physic", "Rock", "Steel", "Water"]
    var typesImage: UIImageView!
    var pokemon: Pokemon!
    var img: UIImageView!
    var name: UILabel!
    var number: UILabel!
    var totalPoints: UILabel!
    var typesOfSpecificPokemon: UILabel!
    var searchOnline: UILabel!
    var favorites: UILabel!
    var defense: UILabel!
    var health: UILabel!
    var attack: UILabel!
    var spDefense: UILabel!
    var spAttack: UILabel!
    var species: UILabel!
    var speed: UILabel!
    var typeSentence: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    func setupLayout() {
        
        name = UILabel(frame: CGRect(x: (view.frame.width/2) - 75, y: 100, width: 150, height: 50))
        name.backgroundColor = .orange
        name.textColor = .white
        name.textAlignment = .center
        name.text = "# \(pokemon.number!) \(pokemon.name!)"
        view.addSubview(name)
        
        img = UIImageView(frame: CGRect(x: 60, y: 200, width: 250, height: 250))
        checkImage()
        view.addSubview(img)
        
        attack = UILabel(frame: CGRect(x: (view.frame.width/3) - 100, y: 450, width: 100, height: 30))
        attack.backgroundColor = .orange
        attack.textColor = .black
        attack.text = "Attack: \(pokemon.attack!)"
        attack.textAlignment = .center
        view.addSubview(attack)
        
        defense = UILabel(frame: CGRect(x: ((2 * view.frame.width)/3) - 100, y: 450, width: 100, height: 30))
        defense.backgroundColor = .orange
        defense.textColor = .black
        defense.textAlignment = .center
        defense.text = "Defense: \(pokemon.defense!)"
        view.addSubview(defense)
        
        health = UILabel(frame: CGRect(x: view.frame.width - 100, y: 450, width: 100, height: 30))
        health.backgroundColor = .orange
        health.textColor = .black
        health.textAlignment = .center
        health.text = "Health: \(pokemon.health!)"
        view.addSubview(health)
        //y = 700?
        totalPoints = UILabel(frame: CGRect(x: 60, y: 700, width: view.frame.width-120, height: 30))
        totalPoints.backgroundColor = .orange
        totalPoints.textColor = .black
        totalPoints.textAlignment = .center
        totalPoints.text = "Total: \(pokemon.total!)"
        view.addSubview(totalPoints)
        
        spAttack = UILabel(frame: CGRect(x: ((2 * view.frame.width)/3) - 100, y: 480, width: 100, height: 30))
        spAttack.backgroundColor = .orange
        spAttack.textColor = .black
        spAttack.textAlignment = .center
        spAttack.text = "spAtt: \(pokemon.specialAttack!)"
        view.addSubview(spAttack)
        
        spDefense = UILabel(frame: CGRect(x: (view.frame.width/3) - 100, y: 480, width: 100, height: 30))
        spDefense.backgroundColor = .orange
        spDefense.textColor = .black
        spDefense.textAlignment = .center
        spDefense.text = "spDef: \(pokemon.specialDefense!)"
        view.addSubview(spDefense)
        
        species = UILabel(frame: CGRect(x: (view.frame.width/2) - 150, y: 530, width: 300, height: 30))
        species.backgroundColor = .orange
        species.textColor = .black
        species.textAlignment = .center
        species.text = "Species: \(pokemon.species!)"
        view.addSubview(species)
        
        speed = UILabel(frame: CGRect(x: view.frame.width - 100, y: 480, width: 100, height: 30))
        speed.backgroundColor = .orange
        speed.textColor = .black
        speed.textAlignment = .center
        speed.text = "Speed: \(pokemon.speed!)"
        view.addSubview(speed)
        
        typesOfSpecificPokemon = UILabel(frame: CGRect(x: (view.frame.width/2) - 150, y: 570, width: 300, height: 30))
        typesOfSpecificPokemon.backgroundColor = .orange
        typesOfSpecificPokemon.textColor = .black
        typesOfSpecificPokemon.textAlignment = .center
        typesOfSpecificPokemon.text = "Type: \(pokemon.types)"
        view.addSubview(typesOfSpecificPokemon)
        
        favorites = UILabel(frame: CGRect(x: (view.frame.width/3) - 90, y: 660, width: 150, height: 30))
        favorites.backgroundColor = .orange
        favorites.textColor = .black
        favorites.text = "Favorite"
        favorites.textAlignment = .center
        view.addSubview(favorites)
        
        searchOnline = UILabel(frame: CGRect(x: ((2 * view.frame.width)/3) - 60, y: 660, width: 150, height: 30))
        searchOnline.backgroundColor = .orange
        searchOnline.textColor = .black
        searchOnline.text = "Search Online"
        searchOnline.textAlignment = .center
        view.addSubview(searchOnline)
    }
    
    
    
    
    @objc func infoPressed(sender: UIButton!) {
        if let pokemonURL = URL(string: "https://google.com/search?q=\(pokemon.name!)") {
            let searchWeb = SFSafariViewController(url: pokemonURL, entersReaderIfAvailable: true)
            present(searchWeb, animated: true)
        }
    }
    
    func checkImage() {
        let imageURL = URL(string: pokemon.imageUrl)
        if imageURL != nil {
            do {
                let data = try Data(contentsOf: imageURL!)
                img.image = UIImage(data: data)
            } catch {
                img.image = UIImage(named: "imagenotfound")
            }
        } else {
            img.image = UIImage(named: "imagenotfound")
        }
    }
    
}
