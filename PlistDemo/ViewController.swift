//
//  ViewController.swift
//  PlistDemo
//
//  Created by Adriana González Martínez on 2/25/19.
//  Copyright © 2019 Adriana González Martínez. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Properties
    
    @IBOutlet weak var table: UITableView!
    var scores : [Score] = []
    let userDefaults = UserDefaults.standard

    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
       
        //TODO: Get the list of scores coming from your plist
        
        /// Find the path to the pList file
        let bundle = Bundle.main
        guard let scoresPlistURL = bundle.url(forResource: "Scores", withExtension: "plist") else { return }
        
        /// Load file using FIleManager
        let fileManager = FileManager.default
        guard let scoresPlistData = fileManager.contents(atPath: scoresPlistURL.path) else { return }
        
        /// Decode file into Swift Struct using propertyListDecoder
        let pListDecoder = PropertyListDecoder()
        guard let scores = try? pListDecoder.decode([Score].self, from: scoresPlistData) else { return }
        
        print(scores)
        
        self.scores = scores
        
        
        
        //TODO: Add two entries by code
        
        
        //TODO: Display the complete list of scores in the table view
        table.reloadData()
        
        
        //TODO: Adding user defaults
        /// Favorite Character
        /// Character name with highest score
        /// The highest score
        
        if let charWithHighestScore = scores.max { first, second in
            return first.score < second.score
        } {
            userDefaults.set(charWithHighestScore.name, forKey: UserDefaultKey.characterWithHighestScore.rawValue)
            userDefaults.set(charWithHighestScore.score, forKey:
                UserDefaultKey.highestScore.rawValue)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        printUserDefaults()
    }
    
    //MARK: Plist handling
    //TODO: Keep your file clean by adding helper methods to handle the plist.
    
    private func printUserDefaults() {
        let characterWithHighestScore = userDefaults.string(
            forKey: UserDefaultKey.characterWithHighestScore.rawValue
        )
        let highestScore = userDefaults.integer(
            forKey: UserDefaultKey.highestScore.rawValue
        )
        let favoriteCharacterName = userDefaults.string(
            forKey: UserDefaultKey.favoriteCharacterName.rawValue
        )
        
        print("Character with highest score:", characterWithHighestScore )
        print("Highest Score:", highestScore)
        print("Favorite character:", favoriteCharacterName)
    }
    
    private func getPlistData() -> Array<AnyObject> {
        let plist = Plist(name: "Scores")!
        let plistData = plist.getValuesInPlistFile()! as Array
        print(plistData)
        return plistData
    }
    
    
}

// MARK: TableView setup
extension ViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores.count
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Highest Scores 🚀"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        let item = scores[indexPath.row]
        //TODO: Make sure to display the score and name
        
        let name = item.name
        let score = item.score
        
        cell.textLabel?.text = "\(score) \(name)"
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = scores[indexPath.row].name
        userDefaults.set(name, forKey: UserDefaultKey.favoriteCharacterName.rawValue)
        printUserDefaults()
    }
}


// MARK: Plist Helper
struct PlistHelper {
    
}
