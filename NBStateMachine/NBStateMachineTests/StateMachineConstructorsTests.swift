//
//  StateMachineConstructorsTests.swift
//  NBStateMachine
//
//  Created by Noam on 10/13/15.
//  Copyright © 2015 Noam. All rights reserved.
//

import NBStateMachine
import XCTest

class StateMachineConstructorsTests: XCTestCase {

    let state = State(name: "0")
    let stateOne = State(name: "1")
    let stateTwo = State(name: "2")
    
    func testStateConvenienceConstructor() {
        
        let machine = NBStateMachine(initialState: state, states: [stateOne,stateTwo])
        
        XCTAssertTrue(machine.isStateAvailable(state.name))
        XCTAssertTrue(machine.isStateAvailable(stateOne.name))
        XCTAssertTrue(machine.isStateAvailable(stateTwo.name))
    }
}
