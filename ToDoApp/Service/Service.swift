//
//  Service.swift
//  ToDoApp
//
//  Created by Dilara Akdeniz on 20.05.2025.
//


import Foundation
import FirebaseAuth
import FirebaseFirestore
struct Service {
    static private var pastTasks = [Task]()
    static private var tasks = [Task]()
    static func sendTask(text: String, completion: @escaping(Error?)-> Void){
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let taskId = NSUUID().uuidString
        let data = [
            "text": text,
            "timestamp": Timestamp(date: Date()),
            "taskId": taskId
        ] as [String: Any]
        COLLECTION_TASKS.document(currentUid).collection("ongoing_tasks").document(taskId).setData(data,completion: completion)
    }
    static func deleteTask(task: Task){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let data = [
            "text": task.text,
            "taskId": task.taskId,
            "timestamp": Timestamp(date: Date())
        ] as [String: Any]
        COLLECTION_TASKS.document(uid).collection("completed_tasks").document(task.taskId).setData(data) { error in
            if let error = error{
                print("Error: \(error.localizedDescription)")
                return
            }
            COLLECTION_TASKS.document(uid).collection("ongoing_tasks").document(task.taskId).delete()
        }
        
        
        
    }
    
    static func fetchUser(uid: String, completion: @escaping(User)-> Void){
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            guard let data = snapshot?.data() else{ return }
            let user = User(data: data)
            completion(user)
        }
        
    }
    static func fetchTasks(uid: String ,completion: @escaping([Task])->Void){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_TASKS.document(uid).collection("ongoing_tasks").order(by: "timestamp").addSnapshotListener { snaphot, error in
            tasks = []
            if let documents = snaphot?.documents{
                for doc in documents{
                    let data = doc.data()
                    tasks.append(Task(data: data))
                    completion(tasks)
                }
            }
        }
    }
    static func fetchPastTasks(uid: String ,completion: @escaping([Task])->Void){
        guard let uid = Auth.auth().currentUser?.uid else { return }
       
        COLLECTION_TASKS.document(uid).collection("completed_tasks").order(by: "timestamp").addSnapshotListener { snaphot, error in
            pastTasks = []
            if let documents = snaphot?.documents{
                for doc in documents{
                    let data = doc.data()
                    pastTasks.append(Task(data: data))
                    completion(pastTasks)
                }
            }
        }
    }
}
