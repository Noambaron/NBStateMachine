//
//  NBStateMachine.swift
//  NBStateMachine
//
//  Created by Noam on 10/13/15.
//  Copyright © 2015 Noam. All rights reserved.
//

import Foundation


public struct Errors {
    public static let stateMachineDomain = "com.NBStateMachine"
    
    /**
    Enum with possible transition errors. These are meant to be used inside fireEvent method on StateMachine. They will be included as status codes inside NSError, that Transition.Error enum returns.
    */
    public enum TransitionError: Int {
        
        /**
        When event's willFireEvent closure returns false, `TransitionDeclined` error will be returned as a status code inside NSError object.
        */
        case TransitionDeclined
        
        /**
        `UnknownEvent` means there's no such event on `StateMachine`.
        */
        case UnknownEvent
        
        /**
        `WrongSourceState` means, that source states for this fired event do not include state, in which StateMachine is currently in.
        */
        case WrongSourceState
    }
}
    
    
    public class NBStateMachine: NSObject {
        
        var initialState: State?
        
        //init methods
        
        private var currentState : State
        private lazy var availableStates = Array<State>()
        private lazy var events = Array<Event>()
        
        required public init(initialState: State)
        {
            self.initialState = initialState
            self.currentState = initialState
            super.init()
            availableStates.append(initialState)
        }
        
        convenience public init(initialStateName: String)
        {
            self.init(initialState:State(name: initialStateName))
        }
        
        convenience public init(initialState: State, states: Array<State>)
        {
            self.init(initialState: initialState)
            self.availableStates.appendContentsOf(states)
        }
        
        /**
        Activate state, as long as it's present in `StateMachine`. This method is not tied to events.
        */
        public func activateStateNamed(stateName: String) {
            if (isStateAvailable(stateName))
            {
                let oldState = currentState
                let newState = findStateWithName(stateName)!
                
                newState.willEnterStateNamed?(enteringStateName: newState.name)
                oldState.willExitStateNamed?(exitingStateName: oldState.name)
                
                currentState = newState
                
                oldState.didExitStateNamed?(exitingStateName: oldState.name)
                newState.didEnterStateNamed?(enteringStateName: currentState.name)
            }
        }
        

        
        /**
        If state is present in available states in `StateMachine`, this method will return true. This method does not check events on `StateMachine`.
        */
        public func isStateAvailable(stateName: String) -> Bool {
            let states = availableStates.filter { (state) -> Bool in
                return state.name == stateName
            }
            if (states.count > 0) {
                return true
            }
            return false
        }

        public func addState(state: State) {
            availableStates.append(state)
        }
        
        public func addStates(states: Array<State>) {
            availableStates.appendContentsOf(states)
        }
        
        public func isInState(stateNamed: String) -> Bool {
            return stateNamed == currentState.name
        }

        /**
        Add event to `StateMachine`. This method checks, whether source states and destination state of event are present in `StateMachine`. If not - event will not be added, and this method will return false.
        */
        public func addEvent(event: Event) -> Bool {
            if event.sourceStates.isEmpty
            {
                print("Source states array is empty, when trying to add event.")
                return false
            }
            
            for state in event.sourceStates
            {
                if (self.findStateWithName(state.name) == nil)
                {
                    print("thid event has a Source state named \(state.name) that is not present in state machine")
                    return false
                }
            }
            if (self.findStateWithName(event.destinationState.name) == nil) {
                print("thid event has a Destination state named: \(event.destinationState.name)) that is not present in state machine")
                return false
            }
            
            self.events.append(event)
            return true
        }

        public func findStateWithName(name: String) -> State? {
            return availableStates.filter { (state) -> Bool in
                return state.name == name
                }.first
        }
        
        public func findEventWithName(name: String) -> Event? {
            return events.filter { (event) -> Bool in
                return event.name == name
                }.first
        }
        

        /**
        Add multiple events to `StateMachine`. if source states and destination state of event are not present in `StateMachine` - event will not be added.
        */
        public func addEvents(events: Array<Event>) {
            for event in events
            {
                let addingEvent = self.addEvent(event)
                if addingEvent == false {
                    print("failed adding event with name: %@",event.name)
                }
            }
        }
        
        public func canFireEventNamed(eventName: String) -> (canFire: Bool, error: Errors.TransitionError?) {
            
            if let event = findEventWithName(eventName) { //if event is available in StateMachine
                
                if event.sourceStates.contains(currentState) { // if the stateMachine's current state is the right one for this event
                    return (true,nil)
                }else {
                    return (false,Errors.TransitionError.WrongSourceState)
                }

            }else { //event is NOT available in StateMachine
                return (false,Errors.TransitionError.UnknownEvent)
            }
        }
        

        /**
        Fires event. Several checks are made along the way:
        
        1. Event is present in StateMachine. If not - error includes UnknownEvent transition error
        2. Event source states include current StateMachine state. If not - error includes WrongSourceState transition error
        3. Event shouldFireEvent closure is fired. If it returned false - error includes TransitionDeclined transition error.
        
        If all conditions passed, event is fired, all closures are fired, and StateMachine changes it's state to event.destinationState.
        */
        public func fireEvent(event: Event) -> Transition {
            
            let eventRequestResults = canFireEventNamed(event.name)
            
            switch eventRequestResults {
                
            case (true, _): //event is approved
                
                if (event.willFireEvent != nil) { //there is a block for willFireEvent
                    
                    let sourceState = self.currentState
                    let eventFired = event.willFireEvent!(event: event)
                    if eventFired == true {
                        activateStateNamed(event.destinationState.name)
                        event.didFireEvent?(event: event)
                        
                        return Transition(successful: true, sourceState: sourceState, destinationState: event.destinationState, error: nil)
                        
                    }else { //eventFired == false because willFireEvent returned False
                        
                        let error = NSError(domain: Errors.stateMachineDomain, code: Errors.TransitionError.TransitionDeclined.rawValue, userInfo: nil)
                        return Transition(successful: false, sourceState: sourceState, destinationState: event.destinationState, error: error)
                    }
                    
                } else { //there is NO block for willFireEvent, stateMachine fires event now
                    
                    let sourceState = self.currentState
                    activateStateNamed(event.destinationState.name)
                    event.didFireEvent?(event: event)
                    
                    return Transition(successful: true, sourceState: sourceState, destinationState: event.destinationState, error: nil)
                }
                
            case (false, let error): //event is declined as it is not valid from the "canFireEventNamed(event.name)" function- propogate error
                
                let sourceState = self.currentState
                
                let error = NSError(domain: Errors.stateMachineDomain, code:error!.rawValue,userInfo: nil)
                return Transition(successful: false, sourceState:sourceState , destinationState: event.destinationState, error: error)
            }
        }
        

        

}

















    
