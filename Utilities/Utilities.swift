//
//  Utilities.swift
//  TritonAI-SurgicountUITests
//
//  Created by Gandhi, Bansi on 11/1/22.
//

import Foundation
public extension Date {
     
  func getCurrentDateAndTime() -> String {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "MMM dd, yyy HH:mm"
      let currDate = Date()
      return dateFormatter.string(from: currDate)
  }
  func getInstallDate(forSettings: Bool = false) -> String {
    let dateFormatter = DateFormatter()
    if !forSettings {
      dateFormatter.dateFormat = "dd MMM yyyy"
    }
    else {
      dateFormatter.dateFormat = "MMMM dd, yyyy"
    }
    let currDate = Date()
    return dateFormatter.string(from: currDate)
  }

}

public class RandomString {
    class func getRandomString(length: Int = 10) -> String {
      //let length = 10
      let charSet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      let c = Array(charSet)
      var s:String = ""
      for _ in (1...length) {
          s.append(c[Int(arc4random()) % c.count])
      }
      return s
    }
}
