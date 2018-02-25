//
//  AddRegistrationTableViewController.swift
//  HotelMazana
//
//  Created by Dũng Võ on 2/23/18.
//  Copyright © 2018 Dũng Võ. All rights reserved.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController , SelectRoomTypeTableViewControllerDelegate {
    
    func didSelect(roomType: RoomType) {
        self.roomType = roomType
        updateRoomType()
    }

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var checkInDateLabel: UILabel!
    @IBOutlet weak var checkOutDateLabel: UILabel!
    @IBOutlet weak var checkInDatePicker: UIDatePicker!
    @IBOutlet weak var checkOutDatePicker: UIDatePicker!
    
    @IBOutlet weak var adultsLabel: UILabel!
    @IBOutlet weak var childrenLabel: UILabel!
    @IBOutlet weak var numberAdultsStepper: UIStepper!
    @IBOutlet weak var numberChildrenStepper: UIStepper!
    
    @IBOutlet weak var costWifiLabel: UILabel!
    @IBOutlet weak var wifiSwitch: UISwitch!
    
    @IBOutlet weak var roomTypeLabel: UILabel!
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    @IBOutlet weak var numberOfNights: UILabel!
    @IBOutlet weak var RomType: UILabel!
    @IBOutlet weak var wifi: UILabel!
    @IBOutlet weak var total: UILabel!
    
    //variable status date time picker
    let checkInDateTimePickerCellIndexPath = IndexPath(row: 1, section: 1)
    let checkOutDateTimePickerCellIndexPath = IndexPath(row: 3, section: 1)
    
    var isCheckInDateTimePickerShown : Bool = false {
        didSet{
            checkInDatePicker.isHidden = !isCheckInDateTimePickerShown
        }
    }
    var isCheckOutDateTimePickerShown : Bool = false {
        didSet{
            checkOutDatePicker.isHidden = !isCheckOutDateTimePickerShown
        }
    }
    
    var roomType : RoomType?
    
    var registration : Registration?
    {
        guard let roomType = roomType else {
            return nil
        }

        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let email = emailTextField.text ?? ""

        let checkInDate = checkInDatePicker.date
        let checkOutDate = checkOutDatePicker.date

        let numberAdults = Int(numberAdultsStepper.value)
        let numberChildren = Int(numberChildrenStepper.value)

        let wifiCost = wifiSwitch.isOn

        return Registration(firstName: firstName, lastName: lastName, email: email, checkInDate: checkInDate, checkOutDate: checkOutDate, numberOfAdults: numberAdults, numberOfChildren: numberChildren, roomType: roomType, wifi: wifiCost)
    }
    
    var registrationPrepare : Registration?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let midnightToday = Calendar.current.startOfDay(for: Date())
        checkInDatePicker.minimumDate = midnightToday
        checkInDatePicker.date = midnightToday
        
        checkOutDatePicker.minimumDate = checkInDatePicker.date.addingTimeInterval(86400)
        
        //update date picker view
        updateDateViews()
        
        //update stepper value
        updateNumberOfGuests()
        
        //cost wifi
        costWifiLabel.text = "$10 \t"
        
        //update room type
        updateRoomType()
        
        //update registration detail
        if let registrationPrepare = registrationPrepare {
            firstNameTextField.text = registrationPrepare.firstName
            lastNameTextField.text = registrationPrepare.lastName
            emailTextField.text = registrationPrepare.emailAddress
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            checkInDateLabel.text = dateFormatter.string(from: registrationPrepare.checkInDate)
            checkOutDateLabel.text = dateFormatter.string(from: registrationPrepare.checkOutData)
            adultsLabel.text = String(registrationPrepare.numberOfAdults)
            childrenLabel.text = String(registrationPrepare.numberOfChildren)
            roomTypeLabel.text = registrationPrepare.roomType.name
        }
        
        updateDoneButton()
        
    

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func updateDateViews(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        checkInDateLabel.text = dateFormatter.string(from: checkInDatePicker.date)
        checkOutDateLabel.text = dateFormatter.string(from: checkOutDatePicker.date)
    }
    
    @IBAction func datePickerValueChanged(_ sender : UIDatePicker){
        updateDateViews()
    }
    
    //cell heights
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath.section , indexPath.row) {
        case (checkInDateTimePickerCellIndexPath.section , checkInDateTimePickerCellIndexPath.row):
            if isCheckInDateTimePickerShown {
                return 216.0
            }else {
                return 0.0
            }
        case (checkOutDateTimePickerCellIndexPath.section , checkOutDateTimePickerCellIndexPath.row):
            if isCheckOutDateTimePickerShown {
                return 216.0
            }else {
                return 0.0
            }
        default:
            return 44.0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch (indexPath.section , indexPath.row) {
        case (checkInDateTimePickerCellIndexPath.section , checkInDateTimePickerCellIndexPath.row - 1):
            if isCheckInDateTimePickerShown {
                isCheckInDateTimePickerShown = false
            }else if isCheckInDateTimePickerShown{
                isCheckOutDateTimePickerShown = false
                isCheckInDateTimePickerShown = true
            }else {
                isCheckInDateTimePickerShown = true
            }
            tableView.beginUpdates()
            tableView.endUpdates()
        case (checkOutDateTimePickerCellIndexPath.section , checkOutDateTimePickerCellIndexPath.row - 1) :
            if isCheckOutDateTimePickerShown {
                isCheckOutDateTimePickerShown = false
            }else if isCheckOutDateTimePickerShown{
                isCheckInDateTimePickerShown = false
                isCheckOutDateTimePickerShown = true
            }else {
                isCheckOutDateTimePickerShown = true
            }
            tableView.beginUpdates()
            tableView.endUpdates()
        default:
            break
        }
    }
    
    func updateNumberOfGuests() {
        adultsLabel.text = "\(Int(numberAdultsStepper.value)) \t"
        childrenLabel.text = "\(Int(numberChildrenStepper.value)) \t"
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        updateNumberOfGuests()
    }
    
    @IBAction func wifiSwitchChanged(_ sender: UISwitch) {
    }
    
    func updateRoomType() {
        if let roomType = roomType {
            roomTypeLabel.text = roomType.name
        }else {
            roomTypeLabel.text = "No set"
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailRoomType"{
            let destinationViewController = segue.destination as? SelectRoomTypeTableViewController
            destinationViewController?.delegate = self
            destinationViewController?.roomType = roomType
        }
    }

    func updateDoneButton(){
        
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        
        doneBarButton.isEnabled = !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty 
    }
    
    @IBAction func textEditingChanged(_ sender : UITextField){
        updateDoneButton()
    }
    
//    func totalPrice(registration : Registration){
//        let numberOfNights = Int(registration.checkInDate.timeIntervalSince1970 - registration.checkOutData.timeIntervalSince1970)
//
//        let roomTypePrice : Int = registration.roomType.price
//        let shortNameRoom : String = registration.roomType.shortName
//
//        var wifiDaysPrice : Int = 0
//
//        if registration.wifi {
//            wifiDaysPrice = 10 * numberOfNights
//        }
//
//        let total : Double = Double(wifiDaysPrice + roomTypePrice)
//
//        updatePrice(roomPrice: roomTypePrice, wifiDaysPrice: wifiDaysPrice, totalPrice: total, numberNights: numberOfNights, shortNameRoom: shortNameRoom)
//        print(numberOfNights)
//    }
//
//    func updatePrice(roomPrice : Int , wifiDaysPrice : Int , totalPrice : Double  ,numberNights : Int , shortNameRoom : String) {
////        numberOfNights.text = "\(numberNights)"
////        RomType.text = "\(shortNameRoom) \t \(roomPrice)"
////        wifi.text = "\(wifiDaysPrice)"
////        total.text = "\(totalPrice)"
//    }
    
    
    
}
