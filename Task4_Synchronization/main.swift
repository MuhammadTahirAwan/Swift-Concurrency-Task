import Foundation

func executeTask(_ taskNumber: Int, delay: UInt32) {
    print("Task \(taskNumber) started")
    sleep(delay) // Simulate work
    print("Task \(taskNumber) finished")
}

func executeTasks() {
    let queue1 = DispatchQueue(label: "com.example.queue1", attributes: .concurrent)
    let queue2 = DispatchQueue(label: "com.example.queue2", attributes: .concurrent)
    let queueFinal = DispatchQueue(label: "com.example.finalQueue")
    
    let dispatchGroup = DispatchGroup()
    
    dispatchGroup.enter()
    queue1.async {
        executeTask(1, delay: 2)
        dispatchGroup.leave() // ✅ Task 1 leaves
    }
    
    dispatchGroup.enter()
    queue2.async {
        executeTask(2, delay: 3)
        dispatchGroup.leave() // ✅ Task 2 leaves
    }
    

    dispatchGroup.notify(queue: queueFinal) {
        print("All Previous Tasks Complete")
        executeTask(3, delay: 1)
        exit(0) // Clean exit after Task 3 finishes
    }
}

executeTasks()

// Keep the CLI process alive until exit(0) is called
dispatchMain()
