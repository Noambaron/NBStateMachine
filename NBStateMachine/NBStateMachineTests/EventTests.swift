//
//  EventTests.swift
//  NBStateMachine
//
//  Created by Noam on 10/13/15.
//  Copyright © 2015 Noam. All rights reserved.
//

import XCTest
import NBStateMachine

class NumberTests: XCTestCase {

    var machine: NBStateMachine!
    
    let state = State(name: "0")
    let stateOne = State(name: "1")
    let stateTwo = State(name: "2")
    let stateThree = State(name: "3")
    let stateFour = State(name: "4")
    let stateFive = State(name: "5")

    override func setUp() {
        super.setUp()
        machine = NBStateMachine(initialState: state)
    }
    
    func testEventWithNoMatchingStates() {

        let event = Event(eventName: "", sourceStates: [stateOne,stateTwo], destinationState: stateThree)
        
        XCTAssertFalse(machine.addEvent(event))
    }
    
    func testEventWithNoSourceState() {
        
        machine.addState(stateOne)
        
        let event = Event(eventName: "", sourceStates: [], destinationState: stateThree)
        
        XCTAssertFalse(machine.addEvent(event))
    }
    
    func testFiringEvent() {
        
        machine.addState(stateThree)
        let event = Event(eventName: "3", sourceStates: [state], destinationState: stateThree)
        machine.addEvent(event)
        
        machine.fireEvent(event)
        XCTAssert(machine.isInState("3"))
    }
    
    func testFiringEventWithWrongState() {
        
        let event = Event(eventName: "3", sourceStates: [stateFour,stateFive], destinationState: stateTwo)
        machine.addState(stateTwo)
        machine.addEvent(event)
        machine.fireEvent(event)
        
        XCTAssert(machine.isInState("0"))
    }
}









