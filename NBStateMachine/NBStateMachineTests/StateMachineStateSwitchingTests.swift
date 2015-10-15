//
//  TransporterTests.swift
//  NBStateMachine
//
//  Created by Noam on 10/13/15.
//  Copyright © 2015 Noam. All rights reserved.
//

import XCTest
import NBStateMachine

class StateMachineStateSwitchingTests: XCTestCase {

    var machine: NBStateMachine!
    
    override func setUp() {
        super.setUp()
        let initial = State(name: "0")
        machine = NBStateMachine(initialState: initial)
    }
    
    func testStateMachineStates() {
        XCTAssert(machine.isInState("0"))
        XCTAssertFalse(machine.isInState("4"))
    }
    
    func testStateAvailable() {
        XCTAssert(machine.isStateAvailable("0"))
        XCTAssertFalse(machine.isStateAvailable("4"))
    }
    
    func testActivate() {
        XCTAssert(machine.isInState("0"))
    }
    
    func testWillEnterStateBlock() {
        let state = State(name: "3")
        var blockCalled = false
        state.willEnterStateNamed = { enteringStateNamed in
            XCTAssert(enteringStateNamed == state.name)
            blockCalled = true
        }
        
        machine.addState(state)
        machine.activateStateNamed("3")
        XCTAssert(blockCalled)
    }
    
    func testDidEnterStateBlock() {
        let state = State(name: "4")
        var blockCalled = false
        state.didEnterStateNamed = { enteringStateNamed in
            XCTAssert(enteringStateNamed == state.name)
            blockCalled = true
        }
        
        machine.addState(state)
        machine.activateStateNamed("4")
        XCTAssert(blockCalled)
    }
    
    func testWillExitStateBlock() {
        let state = State(name: "3")
        var blockCalled = false
        state.willExitStateNamed = { exitingStateNamed in
            XCTAssert(exitingStateNamed == state.name)
            blockCalled = true
        }
        machine.addState(state)
        machine.activateStateNamed("3")
        machine.activateStateNamed("0")
        XCTAssert(blockCalled)
    }
    
    func testDidExitStateBlock() {
        let state = State(name: "3")
        var blockCalled = false
        state.didExitStateNamed = { exitingStateNamed in
            XCTAssert(exitingStateNamed == state.name)
            blockCalled = true
        }
        machine.addState(state)
        machine.activateStateNamed("3")
        machine.activateStateNamed("0")
        XCTAssert(blockCalled)
    }
}
