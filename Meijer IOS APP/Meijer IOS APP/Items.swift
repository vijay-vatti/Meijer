//
//  Items.swift
//  Meijer IOS APP
//
//  Created by Farhadul Fahim on 2/7/22.
//

import Foundation
import UIKit


struct Items {
    let department: String
    let title: String
    
    static func GetAllItems() -> [Items] {
        return [
            Items(department: "Grocery", title: "Milk"),
            Items(department: "Grocery", title: "Yogurt"),
            Items(department: "Grocery", title: "Eggs"),
            Items(department: "Grocery", title: "Cheese"),
            
            Items(department: "Household Essentials", title: "Laundry"),
            Items(department: "Household Essentials", title: "Tableware"),
            Items(department: "Household Essentials", title: "Cleaners"),
            Items(department: "Household Essentials", title: "Dishwashing"),
            
            Items(department: "Pet Care", title: "Dogs Food"),
            Items(department: "Pet Care", title: "Cats Food"),
            Items(department: "Pet Care", title: "Pet Cleaners"),
        ]
    }
}
