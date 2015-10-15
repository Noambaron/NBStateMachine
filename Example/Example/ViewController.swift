//
//  ViewController.swift
//  Example
//
//  Created by Noam on 10/14/15.
//  Copyright © 2015 Noam. All rights reserved.
//

import UIKit
import NBStateMachine

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        //states
        let stateLyingDown = State(name: "Lying Down")
        let stateStanding = State(name: "Standing")
        let stateSitting = State(name: "Sitting Down")
        let stateRunning = State(name: "Running")

        
        //events
        let eventSitDown = Event(eventName: "Sit Down", sourceStates: [stateStanding, stateLyingDown], destinationState: stateSitting)
        eventSitDown.willFireEvent = { (event:Event) -> Bool in
            print("I'm about to sit down")
            return true
        }
        eventSitDown.didFireEvent = { (event:Event) -> Void in
            print("I'm am siting down")
        }
        

        
        let eventStandUp = Event(eventName: "Stand Up", sourceStates: [stateSitting, stateRunning], destinationState: stateStanding)
        eventStandUp.willFireEvent = { (event:Event) -> Bool in
            print("I'm about to Stand")
            return true
        }
        eventStandUp.didFireEvent = { (event:Event) -> Void in
            print("I'm am Standing")
        }
        
        
        let eventStartRunning = Event(eventName: "Start Running", sourceStates: [stateStanding, stateRunning], destinationState: stateRunning)
        eventStartRunning.willFireEvent = { (event:Event) -> Bool in
            print("I'm about to Start running")
            return true
        }
        eventStartRunning.didFireEvent = { (event:Event) -> Void in
            print("I'm am Running")
        }

        
        //initiate NBStateMachine
        let machine = NBStateMachine(initialState: stateLyingDown)
        machine.addStates([stateSitting, stateRunning, stateStanding])
        machine.addEvents([eventSitDown, eventStandUp, eventStartRunning])
        
        
        
        //fire an event
        let transition = machine.fireEvent(eventSitDown) //try also eventStandUp, eventStartRunning
        printTransition(transition)
        
        let wrongTransition = machine.fireEvent(eventStartRunning) //will not fire because you cannot start running when your state is sitting down
        printTransition(wrongTransition)

//        machine.fireEvent(eventStandUp)
//        machine.fireEvent(eventStartRunning)
//        machine.fireEvent(eventStandUp)
//        machine.fireEvent(eventSitDown)
        
    }

    func printTransition(transition:Transition) {
        
        print("transition from State:\(transition.sourceState.name)  to State:\(transition.destinationState.name) was successful :\(transition.successful) with error:\(transition.error?.description)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

