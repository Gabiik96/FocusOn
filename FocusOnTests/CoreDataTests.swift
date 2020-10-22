//
//  FocusOnTests.swift
//  FocusOnTests
//
//  Created by Gabriel Balta on 20/08/2020.
//  Copyright © 2020 Gabriel Balta. All rights reserved.
//

import XCTest
@testable import FocusOn

class CoreDataTests: XCTestCase {

    var coreData: DataController!
    private let context = AppDelegate.context
    
    override func setUp() {
        self.coreData = DataController.shared
        
    }
    
    func testCreateNewGoal() {
        let goal = coreData.createEmptyGoalWithEmptyTasks(moc: context)
        goal.title = "AaA"
        
        XCTAssert(goal.title == "AaA", "Failed to create goal")
        
        XCTAssert(goal.tasks.count == 3, "Goal doesn't have right amount of tasks \(goal.tasks.count)")
        context.delete(goal)
    }
    
    func testUpdateGoal() {
        let goal = coreData.createEmptyGoalWithEmptyTasks(moc: context)
        coreData.updateGoal(goal: goal, newTitle: "Test", moc: context)
        
        XCTAssert(goal.title == "Test", "Failed to update goal \(goal.title)")
        context.delete(goal)
    }
    
    func testCreateUpdateTask() {
        let goal = coreData.createEmptyGoalWithEmptyTasks(moc: context)
        goal.title = "AaA"
        
        coreData.createEmptyTask(moc: context, goal: goal)
        for task in goal.tasks {
            coreData.updateTask(task: task as! Task, newTitle: "Test", moc: context)
            XCTAssert((task as! Task).title == "Test", " Failed to update task")
        }
        
        XCTAssert(goal.tasks.count == 4, "Goal doesn't have right amount of tasks \(goal.tasks.count)")
        context.delete(goal)
    }
}
