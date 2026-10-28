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
    
    print("Final counter value: \(counter.value) (Guaranteed: 2000)")
}

runCounterTask()
