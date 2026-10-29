import Foundation

class Counter: @unchecked Sendable {
    var value = 0
    func increment() { value += 1 }
}

func runCounterTask() {
    let counter = Counter()
    
    let semaphore = DispatchSemaphore(value: 0)
    let serialQueue = DispatchQueue(label: "com.tahir.SerialQueue1")
    
    serialQueue.async {
        
        for _ in 1...1000 {
            counter.increment()
        }
    }
    
    serialQueue.async {
        
        for _ in 1...1000 {
            counter.increment()
        }
        
        semaphore.signal()
    }
    
    //  Main thread waits here until signal() is fired
    semaphore.wait()
    
    print("Final counter value: \(counter.value) (Guaranteed: 2000)\n")
}

runCounterTask()





// MARK: - Task 2: Semaphore Concurrency Limiter
let semaphore = DispatchSemaphore(value: 2)

func performTask(id: Int) {
    semaphore.wait()
    defer { semaphore.signal() }
    print("Task \(id) started")
    sleep(1)
    print("Task \(id) finished")
}

func runSemaphoreTask() {
    let threads = (1...5).map { id in
        Thread { performTask(id: id) }
    }
    threads.forEach { $0.start() }
    Thread.sleep(forTimeInterval: 5)
}

// --- Run whichever exercise you want to test ---
// runCounterTask()
runSemaphoreTask()
