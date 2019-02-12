//
//  ViewController.swift
//  SimultaneousTableViews
//
//  Created by Mark Meretzky on 2/12/19.
//  Copyright © 2019 New York University School of Professional Studies. All rights reserved.
//
//  Drag two UITableViews and two UILabels out of the library and embed them in a vertical UIStackView.
//  Constrain the vertical stack view to (0, 0, 0, 0), top and bottom to safe area of big white view.
//  Constrain the two UITableViews to have equal heights.
//  For each UITableView, drag a UITableViewCell out of the library and put it in the UITableView.
//  Give each UITableView content dynamic, style plain.
//  Give each UITableViewCell style subtitle, reuseIdentifiers reuseidentifier0 and reuseidentifier1.
//  

import UIKit;

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let states: [State] = [
        State(name: "Connecticut", counties: ["Fairfield", "New Haven", "Middlesex", "New London", "Litchfield", "Hartford"]),
        State(name: "Maryland", counties: []),
        State(name: "Massachusetts", counties: ["Berkshire", "Hampden", "Hampshire", "Franklin", "Worcester", "Middlesex", "Norfolk"]),
        State(name: "New Jersey", counties: ["Bergen", "Rockland", "Orange", "Sullivan"]),
        State(name: "New York", counties: ["Westchester", "Putnam", "Dutchess", "Columbia", "Rensselaer", "Albany"]),
        State(name: "Pennsylvania", counties: ["Lancaster", "York", "Adams", "Franklin", "Fulton", "Bedford", "Somerset"]),
        State(name: "Rhode Island", counties: ["Washington", "Kent", "Providence", "Newport", "Bristol"]),
        State(name: "Vermont", counties: ["Bennington", "Windham", "Rutland", "Windsor", "Addison", "Orange"])
    ];
    
    var selectedState: Int = 4;   //New York

    @IBOutlet weak var statesTableView: UITableView!;
    @IBOutlet weak var countiesTableView: UITableView!;
    @IBOutlet weak var countiesLabel: UILabel!;
    
    override func viewDidLoad() {
        super.viewDidLoad();

        // Do any additional setup after loading the view, typically from a nib.
        statesTableView.dataSource = self;
        statesTableView.delegate = self;
        countiesTableView.dataSource = self;
        countiesTableView.delegate = self;

        let indexPath: IndexPath = IndexPath(row: selectedState, section: 0);
        statesTableView.selectRow(at: indexPath, animated: false, scrollPosition: .none);   //Make New York gray.
        countiesLabel.text = "\(states[selectedState].counties.count) Counties of \(states[selectedState].name)";
    }
    
    //MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView === statesTableView {   //"is the same object as"
            return states.count;
        }
        
        if tableView === countiesTableView {
            return states[selectedState].counties.count;
        }
        
        fatalError("The only UITableViews are the states table and the counties table.");
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier: String;
        let text: String;
        let detail: String;

        if tableView === statesTableView {
            reuseIdentifier = "reuseIdentifier0";
            text = states[indexPath.row].name;
            detail = "\(text) is state \(indexPath.row) out of \(states.count).  It has \(states[indexPath.row].counties.count) counties.";
        } else if tableView === countiesTableView {
            reuseIdentifier = "reuseIdentifier1";
            text = states[selectedState].counties[indexPath.row];
            detail = "\(text) is county \(indexPath.row) out of \(states[selectedState].counties.count) in \(states[selectedState].name).";
        } else {
            fatalError("The only UITableViews are the states table and the counties table.")
        }
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath);
        cell.textLabel?.text = text;
        cell.detailTextLabel?.text = detail;
        return cell;
    }
    
    //MARK: - UITableViewDelegate
    
    //When a new state is selected, reload the counties table.
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView === statesTableView {
            selectedState = indexPath.row;
            countiesTableView.reloadData();
            countiesLabel.text = "\(states[selectedState].counties.count) Counties of \(states[selectedState].name)";
        }
    }

}
