//
//  CommonSteps.swift
//  TritonAI-SurgicountUITests
//
//  Created by Thukaram Kethavath on 09/11/22.
//

import Foundation
import XCTest

public class CommonScreen {
    
    public init() {}
    public static let shared = CommonScreen()
    public static var patientName = ""
    public static var appMode = ""
    public static var longNote = ""
}


// MARK: Common Verifications
public extension CommonScreen {
    
    func verifyScreen(screenName: String?) {
        guard let screenName = screenName else {
            XCTFail("Verify Screen Action : Screen name is nil")
            return
        }
        //    switch screenName {
        //        case Screens.login.rawValue:
        //          RegistrationScreen.shared.verifyScreen()
        //        case Screens.registration.rawValue:
        //          RegistrationScreen.shared.verifyScreen()
        //        default:
        //          XCTFail("Verify Screen Action : No such screen found")
        //      }
    }
    
    func verifyAlert(alert name: String?) {
        guard let name = name else {
            XCTFail("Alert name is NIL")
            return
        }
        switch name {
        case Alerts.licenseKeyLessThan20Chars.rawValue, Alerts.deviceNameBlank.rawValue, Alerts.confirmDateAndTime.rawValue, Alerts.invalidLicenseKey.rawValue:
            //RegistrationScreen.shared.verifyAlert(alert: name)
            break
        default:
            XCTFail("Could not find Alert named: \(name)")
        }
    }
    
    func verifyToggleable(element name: String?) {
        guard let name = name else {
            XCTFail("name is NIL")
            return
        }
        guard let element = ElementLocator.locateElement(parent: ApplicationManager.sharedUIAppInstance.cells, matching: .switch, identifier: name) else {
            return
        }
        let currState = element.value as! String
        element.tap()
        currState == "0" ? XCTAssertEqual("1", element.value as! String) : XCTAssertEqual("0", element.value as! String)
    }
    
    func verifyTextValue(element name: String?, value: String) {
        guard let name = name else {
            XCTFail("name is NIL")
            return
        }
        guard let element = ElementLocator.locateElement(elementType: .textField, name: name) else {
            XCTFail("Could not locate element: \(name)")
            return
        }
        let currValue = element.value as! String
        XCTAssertEqual(value, currValue)
    }
    
    func verifyScreenVisibile(element name: String?, visible: String) {
        guard let name = name else {
            XCTFail("name is NIL")
            return
        }
        //      guard let element = ElementLocator.locateElement(parent: ApplicationManager.sharedUIAppInstance., matching: .switch, identifier: name) else {
        //          return
        //      }
        //    let currValue = element.value as! String
        //    XCTAssertEqual(name, currValue)
    }
    
    func verifyButtonState(name: String, state: String) {
        guard let element = ElementLocator.locateElement(elementType: .button, name: name) else {
            XCTFail("Could not locate element: \(name)")
            return
        }
        if state == "enabled" {
            // element.assert()
        }
        else if state == "disabled" {
            //element.assertDisabled()
        }
        else {
            XCTFail()
        }
        
    }
    
    
    
    func verifyButtonExists(name: String) -> Bool {
        var element = ElementLocator.locateElement(elementType: .button, name: name)
        return (element != nil)
        }
    }

// MARK: Common Actions
public extension CommonScreen {
    
  func swipeUpUntilElementFound(element : XCUIElement, maxNumberOfSwipes : UInt) -> Bool{
            if element.exists{
                return true
            }
            else {
                for _ in 1...maxNumberOfSwipes{
                    ApplicationManager.sharedUIAppInstance.swipeUp()
                    if element.exists{
                        return true
                    }
                }
                return false
            }
  }
    
//    func tapKeyboardKey(key: String, element name: String, elementType: XCUIElement.ElementType, parent: XCUIElementQuery? = nil) -> Void{
//        if let parent = parent {
//            guard let element = ElementLocator.locateElement(parent: parent, matching: elementType, identifier: name) else {
//                XCTFail("Could not locate element: \(name)")
//                return
//            }
//            ApplicationManager.sharedUIAppInstance.k
//        }
//        else {
//            guard let element = ElementLocator.locateElement(elementType: elementType, name: name) else {
//                XCTFail("Could not locate element: \(name)")
//                return
//            }
//            element.typeKey(key, [])
//            
//        }
//    }
    
  func tap(element name: String?, elementType: XCUIElement.ElementType, parent: XCUIElementQuery? = nil) {
      
    guard let name = name else {
      XCTFail("Tap Action : Element name is NIL")
      return
    }
    if let parent = parent {
      guard let element = ElementLocator.locateElement(parent: parent, matching: elementType, identifier: name) else {
        XCTFail("Could not locate element: \(name)")
          return
      }
      self.swipeUpUntilElementFound(element: element, maxNumberOfSwipes: 1)
      element.tap()
    }
    else {
      guard let element = ElementLocator.locateElement(elementType: elementType, name: name) else {
        XCTFail("Could not locate element: \(name)")
        return
      }
      
      if name == "Advanced Settings" && elementType == .button {
       
        ApplicationManager.sharedUIAppInstance.swipeUp()

        element.tap()
      }else {
        self.swipeUpUntilElementFound(element: element, maxNumberOfSwipes: 1)
        element.tap()
      }
      
    }
    
    if name == "Settings" || name == "Start" {
      // check if Bluetooth alert
      if Springboard.springboard.buttons["OK"].waitForExistence(timeout: 5) {
          Springboard.springboard.buttons["OK"].tap()
      }
    }
  }
    
    func CheckProperty(element : XCUIElement, property : String) -> Void{
    
        if (property == "visible")
        {
            XCTAssertTrue(element.waitForExistence(timeout: 10))
        }
        else if (property == "not visible")
        {
            XCTAssertFalse(element.waitForExistence(timeout: 5))
        }
        else if (property == "enabled")
        {
            XCTAssertTrue(element.isEnabled)
        }
        else if (property == "not enabled")
        {
            XCTAssertFalse(element.isEnabled)
        }
        else
        {
            XCTFail("Unknown property: " + property)
        }
        
    }
  
  func killApp() {
      ApplicationManager.sharedUIAppInstance.terminate()
      sleep(2)
  }
  
  func closeAllActiveProcedures() {
    let cells = ApplicationManager.sharedUIAppInstance.cells
    for i in 0..<cells.count {
      let cell = cells.element(boundBy: i)
      if !cell.staticTexts["Start a new case"].exists {
        cell.tap()
//        if ProcedureTypeScreenLocators.closeCase.element.waitForExistence(timeout: 5) {
//          ProcedureTypeScreenLocators.closeCase.element.tap()
//          CommonScreenLocators.yesButton.element.tap()
//        }
//        else {
//          ProcedureTypeScreenLocators.backButton.element.tap()
//        }
      }
    }
  }
}

