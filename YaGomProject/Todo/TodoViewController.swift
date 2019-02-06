//
//  TodoViewController.swift
//  YaGomProject
//
//  Created by 이기완 on 03/02/2019.
//  Copyright © 2019 이기완. All rights reserved.
//

import UIKit

class TodoViewController: UIViewController, UITextFieldDelegate {

    private enum Mode {
        case edit, view
    }
    
    var todo: Todo?
    
    private var mode: Mode = Mode.edit {
        didSet {
            self.titleTextField.isUserInteractionEnabled = (mode == .edit)
            self.memoTextView.isEditable = (mode == .edit)
            self.datePicker.isUserInteractionEnabled = (mode == .edit)
            self.shouldNotifySwitch.isEnabled = (mode == .edit)
            
            if mode == Mode.edit {
                if todo == nil {
                    self.navigationItem.leftBarButtonItems = [self.cancelButton]
                }
                else {
                    self.navigationItem.rightBarButtonItems = [self.doneButton, self.cancelButton]
                }
            } else {
                self.navigationItem.rightBarButtonItems = [self.editButton]
            }
        }
    }
    
    /// 수정 - 내비게이션 바 버튼
    private var editButton: UIBarButtonItem {
        let button: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.edit,
                                                      target: self,
                                                      action: #selector(onEditTouched(_:)))
        return button
    }
    
    /// 취소 - 내비게이션 바 버튼
    private var cancelButton: UIBarButtonItem {
        let button: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel,
                                                      target: self,
                                                      action: #selector(onCancelTouched(_:)))
        return button
    }
    
    /// 완료 - 내비게이션 바 버튼
    private var doneButton: UIBarButtonItem {
        let button: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done,
                                                      target: self,
                                                      action: #selector(onDoneTouched(_:)))
        return button
    }
    
    static let storyBoardID: String = "TodoViewController"
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var memoTextView: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var shouldNotifySwitch: UISwitch!
    

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 텍스트 필드 delegate 설정
        self.titleTextField.delegate = self
        
        // 이전 화면에서 전달받은 todo가 없다면 새로운 작성화면 설정
        if self.todo == nil {
            self.navigationItem.leftBarButtonItem = self.cancelButton
            self.navigationItem.rightBarButtonItem = self.doneButton
        } else {
            self.navigationItem.rightBarButtonItem = self.editButton
        }
        
        // 화면 초기화
        self.initializeView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 수정 모드라면 텍스트 필드에 바로 입력할 수 있도록 키보드 보여줌
        if self.mode == Mode.edit {
            self.titleTextField.becomeFirstResponder()
        }
    }
    
    private func initializeView() {
        if let todo: Todo = self.todo {
            self.navigationItem.title = todo.title
            self.titleTextField.text =  todo.title
            self.memoTextView.text = todo.memo
            self.datePicker.date = todo.due
            self.mode = Mode.view
        }
    }
    
    /// 간단한 얼럿을 보여줄 때 코드 중복을 줄이기위한 메서드
    private func showSimpleAlert(message: String, cancelTitle: String = "확인", cancelHandler: ((UIAlertAction) -> Void)? = nil) {
        let alert: UIAlertController = UIAlertController(title: "알림", message: message, preferredStyle: UIAlertController.Style.alert)
        let action: UIAlertAction = UIAlertAction(title: cancelTitle, style: UIAlertAction.Style.cancel, handler: cancelHandler)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc private func onEditTouched(_ sender: UIBarButtonItem) {
        self.mode = Mode.edit
    }
    
    /// 취소 버튼을 눌렀을 때
    @objc private func onCancelTouched(_ sender: UIBarButtonItem) {
        
        if self.todo == nil {
            // 이전 화면에서 전달받은 todo가 없다면 새로 작성을 위한 상태이므로 모달을 내려주고
            self.navigationController?.presentingViewController?.dismiss(animated: true, completion: nil)
        } else {
            // 그렇지 않으면 다시 원래 todo 상태로 화면을 초기화 해줌
            self.initializeView()
        }
    }
    
    /// 완료 버튼을 눌렀을 때
    @objc private func onDoneTouched(_ sender: UIBarButtonItem) {
        
        // todo 제목은 필수사항이므로 입력했는지 확인
        guard let title: String = self.titleTextField.text, title.isEmpty == false else {
                self.showSimpleAlert(message: "제목은 꼭 작성해야합니다", cancelHandler: { (action: UIAlertAction) in self.titleTextField.becomeFirstResponder()})
                return
        }
        
        // 새로운 todo 생성
        let todo: Todo
        todo = Todo(title: title,
                    due: self.datePicker.date,
                    memo: self.memoTextView.text,
                    shouldNotify: self.shouldNotifySwitch.isOn,
                    id: self.todo?.id ?? String(Date().timeIntervalSince1970)) /// 유닉스 타임스템프를 할 일 고유 아이디로 활용
        
        let isSuccess: Bool
        
        if self.todo == nil {
            // 새로 작성하기 위한 상태라면 저장을 완료하고 모달을 내려줌
            isSuccess = todo.save {
                self.navigationController?.presentingViewController?.dismiss(animated: true, completion: nil)
            }
        } else {
            // 수정상태라면 저장을 완료하고 화면을 보기모드로 전환
            isSuccess = todo.save(completion: {
                self.todo = todo
                self.mode = Mode.view
            })
        }
        
        // 저장에 실패하면 알림
        if isSuccess == false {
            self.showSimpleAlert(message: "저장 실패")
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.navigationItem.title = textField.text
    }
}
