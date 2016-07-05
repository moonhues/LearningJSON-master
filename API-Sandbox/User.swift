//
//  User.swift
//  API-Sandbox
//
//  Created by Jottie Brerrin on 7/4/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import Foundation
import SwiftyJSON

struct User {
  
  let firstName : String
  let lastName : String
  let streetName : String
  let city : String
  let state : String
  let postCode : String
  let title : String
  let email : String
  let cellNumber : String

  init(json:JSON){
    self.firstName = json["name"]["first"].stringValue
    self.lastName = json["name"]["last"].stringValue
    self.streetName = json["location"]["street"].stringValue
    self.city = json["location"]["city"].stringValue
    self.state = json["location"]["state"].stringValue
    self.postCode = json["location"]["postcode"].stringValue
    self.title = json["name"]["title"].stringValue
    self.email = json["email"].stringValue
    self.cellNumber = json["cell"].stringValue
  }
  
  func printUserInfo(){
    print("\(firstName) \(lastName) lives at \(streetName) in \(city), \(state), \(postCode). If you want to contact \(title).\(lastName), you can email \(email) or call at \(cellNumber).")
  }
  
}