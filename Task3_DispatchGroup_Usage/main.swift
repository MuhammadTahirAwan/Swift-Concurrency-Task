//
//  main.swift
//  Task3_DispatchGroup_Usage
//
//  Created by Tahir Awan on 29/10/2026.
//

import Foundation

func fetchData(from source: String, completion: @escaping () -> Void) {
    print("\(source) - Fetching data...")
    sleep(2) // Simulate network delay
    print("\(source) - Data fetched ✅")
    completion()
}

func runGCDTask() {
    
    
    let dispatchGroup = DispatchGroup()
    let queue = DispatchQueue.global(qos: .userInitiated)
    
    let sources = ["API 1", "API 2", "API 3"]
    
    for source in sources {
        
        dispatchGroup.enter()
        queue.async {
            fetchData(from: source) {
                print("\(source) - Processing complete")
                dispatchGroup.leave()
            }
            
            
        }
    }
    
    dispatchGroup.wait()
    print("✅ All tasks started. Updating UI...")
//    dispatchGroup.notify(queue: DispatchQueue.main){
//        print("✅ All tasks started. Updating UI...") // 🔴 Issue: This runs before all tasks complete!
//    }
}

runGCDTask()
