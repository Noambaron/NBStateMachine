//
//  AddingStatesTestCase.swift
//  NBStateMachine
//
//  Created by Noam on 10/13/15.
//  Copyright © 2015 Noam. All rights reserved.
//

import XCTest
import NBStateMachine

class AddingStatesTestCase: XCTestCase {

    let initial = State(name: "4")
    var machine : NBStateMachine!
    
    override func setUp() {
        super.setUp()
        
        machine = NBStateMachine(initialState: initial)
    }

    func testAddState() {
        machine.addState(State(name: "3"))
        
        XCTAssert(machine.isStateAvailable("3"))
    }
    
    func testAddStates() {
        machine.addStates([State(name: "6"),State(name: "7")])
        
        XCTAssert(machine.isStateAvailable("6"))
        XCTAssert(machine.isStateAvailable("7"))
    }
    
    func testStateAvailable() {
        machine.addState(State(name: "5"))
        
        let state = machine.findStateWithName("5")
        
        XCTAssertNotNil(state)
    }
    
    func testStateIsNotAvailable() {
        let state = machine.findStateWithName("2")
        
        XCTAssertNil(state)
    }
}
