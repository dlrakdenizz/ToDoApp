//
//  TasksViewController.swift
//  ToDoApp
//
//  Created by Dilara Akdeniz on 20.05.2025.
//


import UIKit
import FirebaseAuth
private let reuseIdentifier = "TasksCell"
class TasksViewController: UIViewController {
    // MARK: - Properties
    var user: User?{
        didSet{ configure() } //Buranın içerisine herhangi bir şey geldiğinde configure fonk çalıştır.
    }
    private var tasks = [Task]()
    private lazy var newTaskButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus.diamond.fill"), for: .normal)
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleNewTaskButton), for: .touchUpInside)
        return button
    }()
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        return collectionView
    }()
    private let nameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.textColor = .white
        label.text = " "
        return label
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}
// MARK: - Service
extension TasksViewController{
    private func fetchTasks(){
        guard let uid = self.user?.uid else { return }
        Service.fetchTasks(uid: uid) { tasks in
            self.tasks = tasks
            self.collectionView.reloadData()
        }
    }
}
// MARK: - Selector
extension TasksViewController{
    @objc private func handleNewTaskButton(_ sender: UIButton){
        let controller = NewTaskViewController()
        if let sheet = controller.sheetPresentationController{
            sheet.detents = [.medium()] //Sayfanın yarım açılması için bu kodu yazdık.
        }
        self.present(controller, animated: true)
    }
}
// MARK: - Helpers
extension TasksViewController{
    private func style(){
        backgroundGradientColor()
        self.navigationController?.navigationBar.isHidden = true
        newTaskButton.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(TaskCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        nameLabel.translatesAutoresizingMaskIntoConstraints =  false
    }
    private func layout(){
        view.addSubview(collectionView)
        view.addSubview(newTaskButton)
        view.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: newTaskButton.bottomAnchor, constant: 30),
            view.trailingAnchor.constraint(equalTo: newTaskButton.trailingAnchor, constant: 4),
            newTaskButton.heightAnchor.constraint(equalToConstant: 60),
            newTaskButton.widthAnchor.constraint(equalToConstant: 60),
            
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            
            collectionView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 14)
        ])
    }
    private func configure(){
        guard let user = self.user else { return }
        nameLabel.text = "Hi \(user.name) 👋🏻"
        fetchTasks()
    }
}
// MARK: - UICollectionViewDelegate ,UICollectionViewDataSource
extension TasksViewController: UICollectionViewDelegate ,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasks.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TaskCell
        cell.task = tasks[indexPath.row]
        cell.index = indexPath.row
        cell.delegate = self
        return cell
    }
}
extension TasksViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = TaskCell(frame: .init(x: 0, y: 0, width: view.frame.width * 0.9, height: 50))
        cell.task = tasks[indexPath.row]
        cell.layoutIfNeeded()
        let copySize = cell.systemLayoutSizeFitting(.init(width: view.frame.width * 0.9, height: 1000))
        return .init(width: view.frame.width * 0.9, height: copySize.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: 10, height: 10)
    }
}
// MARK: - TaskCellProtocol
extension TasksViewController: TaskCellProtocol{
    func deleteTask(sender: TaskCell, index: Int) {
        sender.reload()
        self.tasks.remove(at: index)
        self.collectionView.reloadData()
    }
    
}
