//
//  ElementLocator.swift
//  TritonAI-SurgicountUITests
//
//  Created by Gandhi, Bansi on 11/1/22.
//

import Foundation
import XCTest

public class ElementLocator {
     
  class func locateElement(elementType: XCUIElement.ElementType, name: String) -> XCUIElement? {
      var element: XCUIElement?
      if elementType ==  .button {
            element = ApplicationManager.sharedUIAppInstance.buttons.element(matching: .button, identifier: getName(name:name))
      }
      else if elementType == .staticText {
            element = ApplicationManager.sharedUIAppInstance.staticTexts.element(matching: .staticText, identifier: getName(name:name))
      }
      else if elementType == .image {
            element = ApplicationManager.sharedUIAppInstance.images.element(matching: .image, identifier: getName(name:name))
      }
      else if elementType == .textField {
            element = ApplicationManager.sharedUIAppInstance.textFields.element(matching: .textField, identifier: getName(name:name))
      }
      else if elementType == .switch {
            element = ApplicationManager.sharedUIAppInstance.switches.element(matching: .switch, identifier: getName(name:name))
      }
    _ = element?.waitForExistence(timeout: 5.0)
      return element
  }
  
  class func locateElement(parent: XCUIElementQuery, matching: XCUIElement.ElementType, identifier: String) -> XCUIElement? {
    var element: XCUIElement?
    if matching == .button {
      element = parent.buttons.element(matching: matching, identifier: getName(name: identifier))
    }
    else if matching == .switch {
      element = parent.switches.element(matching: matching, identifier: getName(name: identifier))
    }
    else if matching == .staticText {
      element = parent.staticTexts.element(matching: matching, identifier: getName(name: identifier))
    }
    else if matching == .toggle {
        element = parent.toggles.element(matching: matching, identifier: getName(name: identifier))
    }
    else if matching == .segmentedControl {
          element = parent.segmentedControls.element(matching: matching, identifier: getName(name: identifier))
    }
    
    
    return element
  }
}

extension ElementLocator {
  
    class func getName(name: String) -> String {
      if name == "Settings" {
        return "cog"
      }
      if name == "Audio notifications" {
        return "audioNotificationsSwitch"
      }
      if name == "Device Name" {
        return "deviceNameButton"
      }
      if name == "Manual entry" {
        return "manualWeightEntrySwitch"
      }
      if name == "Manual canister entry" {
        return "manualCanisterEntrySwitch"
      }
      if name == "Enable Hemorrhage Protocol" {
        return "enableHemorrhageProtocolSwitch"
      }
      if name == "Enable Hemorrhage Alert" {
        return "enableHemorrhageAlertsSwitch"
      }
      if name == "Show Prior Blood Page" {
        return "showPriorBloodLossSwitch"
      }
      if name == "Show Prior Hemoglobin Page" {
        return "showPriorHemoglobinSwitch"
      }
      if name == "Sync logs to server" {
        return "syncLogsToServerSwitch"
      }
      if name == "back" {
        return "arrow left"
      }
      if name == "Zero Scale" {
        return "Place bucket on\nthe scale\n\nThen tap HERE\nto zero scale"
      }
      if name == "Amniotic Fluid +" {
        //return ManualCanisterScreenLocators.amnioticFluidIncrementButton.rawValue
      }
      if name == "bluetooth not connected" {
        return "Please turn on bluetooth to connect the scale"
      }
      if name == "scale not connected" {
        return "Scale disconnected, tap power on scale to reconnect"
      }
      if name == "Advanced Settings" {
        return "advancedSettingsButton"
      }
      return name
    }
}
