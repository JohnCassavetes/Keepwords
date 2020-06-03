//
//  ViewController.swift
//  Keepwords
//
//  Created by a on 04/12/19.
//  Copyright © 2019 Gaw. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UIAdaptivePresentationControllerDelegate {
    
    var myInfo = [String: [String:String]]()
    
    let userDefaults = UserDefaults.standard
    
    @IBAction func addButtom(_ sender: UIBarButtonItem) {
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].titleName.count
    }
    
    private func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].letter
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sections.map{$0.letter}
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell
        cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let bold: UIFont = UIFont.boldSystemFont(ofSize: 16)
        cell.textLabel!.font = bold
        let section = sections[indexPath.section]
        let mainTitle = section.titleName[indexPath.row]
        cell.textLabel?.text = mainTitle
        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        self.tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("ini mau di edit!!!")
        print(indexPath.row)
        
    }
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "add" {
            let backItem = UIBarButtonItem()
            backItem.title = "Cancel"
            navigationItem.backBarButtonItem = backItem
            segue.destination.presentationController?.delegate = self
        } else if segue.identifier == "toView" {
            let indexPath = tableView.indexPathForSelectedRow
            let section = sections[indexPath!.section]
            let mainTitle = section.titleName[indexPath!.row]
            let hereKeyMainTitle = mainTitle
            let detailViewController = segue.destination as! ViewEntryController
            detailViewController.keyMainTitle = hereKeyMainTitle
        } 
    }
    
    public func presentationControllerDidDismiss(
        _ prsentaionController: UIPresentationController)
    {
        print("closing warning!")
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var searchResult = UISearchController()
    
    struct Section {
        let letter : String
        let titleName : [String]
    }
    
    var sections = [Section]()
    
    override func viewDidAppear(_ animated: Bool) {
        
        if self.userDefaults.value(forKey: "note") != nil {
            mainTitle = []
            myInfo = userDefaults.object(forKey: "note") as! [String: [String:String]]
            print("isinya \(myInfo)")
            print("kunci: \(myInfo.keys)")
            //mainTitle.append("kosong")
            for i in myInfo.keys {
                mainTitle.append(i)
            }
            
            let group = Dictionary(grouping: mainTitle, by: {String($0.prefix(1)).uppercased()})
            print("Group: \(group)")
            let keys = group.keys.sorted()
            sections = keys.map{Section(letter: $0, titleName: group[$0]!.sorted())}
            
            print("Sections: \(sections)")
            
            } else {
               
            }
            self.tableView.reloadData()
        }
    
    var mainTitle = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        for (k,v) in UserDefaults.standard.dictionaryRepresentation() {
            print("\(k) = \(v)")
        }
        
        navigationItem.title = "Passwords"
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
}
