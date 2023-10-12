//
//  XCUIElemen+Extension.swift
//  TritonAI-SurgicountUITests
//
//  Created by Gandhi, Bansi on 11/1/22.
//

import Foundation
import XCTest

// MARK: Assertions
extension XCUIElement {
    
    func assertVisible(timeOut: Double = 10.0) {
        self.assertPresent()
        XCTAssertTrue(self.isHittable, "Assertion Failure. Element of Type: \(self.label) Not Visible.")
        if !(self.frame.origin.x >= 0 && self.frame.origin.y >= 0 && (self.frame.origin.x + self.frame.width) <= ApplicationManager.sharedUIAppInstance.windows.element.firstMatch.frame.width && (self.frame.origin.y + self.frame.height) <= ApplicationManager.sharedUIAppInstance.windows.element.firstMatch.frame.height) {
            print("from top: \(self.frame.origin.y)")
            print("from left: \(self.frame.origin.x)")
            print("from bottom: \(ApplicationManager.sharedUIAppInstance.windows.element.firstMatch.frame.height - (self.frame.origin.y + self.frame.height))")
            print("from right: \(ApplicationManager.sharedUIAppInstance.windows.element.firstMatch.frame.width - (self.frame.origin.x + self.frame.width))")
            XCTFail("Assertion Failure. Element of Type: \(self.label) not within the application window")
        }
    }
    
    func assertNotVisible(timeOut: Double = 10.0) {
        self.assertNotPresent()
    }
    
    func assertPresent(timeOut: Double = 10.0) {
        XCTAssertTrue(self.waitForExistence(timeout: timeOut), "Assertion Failure. Element of Type: \(self.label) Not Present.")
    }
    
    func assertLabel(expected: String) {
        XCTAssertEqual(expected, self.label, "Assertion Failure. Element label expected: \(expected). Actual Label: \(self.label)")
    }
  
    func assertNotLabel(expected: String) {
        XCTAssertNotEqual(expected, self.label, "Assertion Failure. Element label expected: \(expected). Actual Label: \(self.label)")
    }
    
    func assertNotPresent(timeOut: Double = 3.0) {
        XCTAssertFalse(self.waitForExistence(timeout: timeOut), "Assertion Failure. Element of Type: \(self.label) Present.")
    }
    
    func assertDisabled(timeOut: Double = 3.0) {
        XCTAssertFalse(self.isEnabled, "Assertion Failure. Element of type: \(self.label) should be disabled.")
    }
    
    func assertEnabled(timeOut: Double = 3.0) {
        XCTAssertTrue(self.isEnabled, "Assertion Failure. Element of type: \(self.label) should be enabled.")
    }
    
    func assertEqual(label: String) {
        XCTAssertEqual(self.value as! String, label, "Assertion Failure. Actual Label: \(self.label) is not equal to \(label)")
        
    }
    
    func assertSelected() {
        XCTAssertTrue(self.isSelected, "Assertion Failure. Element of type: \(self.label) should be enabled.")
    }
}
    
// MARK: Actions
extension XCUIElement {
    
    func tapElement(ifVisible: Bool = false) {
        let result = self.waitForExistence(timeout: 60)
        if !result {
            XCTFail("Element of type \(self.label) does not exist")
        }
      if ifVisible {
          var timer = 0
          while !self.isHittable || (timer < 5) {
              timer = timer+1
              sleep(1)
          }
      }
      self.tap()
    }
    
    func scrollToVisibleFrom(element: XCUIElement) {
        while !self.isHittable {
            element.gentleSwipe(.up)
        }
        print("is Hittable: \(self.isHittable)")
    }
  
    func clearAndEnterText(text: String) {
        guard let stringValue = self.value as? String else {
            XCTFail("Tried to clear and enter text into a non string value")
            return
        }

        self.tap()

        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)

        self.typeText(deleteString)
        self.typeText(text)
   }
    
enum Direction: Int {
    case up, down, left, right
}

func gentleSwipe(_ direction: Direction) {
    let half: CGFloat = 0.5
    let adjustment: CGFloat = 0.25
    let pressDuration: TimeInterval = 0.05

    let lessThanHalf = half - adjustment
    let moreThanHalf = half + adjustment

    let centre = self.coordinate(withNormalizedOffset: CGVector(dx: half, dy: half))
    let aboveCentre = self.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0.05))
    let belowCentre = self.coordinate(withNormalizedOffset: CGVector(dx: half, dy: moreThanHalf))
    let leftOfCentre = self.coordinate(withNormalizedOffset: CGVector(dx: lessThanHalf, dy: half))
    let rightOfCentre = self.coordinate(withNormalizedOffset: CGVector(dx: moreThanHalf, dy: half))

    switch direction {
    case .up:
        centre.press(forDuration: pressDuration, thenDragTo: aboveCentre)
    case .down:
        centre.press(forDuration: pressDuration, thenDragTo: belowCentre)
    case .left:
        centre.press(forDuration: pressDuration, thenDragTo: leftOfCentre)
    case .right:
        centre.press(forDuration: pressDuration, thenDragTo: rightOfCentre)
    }
  }
}
