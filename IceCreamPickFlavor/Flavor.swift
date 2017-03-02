//
//  Flavor.swift
//  IceCreamShop
//
//  Created by Joshua Greene on 1/16/15.
//  Copyright (c) 2015 Razeware, LLC. All rights reserved.
//

import UIKit

struct Flavor {
  
  // MARK: Instance Variables
  
  let name: String
  let topColor: UIColor
  let bottomColor: UIColor
  
  // MARK: Static Methods
  
  static func vanilla() -> Flavor {
    return Flavor(name:"Vanilla", topColor:RGB(251, green: 248, blue: 236), bottomColor:RGB(230, green: 215, blue: 171))
  }
  
  static func chocolate() -> Flavor {
    return Flavor(name:"Chocolate", topColor:RGB(203, green: 140, blue: 58), bottomColor:RGB(107, green: 46, blue: 11))
  }
  
  // MARK: Initializers
  
  init(name: String, topColor: UIColor, bottomColor: UIColor) {
    self.name = name
    self.topColor = topColor
    self.bottomColor = bottomColor
  }
  
  /*
  FAILABLE INITIALIZER
You typically define a failable initializer that creates an optional instance of the appropriate type by placing a question mark after the  init keyword (init?). Alternatively, you can define a failable initializer that creates an implicitly unwrapped optional instance of the appropriate type. Do this by placing an exclamation mark after the  init keyword (init!) instead of a question mark.

You can delegate from init? to init! and vice versa, and you can override init? with init! and vice versa. You can also delegate from  init to init!, although doing so will trigger an assertion if the  init! initializer causes initialization to fail.

*/
  init?(dictionary: [String: String]) {
    
    let topColorString = dictionary["topColor"]
    
    // RGBAColorFromString comes from Categories > RGBAColorFromString.swift as an extension of UIColor
    if let topColor = UIColor.RGBAColorFromString(topColorString) {
      self.topColor = topColor
      
    } else {
      return nil
    }
    
    let bottomColorString = dictionary["bottomColor"]
    
    if let bottomColor = UIColor.RGBAColorFromString(bottomColorString) {
      self.bottomColor = bottomColor
      
    } else {
      return nil
    }
    
    if let name = dictionary["name"] {
      self.name = name
      
    } else {
      return nil
    }
  }
}

protocol FlavorAdapter {
  
  func updateWithFlavor(flavor: Flavor)
}
