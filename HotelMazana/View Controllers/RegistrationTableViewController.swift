//
//  RegistrationTableViewController.swift
//  HotelMazana
//
//  Created by Dũng Võ on 2/24/18.
//  Copyright © 2018 Dũng Võ. All rights reserved.
//

import UIKit

class RegistrationTableViewController: UITableViewController {

    var registrations : [Registration] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return registrations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegistrationCell", for: indexPath)
        
        let registration = registrations[indexPath.row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        cell.textLabel?.text = "\(registration.firstName) \(registration.lastName)"
        cell.detailTextLabel?.text = "\(dateFormatter.string(from:registration.checkInDate)) - \(dateFormatter.string(from:registration.checkOutData)) - \(registration.roomType.name)"
        
        return cell
    }
    
    @IBAction func unwindToRegistration(_ unwindSeque : UIStoryboardSegue){
        guard let addRegistrationViewController = unwindSeque.source as? AddRegistrationTableViewController ,
        let registration = addRegistrationViewController.registration else {
           return
        }
        if let selectedIndexPath = tableView.indexPathForSelectedRow{
            registrations[selectedIndexPath.row] = registration
        }else {
            let newIndexPath = IndexPath(row: registrations.count, section: 0)
            registrations.append(registration)
        }
        
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailRegistration" {

        let indexPath = tableView.indexPathForSelectedRow!
        let registration = registrations[indexPath.row]

        let addRegistrationTableViewController = segue.destination as! AddRegistrationTableViewController
            addRegistrationTableViewController.registrationPrepare = registration
         //   addRegistrationTableViewController.totalPrice(registration: registration)
        }
    }
    
    

    

}
