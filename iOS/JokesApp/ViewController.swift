//
//  ViewController.swift
//  mppexample
//
//  Created by Kurt on 20/08/2019.
//  Copyright © 2019 Kurt. All rights reserved.
//

import UIKit
import Common

class ViewController: UITableViewController, JokesView {
    // MARK: Properties
    var jokes = [Joke]()
    
    // MARK: JokesView
    func showJokes(jokes: [Joke]) {
        self.jokes += jokes
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let serviceLocator = (UIApplication.shared.delegate as! AppDelegate).serviceLocator
        let presenter = JokesPresenter.init(jokesView: self, getJokes: serviceLocator.getJokes)
    
        presenter.getJokes()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jokes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "JokesTableViewCell", for: indexPath) as? JokesTableViewCell else {
            fatalError("The dequeued cell is not an instance of JokesTableViewCell.")
        }
        
        let joke = jokes[indexPath.row]
        
        cell.txtSetup.text = joke.setup
        cell.txtPunchline.text = joke.punchline
        cell.txtPunchline.isHidden = !joke.isPunchlineVisible
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? JokesTableViewCell else {
            fatalError("The cell is not an instance of JokesTableViewCell.")
        }
        jokes[indexPath.row].isPunchlineVisible = true
        cell.txtPunchline.isHidden = false
    }
}
