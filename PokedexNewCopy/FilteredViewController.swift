//
//  FilteredViewController.swift
//  Pokedex
//
//  Created by Neha on 2/12/19.
//  Copyright © 2019 Neha. All rights reserved.
//
import UIKit

class FilteredViewController: UIViewController {
    var attack = 0
    var health = 0
    var defense = 0
    var randP = Set<Int>()
    var pName: String!
    var pokemon: Pokemon!
    var types = Set<Int>()
    var getTypes = Set<String>()
    var gridView: UICollectionView!
    var listView: UITableView!
    var pokemonArray = [Pokemon]()
    var getfilteredPokemon = Array<Pokemon>()
    var totalPokemon = 800
    var pokemonTypes = ["Bug", "Dark", "Dragon", "Electric", "Fairy", "Fighting", "Fire", "Flying", "Ghost", "Grass", "Ground", "Ice", "Normal", "Poison", "Physic", "Rock", "Steel", "Water"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listView = UITableView(frame: view.frame)
        listView.register(ListCell.self, forCellReuseIdentifier: "ListCell")
        listView.backgroundColor = UIColor.white
        listView.rowHeight = 60
        listView.showsVerticalScrollIndicator = true
        listView.bounces = true
        listView.tag = 1
        listView.delegate = self as! UITableViewDelegate
        listView.dataSource = self as! UITableViewDataSource
        view.addSubview(listView)
        listView.reloadData()
        
        let layout = UICollectionViewFlowLayout()
        gridView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        gridView.register(GridCell.self, forCellWithReuseIdentifier: "GridCell")
        gridView.backgroundColor = .orange
        gridView.tag = 0
        gridView.delegate = self as! UICollectionViewDelegate
        gridView.dataSource = self as! UICollectionViewDataSource
        view.addSubview(gridView)
        gridView.reloadData()
        
        navigationController?.navigationBar.barTintColor = UIColor.red
        navigationController?.navigationBar.tintColor = UIColor.white;
        let items = ["GridView", "ListView"]
        let SC = UISegmentedControl(items: items)
        SC.selectedSegmentIndex = 0
        SC.addTarget(self, action: #selector(switchingSC), for: .valueChanged)
        SC.layer.cornerRadius = 4
        SC.backgroundColor = .orange
        SC.tintColor = .white
        gridView.isHidden = false
        listView.isHidden = true
        self.navigationItem.titleView = SC
        
        filter()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        if getfilteredPokemon.count == 0 {
            let alert = UIAlertController(title: "No Pokemon Found!", message: "Try searching again!", preferredStyle: UIAlertController.Style.alert)
            
            
            let action1 = UIAlertAction(title: "Alright!", style: .default) { (action: UIAlertAction) in
                self.navigationController?.popToRootViewController(animated: true)
            }
            
            let action2 = UIAlertAction(title: "Cancel", style: .cancel) { (action: UIAlertAction) in
                self.navigationController?.popToRootViewController(animated: true)
            }
            
            let action3 = UIAlertAction(title: "No", style: .destructive) { (action: UIAlertAction) in
                self.navigationController?.popToRootViewController(animated: true)
            }
            
            alert.addAction(action1)
            alert.addAction(action2)
            alert.addAction(action3)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func filter() {
        if !randP.isEmpty {
            for i in pokemonArray {
                for i2 in randP {
                    if i.number == i2 {
                        getfilteredPokemon.append(i)
                    }
                }
                
            }
        }
        else if attack == 0 && defense == 0 && health == 0  && types.isEmpty {
            for i in pokemonArray {
                getfilteredPokemon.append(i)
            }
        }
        else if pName != nil && pName != "" {
            for i in pokemonArray {
                if (i.name == pName) {
                    getfilteredPokemon.append(i)
                }
            }
        }  else {
            for i in pokemonArray {
                if types.isEmpty {
                    if i.attack >= attack && i.defense >= defense && i.health >= health {
                        getfilteredPokemon.append(i)
                    }
                } else {
                    for i2 in types {
                        getTypes.insert(pokemonTypes[i2])
                    }
                    if i.attack >= attack && i.defense >= defense && i.health >= health {
                        let listSet = Set(i.types)
                        
                        let allElemsContained = getTypes.isSubset(of: listSet)
                        if allElemsContained {
                            getfilteredPokemon.append(i)
                        }
                    }
                }
            }
        }
        totalPokemon = getfilteredPokemon.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "infoSegue" {
            let information = segue.destination as! InformationViewController
            information.pokemon = pokemon
        }
        
    }
    
    @objc func switchingSC(sender: UISegmentedControl!) {
        
        if sender.selectedSegmentIndex == 0 {
            gridView.isHidden = false
            listView.isHidden = true
        }
        
        if sender.selectedSegmentIndex == 1 {
            gridView.isHidden = true
            listView.isHidden = false
        }
    }
}

extension FilteredViewController: GridCellDelegate, ListCellDelegate {
    
    func listButton(forCell: ListCell) {
        forCell.backgroundColor = .white
    }
    
    func gridButton(forCell: GridCell) {
        forCell.backgroundColor = .white
    }
}

extension FilteredViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return totalPokemon
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListCell
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        cell.awakeFromNib()
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let pokemonCell = cell as! ListCell
        let pokemon = getfilteredPokemon[indexPath.item]
        let imageURL = URL(string: pokemon.imageUrl)
        if imageURL != nil {
            do {
                let data = try Data(contentsOf: imageURL!)
                pokemonCell.img.image = UIImage(data: data)
                pokemonCell.pLabel.text = "#\(pokemon.number!) \(pokemon.name!)"
            } catch {
                pokemonCell.img.image = UIImage(named: "noimagefound")
                pokemonCell.pLabel.text = "#\(pokemon.number!) \(pokemon.name!)"
            }
        } else {
            pokemonCell.img.image = UIImage(named: "noimagefound")
            pokemonCell.pLabel.text = "#\(pokemon.number!) \(pokemon.name!)"
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pokemon = getfilteredPokemon[indexPath.row]
        self.performSegue(withIdentifier: "infoSegue", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalPokemon
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCell", for: indexPath) as! GridCell
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        cell.awakeFromNib()
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let pokemonCell = cell as! GridCell
        let pokemon = getfilteredPokemon[indexPath.item]
        let imageURL = URL(string: pokemon.imageUrl)
        if imageURL != nil {
            do {
                let data = try Data(contentsOf: imageURL!)
                pokemonCell.img.image = UIImage(data: data)
                pokemonCell.pLabel.text = "#\(pokemon.number!) \(pokemon.name!)"
            } catch {
                pokemonCell.img.image = UIImage(named: "noimagefound")
                pokemonCell.pLabel.text = "#\(pokemon.number!) \(pokemon.name!)"
            }
        } else {
            pokemonCell.img.image = UIImage(named: "noimagefound")
            pokemonCell.pLabel.text = "#\(pokemon.number!) \(pokemon.name!)"
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 120)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        pokemon = getfilteredPokemon[indexPath.item]
        self.performSegue(withIdentifier: "infoSegue", sender: self)
    }
    
    
}



