//
//  Registration.swift
//  HotelMazana
//
//  Created by Dũng Võ on 2/23/18.
//  Copyright © 2018 Dũng Võ. All rights reserved.
//

import Foundation

struct Registration {
    var firstName : String
    var lastName : String
    var emailAddress : String
    
    var checkInDate : Date
    var checkOutData : Date
    var numberOfAdults : Int
    var numberOfChildren : Int
    
    var roomType : RoomType
    var wifi : Bool
    
    init(firstName : String , lastName : String , email : String , checkInDate : Date , checkOutDate : Date , numberOfAdults : Int , numberOfChildren : Int , roomType : RoomType, wifi : Bool) {
        self.firstName = firstName
        self.lastName = lastName
        self.emailAddress = email
        self.checkInDate = checkInDate
        self.checkOutData = checkOutDate
        self.numberOfAdults = numberOfAdults
        self.numberOfChildren = numberOfChildren
        self.roomType = roomType
        self.wifi = wifi
    }
}

struct RoomType : Equatable {
    var id : Int
    var name : String
    var shortName : String
    var price : Int
    
    static var all : [RoomType] {
        return [RoomType(id: 0, name: "Two Queens", shortName: "2Q", price: 179),
                RoomType(id: 1, name: "One King", shortName: "K", price: 209),
                RoomType(id: 2, name: "Penthouse Suite", shortName: "PHS", price: 309)
        ]
    }
}

func ==(lhs : RoomType , rhs : RoomType ) -> Bool {
    return lhs.id == rhs.id
}


