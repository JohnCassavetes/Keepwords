//
//  ViewController.swift
//  Keepwords
//
//  Created by a on 04/12/19.
//  Copyright © 2019 Gaw. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UIAdaptivePresentationControllerDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var myInfo = [String: [String:String]]()
    
    let userDefaults = UserDefaults.standard
    
    var filteredTitle = [String]()
    var dataDict = [String: [String]]()
    var dataSectTitles = [String]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBAction func addButtom(_ sender: UIBarButtonItem) {
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = dataSectTitles[section]
        if let fData = dataDict[key] {
            return fData.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataSectTitles[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSectTitles.count
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return dataSectTitles
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        //cell.textLabel?.text = filteredData[indexPath.row]+"\(indexPath.section)"
        let key = dataSectTitles[indexPath.section]
        if let fData = dataDict[key] {
            cell.textLabel?.text = fData[indexPath.row]
        }
        return cell
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
            //let section = dataSectTitles[indexPath!.section]
            var mainTitle = ""
            let key = dataSectTitles[indexPath!.section]
            if let fData = dataDict[key] {
                mainTitle = fData[indexPath!.row]
            }
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

    var mainTitle = [String]()
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredTitle = []
        dataDict = [String: [String]]()
        dataSectTitles = [String]()
        if searchText == "" {
            filteredTitle = mainTitle
        }
        for fruit in mainTitle {
            if fruit.lowercased().contains(searchText.lowercased()) {
                filteredTitle.append(fruit)
            }
        }
        makeSections()
        self.tableView.reloadData()
    }
    
    func makeSections() {
        for fData in filteredTitle {
            let key = String(fData.prefix(1))
            if var d = dataDict[key] {
                d.append(fData)
                dataDict[key] = d
            } else {
                dataDict[key] = [fData]
            }
        }
        dataSectTitles = [String](dataDict.keys)
        dataSectTitles = dataSectTitles.sorted(by: { $0 < $1 })
    }
    
    override func viewDidAppear(_ animated: Bool) {

        if self.userDefaults.value(forKey: "note") != nil {
            mainTitle = []
            myInfo = userDefaults.object(forKey: "note") as! [String: [String:String]]
            print("isinya \(myInfo)")
            print("kunci: \(myInfo.keys)")
            
            filteredTitle = []
            dataDict = [String: [String]]()
            dataSectTitles = [String]()
            
            for i in myInfo.keys {
                mainTitle.append(i)
            }
            filteredTitle = mainTitle
            makeSections()
            self.tableView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.searchBar.delegate = self
        
        filteredTitle = []
        dataDict = [String: [String]]()
        dataSectTitles = [String]()
        
        dataSectTitles = dataSectTitles.sorted(by: { $0 < $1 })
        
        filteredTitle = mainTitle
        makeSections()
        /*
        for (k,v) in UserDefaults.standard.dictionaryRepresentation() {
            print("\(k) = \(v)")
        }
        */
        navigationItem.title = "Passwords"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        self.tableView.reloadData()
        
    }
}

