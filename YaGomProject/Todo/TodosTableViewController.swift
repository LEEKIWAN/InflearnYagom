//
//  TodosTableViewController.swift
//  YaGomProject
//
//  Created by 이기완 on 03/02/2019.
//  Copyright © 2019 이기완. All rights reserved.
//

import UIKit
import UserNotifications

class TodosTableViewController: UITableViewController {
    
    private var todos: [Todo] = Todo.all
    
    private let dateFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.timeStyle = DateFormatter.Style.short
        return formatter
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.todos = Todo.all
        self.tableView.reloadData()
    }

    
    /// 테이블뷰의 섹션 별 로우 수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todos.count
    }
    
    /// 인덱스에 해당하는 cell 반환
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 스토리보드에 구현해 둔 셀을 재사용 큐에서 꺼내옴
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
        
        guard indexPath.row < self.todos.count else {
            return cell
        }
        
        let todo: Todo = self.todos[indexPath.row]
        
        // 셀에 내용 설정
        cell.textLabel?.text = todo.title
        cell.detailTextLabel?.text = self.dateFormatter.string(from: todo.due)
        
        return cell
    }

    // 테이블뷰의 셀을 삭제/추가 하기 위한 메서드
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            guard self.todos.count > indexPath.row else { return }
            let todoToRemove: Todo = self.todos[indexPath.row]
            if Todo.remove(id: todoToRemove.id) {
                self.todos = Todo.all
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    @IBAction func onCloseTouched(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let todoViewController: TodoViewController = segue.destination as? TodoViewController else {
            return
        }
        
        guard let cell: UITableViewCell = sender as? UITableViewCell else {
            return
        }
        
        guard let index: IndexPath = self.tableView.indexPath(for: cell) else {
            return
        }
        
        guard index.row < todos.count else { return }
        let todo: Todo = todos[index.row]
        todoViewController.todo = todo
    }
}



/// User Notification의 delegate 메서드 구현
extension TodosTableViewController: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let idToShow: String = response.notification.request.identifier
        
        guard let todoToShow: Todo = self.todos.filter({ (todo: Todo) -> Bool in
            return todo.id == idToShow
        }).first else {
            return
        }
        
        guard let todoViewController: TodoViewController = self.storyboard?.instantiateViewController(withIdentifier: TodoViewController.storyBoardID) as? TodoViewController else { return }
        
        todoViewController.todo = todoToShow
        
        self.navigationController?.pushViewController(todoViewController, animated: true)
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        completionHandler()
    }
    
    
}
