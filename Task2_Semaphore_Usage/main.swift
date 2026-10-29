//
//  main.swift
//  Task2_Semaphore_Usage
//
//  Created by Tahir Awan on 28/10/2026.
//

import Foundation

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
